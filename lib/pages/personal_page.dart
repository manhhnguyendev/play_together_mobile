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
import 'package:play_together_mobile/pages/system_feedback_page.dart';
import 'package:play_together_mobile/pages/transaction_page.dart';
import 'package:play_together_mobile/pages/un_active_balance.dart';
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
  final double? balance;
  final double? activeBalance;

  const PersonalPage({
    Key? key,
    required this.userModel,
    required this.tokenModel,
    this.balance,
    this.activeBalance,
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
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
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
                                        'Ch???nh s???a t??i kho???n',
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
                                  'S??? d?? trong v??:',
                                  style: GoogleFonts.montserrat(fontSize: 18),
                                ),
                                Row(children: [
                                  Text(
                                    widget.balance != null
                                        ? widget.balance!
                                            .toStringAsFixed(0)
                                            .toVND()
                                        : lateUser!.userBalance.balance
                                            .toStringAsFixed(0)
                                            .toVND(),
                                    style: GoogleFonts.montserrat(
                                        fontSize: 22,
                                        color: const Color(0xff320444)),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      FontAwesomeIcons.arrowsRotate,
                                      size: 18,
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
                                                  "C???p nh???t s??? d?? th??nh c??ng"),
                                            ));
                                          }
                                        });
                                      });
                                    },
                                  )
                                ]),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UnActiveBalancePage(
                                                    tokenModel:
                                                        widget.tokenModel,
                                                    userModel: widget.userModel,
                                                  )),
                                        );
                                      },
                                      child: Text(
                                        'S??? d?? kh??? d???ng:',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 15,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    ),
                                    Text(
                                      ' ' +
                                          (widget.activeBalance != null
                                              ? widget.activeBalance!
                                                  .toStringAsFixed(0)
                                                  .toVND()
                                              : lateUser!
                                                  .userBalance.activeBalance
                                                  .toStringAsFixed(0)
                                                  .toVND()),
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
                            height: 118,
                            width: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Column(
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
                                          'N???p ti???n',
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
                                                EnterWithdrawAmount(
                                                  tokenModel: widget.tokenModel,
                                                  userModel: widget.userModel,
                                                )),
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
                                          ' R??t ti???n',
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 6, 15, 5),
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
                            'L???ch s??? Giao d???ch',
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
                    padding: const EdgeInsets.fromLTRB(15, 9, 15, 5),
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
                            'Qu???n l?? nh???n thu??',
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
                    padding: const EdgeInsets.fromLTRB(15, 9, 15, 5),
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
                            'C??i ?????t s??? th??ch',
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
                    padding: const EdgeInsets.fromLTRB(15, 9, 15, 5),
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
                            'Thay ?????i m???t kh???u',
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
                    padding: const EdgeInsets.fromLTRB(15, 9, 15, 5),
                    child: GestureDetector(
                      onTap: () {
                        Future<ResponseModel<StatisticModel>?> statisticFuture =
                            UserService()
                                .getUserStatistic(widget.tokenModel.message);
                        statisticFuture.then((value) {
                          if (value != null) {
                            Future<ResponseModel<UserModel>?>
                                getUserProfileFuture = UserService()
                                    .getUserProfile(widget.tokenModel.message);
                            getUserProfileFuture.then((userProfile) {
                              if (userProfile != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => StatisticsPage(
                                        userModel: userProfile.content,
                                        tokenModel: widget.tokenModel,
                                        statisticModel: value.content,
                                      ),
                                    ));
                              }
                            });
                          }
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            'Th???ng k??',
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
                    padding: const EdgeInsets.fromLTRB(15, 9, 15, 5),
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
                            'Ch??nh s??ch',
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
                    padding: const EdgeInsets.fromLTRB(15, 9, 15, 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SystemFeedbackPage(
                                userModel: widget.userModel,
                                tokenModel: widget.tokenModel,
                              ),
                            ));
                      },
                      child: Row(
                        children: [
                          Text(
                            'Trung t??m ph???n h???i',
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
                    padding: const EdgeInsets.fromLTRB(15, 9, 15, 5),
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
                                        msg: "????NG XU???T TH??NH C??NG",
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
                                    '????ng xu???t',
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
                          return const SizedBox(
                            height: 0,
                          );
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
