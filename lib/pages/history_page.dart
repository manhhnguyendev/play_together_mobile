import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/end_order_page.dart';
import 'package:play_together_mobile/pages/hiring_negotiating_page.dart';
import 'package:play_together_mobile/pages/hiring_stage_page.dart';
import 'package:play_together_mobile/pages/home_page.dart';
import 'package:play_together_mobile/pages/receive_request_page.dart';
import 'package:play_together_mobile/widgets/history_hiring_card.dart';
import 'package:play_together_mobile/widgets/bottom_bar.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/services/order_service.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryPage extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;

  const HistoryPage(
      {Key? key, required this.userModel, required this.tokenModel})
      : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  UserModel? lateUser;
  List<OrderModel> _listOrder = [];
  List<OrderModel> _listCreateOrder = [];
  List<OrderModel> _listReceiveOrder = [];
  bool checkListCreateOrder = true;
  bool checkListReceiveOrder = true;
  bool checkEmptyCreateOrder = false;
  bool checkEmptyReceiveOrder = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkStatus(),
        builder: (context, snapshot) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
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
                  'Lịch sử hoạt động',
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.normal),
                ),
                bottom: TabBar(
                    indicatorColor: Colors.grey,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Tab(
                        child: Text(
                          'Đi thuê',
                          style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Tab(
                        child: Text('Được thuê',
                            style: GoogleFonts.montserrat(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.normal)),
                      )
                    ]),
              ),
              body: TabBarView(children: [
                SingleChildScrollView(
                    child: FutureBuilder(
                        future: loadListFromCreateUser(),
                        builder: (context, snapshot) {
                          if (_listCreateOrder.isEmpty) {
                            checkEmptyCreateOrder = true;
                          } else {
                            checkEmptyCreateOrder = false;
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              children: [
                                Column(
                                  children: List.generate(
                                      _listCreateOrder.isNotEmpty
                                          ? _listCreateOrder.length
                                          : 0,
                                      (index) => buildListHistory(
                                          _listCreateOrder[index])),
                                ),
                                Visibility(
                                    visible: checkEmptyCreateOrder,
                                    child: Text('Không có dữ liệu',
                                        style: GoogleFonts.montserrat())),
                              ],
                            ),
                          );
                        })),
                SingleChildScrollView(
                    child: FutureBuilder(
                        future: loadListFromReceiveUser(),
                        builder: (context, snapshot) {
                          if (_listReceiveOrder.isEmpty) {
                            checkEmptyReceiveOrder = true;
                          } else {
                            checkEmptyReceiveOrder = false;
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              children: [
                                Column(
                                  children: List.generate(
                                      _listReceiveOrder.isNotEmpty
                                          ? _listReceiveOrder.length
                                          : 0,
                                      (index) => buildListHistory(
                                          _listReceiveOrder[index])),
                                ),
                                Visibility(
                                    visible: checkEmptyReceiveOrder,
                                    child: Text('Không có dữ liệu',
                                        style: GoogleFonts.montserrat()))
                              ],
                            ),
                          );
                        })),
              ]),
              bottomNavigationBar: BottomBar(
                userModel: widget.userModel,
                tokenModel: widget.tokenModel,
                bottomBarIndex: 1,
              ),
            ),
          );
        });
  }

  Widget buildListHistory(OrderModel _orderModel) {
    return HistoryHiringCard(
      orderModel: _orderModel,
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
                  if (helper.getDayElapsed(
                          DateTime.now().toString(),
                          DateTime.parse(orderPlayer.content[0].timeStart)
                              .add(Duration(
                                  hours: orderPlayer.content[0].totalTimes))
                              .toString()) <=
                      0) {
                    Future<bool?> finishOrderFuture = OrderService()
                        .finishOrder(orderPlayer.content[0].id,
                            widget.tokenModel.message);
                    finishOrderFuture.then((check) {
                      if (check == true) {
                        setState(() {
                          helper.pushInto(
                              context,
                              EndOrderPage(
                                tokenModel: widget.tokenModel,
                                userModel: widget.userModel,
                                orderModel: _listOrder[0],
                              ),
                              true);
                        });
                      }
                    });
                  } else if ((helper.getDayElapsed(
                          DateTime.now().toString(),
                          DateTime.parse(orderPlayer.content[0].timeStart)
                              .add(Duration(
                                  hours: orderPlayer.content[0].totalTimes))
                              .toString()) >
                      1)) {
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
            } else {
              _listOrder = orderUser.content;
              if (_listOrder[0].userId == widget.userModel.id) {
                if (helper.getDayElapsed(
                        DateTime.now().toString(),
                        DateTime.parse(orderUser.content[0].timeStart)
                            .add(Duration(
                                hours: orderUser.content[0].totalTimes))
                            .toString()) <=
                    0) {
                  Future<bool?> finishOrderFuture = OrderService().finishOrder(
                      orderUser.content[0].id, widget.tokenModel.message);
                  finishOrderFuture.then((check) {
                    if (check == true) {
                      setState(() {
                        helper.pushInto(
                            context,
                            EndOrderPage(
                              tokenModel: widget.tokenModel,
                              userModel: widget.userModel,
                              orderModel: _listOrder[0],
                            ),
                            true);
                      });
                    }
                  });
                } else if (helper.getDayElapsed(
                        DateTime.now().toString(),
                        DateTime.parse(orderUser.content[0].timeStart)
                            .add(Duration(
                                hours: orderUser.content[0].totalTimes))
                            .toString()) >
                    1) {
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
                  if (helper.getDayElapsed(DateTime.now().toString(),
                          orderPlayer.content[0].processExpired) <
                      0) {
                    RejectOrderModel rejectOrder = RejectOrderModel(
                        isAccept: false, reason: 'Quá thời gian chấp thuận');
                    Future<bool?> rejectFuture = OrderService()
                        .rejectOrderRequest(orderPlayer.content[0].id,
                            widget.tokenModel.message, rejectOrder);
                    rejectFuture.then((check) {
                      if (check == true) {
                        setState(() {
                          helper.pushInto(
                              context,
                              HomePage(
                                tokenModel: widget.tokenModel,
                                userModel: widget.userModel,
                              ),
                              true);
                        });
                      }
                    });
                  } else if (helper.getDayElapsed(DateTime.now().toString(),
                          orderPlayer.content[0].processExpired) >
                      1) {
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
                }
              }));
            } else {
              _listOrder = orderUser.content;
              if (_listOrder[0].userId == widget.userModel.id) {
                if (helper.getDayElapsed(DateTime.now().toString(),
                        orderUser.content[0].processExpired) <=
                    0) {
                  CancelOrderModel cancelOrder =
                      CancelOrderModel(reason: 'Quá thời gian gửi yêu cầu');
                  Future<bool?> cancelFuture = OrderService()
                      .cancelOrderRequest(orderUser.content[0].id,
                          widget.tokenModel.message, cancelOrder);
                  cancelFuture.then((check) {
                    if (check == true) {
                      setState(() {
                        helper.pushInto(
                            context,
                            HomePage(
                              tokenModel: widget.tokenModel,
                              userModel: widget.userModel,
                            ),
                            true);
                      });
                    }
                  });
                } else if (helper.getDayElapsed(DateTime.now().toString(),
                        orderUser.content[0].processExpired) >
                    1) {
                  lateUser = value.content;
                  Future<ResponseModel<PlayerModel>?> getPlayerModel =
                      UserService().getPlayerById(
                          _listOrder[0].toUserId, widget.tokenModel.message);
                  getPlayerModel.then((playerModel) {
                    if (playerModel != null) {
                      if (!mounted) return;
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
            }
          }));
        }
      }
    });
    return getStatusUser;
  }

  Future loadListFromCreateUser() {
    Future<ResponseListModel<OrderModel>?> listOrderFromCreateUserModelFuture =
        OrderService().getAllOrdersFromCreateUser(widget.tokenModel.message);
    listOrderFromCreateUserModelFuture.then((_createOrderList) {
      if (checkListCreateOrder) {
        _listCreateOrder = _createOrderList!.content;
        checkListCreateOrder = false;
      }
    });
    return listOrderFromCreateUserModelFuture;
  }

  Future loadListFromReceiveUser() {
    Future<ResponseListModel<OrderModel>?> listOrderFromReceiveUserModelFuture =
        OrderService().getAllOrdersFromReceivedUser(widget.tokenModel.message);
    listOrderFromReceiveUserModelFuture.then((_receiveOrderList) {
      if (checkListReceiveOrder) {
        _listReceiveOrder = _receiveOrderList!.content;
        checkListReceiveOrder = false;
      }
    });
    return listOrderFromReceiveUserModelFuture;
  }
}
