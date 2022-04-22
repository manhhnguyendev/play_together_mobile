import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/enter_withdraw_amount.dart';
import 'package:play_together_mobile/pages/hiring_negotiating_page.dart';
import 'package:play_together_mobile/pages/hiring_stage_page.dart';
import 'package:play_together_mobile/pages/login_page.dart';
import 'package:play_together_mobile/pages/manage_hiring_page.dart';
import 'package:play_together_mobile/pages/personal_change_password_page.dart';
import 'package:play_together_mobile/pages/policies_page.dart';
import 'package:play_together_mobile/pages/receive_request_page.dart';
import 'package:play_together_mobile/pages/select_deposit_method.dart';
import 'package:play_together_mobile/pages/statistics_page.dart';
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
import 'package:google_fonts/google_fonts.dart';

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
  List<OrderModel> _listOrder = [];
  late GoogleSignIn _googleSignIn;
  bool checkBalance = false;

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
                    height: 40,
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
                                  style: GoogleFonts.montserrat(fontSize: 20),
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
                                    children: [
                                      Text(
                                        'Chỉnh sửa tài khoản',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Icon(
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
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Số dư trong ví:',
                                  style: GoogleFonts.montserrat(fontSize: 18),
                                ),
                                Row(children: [
                                  Text(
                                    (lateUser != null
                                        ? lateUser!.userBalance.balance
                                            .toStringAsFixed(0)
                                            .toVND()
                                        : widget.userModel.userBalance.balance
                                            .toStringAsFixed(0)
                                            .toVND()),
                                    style: GoogleFonts.montserrat(
                                        fontSize: 22,
                                        color: const Color(0xff320444)),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      FontAwesomeIcons.arrowsRotate,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        Future<bool?> checkBalanceFuture =
                                            UserService().checkBalance(
                                                widget.tokenModel.message);
                                        checkBalanceFuture.then((value) {
                                          if (value == true) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Cập nhật số dư thành công"),
                                            ));
                                          }
                                        });
                                      });
                                    },
                                  )
                                ]),
                                Row(
                                  children: [
                                    Text(
                                      'Số khả dụng: ',
                                      style:
                                          GoogleFonts.montserrat(fontSize: 15),
                                    ),
                                    Text(
                                      lateUser != null
                                          ? lateUser!.userBalance.activeBalance
                                              .toStringAsFixed(0)
                                              .toVND()
                                          : widget.userModel.userBalance
                                              .activeBalance
                                              .toStringAsFixed(0)
                                              .toVND(),
                                      style: GoogleFonts.montserrat(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Container(
                            decoration: BoxDecoration(border: Border.all()),
                            height: 110,
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
                                              SelectDepositMethodPage(
                                                tokenModel: widget.tokenModel,
                                                userModel: widget.userModel,
                                              )),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      const Icon(
                                        FontAwesomeIcons.wallet,
                                        size: 30,
                                      ),
                                      const SizedBox(
                                        height: 0,
                                      ),
                                      Text(
                                        'Nạp tiền',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 15,
                                            color: const Color(0xff320444)),
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
                                              const EnterWithdrawAmount()),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      const Icon(
                                        FontAwesomeIcons.moneyBill,
                                        size: 30,
                                      ),
                                      const SizedBox(
                                        height: 0,
                                      ),
                                      Text(
                                        'Rút tiền',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 15,
                                            color: const Color(0xff320444)),
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
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
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
                        children: [
                          Text(
                            'Lịch sử Giao dịch',
                            style: GoogleFonts.montserrat(fontSize: 20),
                          ),
                          const Spacer(),
                          const Icon(
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
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ManageHiringPage(
                                tokenModel: widget.tokenModel,
                                userModel: widget.userModel,
                              ),
                            ));
                      },
                      child: Row(
                        children: [
                          Text(
                            'Quản lý nhận thuê',
                            style: GoogleFonts.montserrat(fontSize: 20),
                          ),
                          const Spacer(),
                          const Icon(
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
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
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
                        children: [
                          Text(
                            'Cài đặt sở thích',
                            style: GoogleFonts.montserrat(fontSize: 20),
                          ),
                          const Spacer(),
                          const Icon(
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
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
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
                        children: [
                          Text(
                            'Thay đổi mật khẩu',
                            style: GoogleFonts.montserrat(fontSize: 20),
                          ),
                          const Spacer(),
                          const Icon(
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
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StatisticsPage(
                                userModel: widget.userModel,
                                tokenModel: widget.tokenModel,
                              ),
                            ));
                      },
                      child: Row(
                        children: [
                          Text(
                            'Thống kê',
                            style: GoogleFonts.montserrat(fontSize: 20),
                          ),
                          const Spacer(),
                          const Icon(
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
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PoliciesPage(),
                            ));
                      },
                      child: Row(
                        children: [
                          Text(
                            'Chính sách',
                            style: GoogleFonts.montserrat(fontSize: 20),
                          ),
                          const Spacer(),
                          const Icon(
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
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text(
                            'Trung tâm hỗ trợ',
                            style: GoogleFonts.montserrat(fontSize: 20),
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
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
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
                                    Fluttertoast.showToast(
                                        msg: "Đăng xuất thành công",
                                        textColor: Colors.white,
                                        backgroundColor: const Color.fromRGBO(
                                            137, 128, 255, 1),
                                        toastLength: Toast.LENGTH_SHORT);
                                  }
                                });
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'Đăng xuất',
                                    style: GoogleFonts.montserrat(fontSize: 20),
                                  ),
                                  const Spacer(),
                                  const Icon(
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
        } else if (value.content.status.contains('Hiring')) {
          Future<ResponseListModel<OrderModel>?> checkOrderUser = OrderService()
              .getOrderOfUser(widget.tokenModel.message, 'Starting');
          checkOrderUser.then(((orderUser) {
            if (orderUser!.content.isEmpty) {
              Future<ResponseListModel<OrderModel>?> checkOrderPlayer =
                  OrderService()
                      .getOrderOfPlayer(widget.tokenModel.message, 'Starting');
              checkOrderPlayer.then(((orderPlayer) {
                _listOrder = orderPlayer!.content;
                if (_listOrder[0].toUserId == widget.userModel.id) {
                  lateUser = value.content;
                  setState(() {
                    helper.pushInto(
                        context,
                        HiringPage(
                            orderModel: _listOrder[0],
                            tokenModel: widget.tokenModel,
                            userModel: lateUser!),
                        true);
                  });
                }
              }));
            } else {
              _listOrder = orderUser.content;
              if (_listOrder[0].userId == widget.userModel.id) {
                lateUser = value.content;
                setState(() {
                  helper.pushInto(
                      context,
                      HiringPage(
                          orderModel: _listOrder[0],
                          tokenModel: widget.tokenModel,
                          userModel: lateUser!),
                      true);
                });
              }
            }
          }));
        } else if (value.content.status.contains('Processing')) {
          Future<ResponseListModel<OrderModel>?> checkOrderUser = OrderService()
              .getOrderOfUser(widget.tokenModel.message, 'Processing');
          checkOrderUser.then(((orderUser) {
            if (orderUser!.content.isEmpty) {
              Future<ResponseListModel<OrderModel>?> checkOrderPlayer =
                  OrderService().getOrderOfPlayer(
                      widget.tokenModel.message, 'Processing');
              checkOrderPlayer.then(((orderPlayer) {
                _listOrder = orderPlayer!.content;
                if (_listOrder[0].toUserId == widget.userModel.id) {
                  lateUser = value.content;
                  setState(() {
                    helper.pushInto(
                        context,
                        ReceiveRequestPage(
                            orderModel: _listOrder[0],
                            tokenModel: widget.tokenModel,
                            userModel: lateUser!),
                        true);
                  });
                }
              }));
            } else {
              _listOrder = orderUser.content;
              if (_listOrder[0].userId == widget.userModel.id) {
                lateUser = value.content;
                Future<ResponseModel<PlayerModel>?> getPlayerModel =
                    UserService().getPlayerById(
                        _listOrder[0].toUserId, widget.tokenModel.message);
                getPlayerModel.then((playerModel) {
                  if (playerModel != null) {
                    setState(() {
                      helper.pushInto(
                          context,
                          HiringNegotiatingPage(
                              orderModel: _listOrder[0],
                              tokenModel: widget.tokenModel,
                              userModel: lateUser!,
                              playerModel: playerModel.content),
                          true);
                    });
                  }
                });
              }
            }
          }));
        }
      }
    });
    return getStatusUser;
  }
}
