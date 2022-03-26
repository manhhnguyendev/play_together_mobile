import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/manage_hiring_page.dart';
import 'package:play_together_mobile/pages/receive_request_page.dart';
import 'package:play_together_mobile/pages/user_profile_page.dart';
import 'package:play_together_mobile/widgets/bottom_bar.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;

import '../models/order_model.dart';
import '../services/order_service.dart';
import '../services/user_service.dart';

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
  UserModel? lateUser;
  List<OrderModel>? _listOrder;
//check status
  void check() {
    Future<UserModel?> checkStatus =
        UserService().getUserProfile(widget.tokenModel.message);

    checkStatus.then((value) {
      if (value != null) {
        if (value.status.contains('Online')) {
          print(value.status);
          setState(() {
            lateUser = value;
            //print("đổi nè");
          });
        } else {
          Future<List<OrderModel>?> checkPlayer = OrderService()
              .getAllOrdersForPlayer(widget.tokenModel.message, true, "");
          checkPlayer.then(((order) {
            setState(() {
              _listOrder = order;
              if (_listOrder![0].toUserId == widget.userModel.id) {
                print(value.status);
                setState(() {
                  lateUser = value;
                  helper.pushInto(
                      context,
                      ReceiveRequestPage(
                          //fromUserModel: _listOrder![0].user,
                          orderModel: _listOrder![0],
                          tokenModel: widget.tokenModel,
                          userModel: lateUser!),
                      true);
                });
              }
            });
          }));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    check();
    return Scaffold(
      body: Column(
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
                    backgroundImage: NetworkImage(widget.userModel.avatar),
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
                            if (lateUser != null)
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HirerProfilePage(
                                        userModel: lateUser!,
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
                              ? lateUser!.userBalance.balance.toString() +
                                  ' vnđ'
                              : widget.userModel.userBalance.balance
                                      .toString() +
                                  ' vnđ',
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
                          onTap: () {},
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
                                    fontSize: 15, color: Color(0xff320444)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () {},
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
                                    fontSize: 15, color: Color(0xff320444)),
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
              onTap: () {},
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ManageHiringPage(),
                    ));
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
              onTap: () {},
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
              onTap: () {},
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
            child: GestureDetector(
              onTap: () {},
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
            ),
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
      bottomNavigationBar: BottomBar(
        userModel: widget.userModel,
        tokenModel: widget.tokenModel,
        bottomBarIndex: 4,
      ),
    );
  }
}
