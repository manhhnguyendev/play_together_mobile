import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/enter_withdraw_amount.dart';
import 'package:play_together_mobile/pages/login_page.dart';
import 'package:play_together_mobile/pages/personal_change_password_page.dart';
import 'package:play_together_mobile/pages/policies_page.dart';
import 'package:play_together_mobile/pages/receive_request_page.dart';
import 'package:play_together_mobile/pages/select_deposit_method.dart';
import 'package:play_together_mobile/pages/transaction_page.dart';
import 'package:play_together_mobile/pages/update_hobbies_page.dart';
import 'package:play_together_mobile/pages/user_profile_page.dart';
import 'package:play_together_mobile/services/logout_service.dart';
import 'package:play_together_mobile/widgets/bottom_bar.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/services/order_service.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

class PersonalPage extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;

  const PersonalPage({
    Key? key,
    required this.userModel,
    required this.tokenModel,
  }) : super(key: key);

  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  UserModel? lateUser;
  List<OrderModel>? _listOrder;
  late GoogleSignIn _googleSignIn;

  Future checkStatus() {
    Future<ResponseModel<UserModel>?> getStatusUser =
        UserService().getUserProfile(widget.tokenModel.message);
    getStatusUser.then((value) {
      if (value != null) {
        if (value.content.status.contains('Online')) {
          if (!mounted) return;
          setState(() {
            lateUser = value.content;
          });
        } else {
          Future<ResponseListModel<OrderModel>?> checkOrderUser =
              OrderService().getOrderOfPlayer(widget.tokenModel.message);
          checkOrderUser.then(((order) {
            _listOrder = order!.content;
            if (_listOrder![0].toUserId == widget.userModel.id) {
              lateUser = value.content;
              setState(() {
                helper.pushInto(
                    context,
                    ReceiveRequestPage(
                        orderModel: _listOrder![0],
                        tokenModel: widget.tokenModel,
                        userModel: lateUser!),
                    true);
              });
            }
          }));
        }
      }
    });
    return getStatusUser;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkStatus(),
        builder: (context, snapshot) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(widget.userModel.avatar),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.userModel.name,
                                  style: const TextStyle(fontSize: 20),
                                  maxLines: 2,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UserProfilePage(
                                              userModel: widget.userModel,
                                              tokenModel: widget.tokenModel)),
                                    );
                                  },
                                  child: Row(
                                    children: const [
                                      Text(
                                        'Chỉnh sửa tài khoản',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black)),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Số dư trong ví:',
                                  style: TextStyle(fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  lateUser != null
                                      ? lateUser!.userBalance.balance
                                          .toStringAsFixed(0)
                                          .toVND()
                                      : widget.userModel.userBalance.balance
                                          .toStringAsFixed(0)
                                          .toVND(),
                                  style: const TextStyle(
                                      fontSize: 22, color: Color(0xff320444)),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Container(
                            decoration: BoxDecoration(border: Border.all()),
                            height: 70,
                            width: 1,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SelectDepositMethodPage()),
                                    );
                                  },
                                  child: Column(
                                    children: const [
                                      Icon(
                                        FontAwesomeIcons.wallet,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        height: 0,
                                      ),
                                      Text(
                                        'Nạp tiền',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xff320444)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EnterWithdrawAmount()),
                                    );
                                  },
                                  child: Column(
                                    children: const [
                                      Icon(
                                        FontAwesomeIcons.moneyBill,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        height: 0,
                                      ),
                                      Text(
                                        'Rút tiền',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xff320444)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 25, 15, 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TransactionPage(
                                    tokenModel: widget.tokenModel,
                                    userModel: widget.userModel,
                                  )),
                        );
                      },
                      child: Row(
                        children: const [
                          Text(
                            'Lịch sử Giao dịch',
                            style: TextStyle(fontSize: 20),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => ManageHiringPage(),
                        //     ));
                      },
                      child: Row(
                        children: const [
                          Text(
                            'Quản lý nhận thuê',
                            style: TextStyle(fontSize: 20),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateHobbiesPage(
                                tokenModel: widget.tokenModel,
                                userModel: widget.userModel,
                              ),
                            ));
                      },
                      child: Row(
                        children: const [
                          Text(
                            'Cài đặt sở thích',
                            style: TextStyle(fontSize: 20),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PersonalChangePassword(
                                tokenModel: widget.tokenModel,
                                userModel: widget.userModel,
                              ),
                            ));
                      },
                      child: Row(
                        children: const [
                          Text(
                            'Thay đổi mật khẩu',
                            style: TextStyle(fontSize: 20),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PoliciesPage(),
                            ));
                      },
                      child: Row(
                        children: const [
                          Text(
                            'Chính sách',
                            style: TextStyle(fontSize: 20),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: const [
                          Text(
                            'Trung tâm hỗ trợ',
                            style: TextStyle(fontSize: 20),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                    child: FutureBuilder(
                        future: _initialization,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Something went wrong');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            _googleSignIn = GoogleSignIn();
                            return GestureDetector(
                              onTap: () {
                                Future<bool?> logoutModelFuture =
                                    LogoutService()
                                        .logout(widget.tokenModel.message);
                                logoutModelFuture.then((value) {
                                  if (value == true) {
                                    setState(() {
                                      _googleSignIn.signOut();
                                      helper.pushInto(
                                          context, const LoginPage(), true);
                                    });
                                    print('Đăng xuất thành công');
                                  }
                                });
                              },
                              child: Row(
                                children: const [
                                  Text(
                                    'Đăng xuất',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.logout,
                                    color: Colors.grey,
                                    size: 15,
                                  ),
                                ],
                              ),
                            );
                          }
                          return const CircularProgressIndicator();
                        }),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomBar(
              userModel: widget.userModel,
              tokenModel: widget.tokenModel,
              bottomBarIndex: 4,
            ),
          );
        });
  }
}
