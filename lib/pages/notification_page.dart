import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/notification_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/hiring_negotiating_page.dart';
import 'package:play_together_mobile/pages/hiring_stage_page.dart';
import 'package:play_together_mobile/pages/receive_request_page.dart';
import 'package:play_together_mobile/services/notification_service.dart';
import 'package:play_together_mobile/widgets/bottom_bar.dart';
import 'package:play_together_mobile/widgets/notification_card.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/services/order_service.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsPage extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;

  const NotificationsPage(
      {Key? key, required this.userModel, required this.tokenModel})
      : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final ScrollController _scrollController = ScrollController();
  UserModel? lateUser;
  List<OrderModel> _listOrder = [];
  List<NotificationModel> _listNotification = [];
  bool checkFirstTime = true;
  bool checkEmptyNotification = false;
  int pageSize = 10;
  bool checkHasNext = false;
  bool checkGetData = false;

  Future loadListNotifications() {
    Future<ResponseListModel<NotificationModel>?> listNotificationFuture =
        NotificationService()
            .getNotifications(widget.tokenModel.message, pageSize);
    listNotificationFuture.then((_notificationList) {
      if (checkFirstTime || checkGetData) {
        _listNotification = _notificationList!.content;
        checkFirstTime = false;
        if (_notificationList.hasNext == false) {
          checkHasNext = true;
        } else {
          checkHasNext = false;
        }
      }
    });
    return listNotificationFuture;
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        getMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void getMoreData() {
    if (checkHasNext == false) {
      pageSize += 10;
      checkGetData = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkStatus(),
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: AppBar(
                bottomOpacity: 0,
                toolbarOpacity: 1,
                toolbarHeight: 65,
                backgroundColor: Colors.white,
                elevation: 1,
                leading: const CircleAvatar(
                  radius: 27,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(
                      "assets/images/play_together_logo_no_text.png"),
                ),
                centerTitle: true,
                title: Text(
                  'Thông báo',
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            body: SingleChildScrollView(
              controller: _scrollController,
              child: FutureBuilder(
                future: loadListNotifications(),
                builder: (context, snapshot) {
                  if (_listNotification.isEmpty && checkHasNext != false) {
                    checkEmptyNotification = true;
                  } else {
                    checkEmptyNotification = false;
                  }
                  return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(children: [
                        Column(
                          children: List.generate(
                              _listNotification.isNotEmpty
                                  ? _listNotification.length
                                  : 0,
                              (index) => buildListNotification(
                                  _listNotification[index])),
                        ),
                        Visibility(
                            visible: checkEmptyNotification,
                            child: Container(
                              alignment: Alignment.center,
                              child: Text('Không có thông báo',
                                  style: GoogleFonts.montserrat()),
                            )),
                        Visibility(
                          visible: !checkHasNext,
                          child: _buildProgressIndicator(),
                        )
                      ]));
                },
              ),
            ),
            bottomNavigationBar: BottomBar(
              userModel: widget.userModel,
              tokenModel: widget.tokenModel,
              bottomBarIndex: 3,
            ),
          );
        });
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: !checkHasNext ? 1.0 : 00,
          child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromRGBO(137, 128, 255, 1))),
        ),
      ),
    );
  }

  Widget buildListNotification(NotificationModel _notificationModel) {
    return NotificationCard(
      notificationModel: _notificationModel,
      userModel: widget.userModel,
      tokenModel: widget.tokenModel,
    );
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
