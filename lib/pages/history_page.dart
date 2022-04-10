import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/receive_request_page.dart';
import 'package:play_together_mobile/widgets/history_hiring_card.dart';
import 'package:play_together_mobile/widgets/bottom_bar.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/services/order_service.dart';
import 'package:play_together_mobile/services/user_service.dart';

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
  List<OrderModel>? _listOrder;
  List<OrderModel>? _listCreateOrder;
  List<OrderModel>? _listReceiveOrder;
  bool checkEmptyCreateOrder = false;
  bool checkEmptyReceiveOrder = false;
  Future loadListFromCreateUser() {
    _listCreateOrder ??= [];
    Future<List<OrderModel>?> listOrderFromCreateUserModelFuture =
        OrderService().getAllOrdersFromCreateUser(widget.tokenModel.message);
    listOrderFromCreateUserModelFuture.then((_createOrderList) {
      _listCreateOrder = _createOrderList;
      if (_listCreateOrder!.isEmpty) {
        for (var item in _listCreateOrder!) {
          Future<OrderModel?> orderFuture = OrderService()
              .getDetailOrderById(item.id, widget.tokenModel.message);
          orderFuture.then((value) {
            if (value != null) {
              _listCreateOrder!.add(value);
            }
          });
        }
      }
    });
    return listOrderFromCreateUserModelFuture;
  }

  Future loadListFromReceiveUser() {
    _listReceiveOrder ??= [];
    Future<List<OrderModel>?> listOrderFromReceiveUserModelFuture =
        OrderService().getAllOrdersFromReceivedUser(widget.tokenModel.message);
    listOrderFromReceiveUserModelFuture.then((_receiveOrderList) {
      _listReceiveOrder = _receiveOrderList;
      if (_listReceiveOrder!.isEmpty) {
        for (var item in _listReceiveOrder!) {
          Future<OrderModel?> orderFuture =
              OrderService().getOrderById(item.id, widget.tokenModel.message);
          orderFuture.then((value) {
            if (value != null) {
              _listReceiveOrder!.add(value);
            }
          });
        }
      }
    });
    return listOrderFromReceiveUserModelFuture;
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
        } else {
          Future<List<OrderModel>?> checkOrderUser =
              OrderService().getOrderOfPlayer(widget.tokenModel.message);
          checkOrderUser.then(((order) {
            _listOrder = order;
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
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: Colors.white,
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
                title: const Text(
                  'Lịch sử hoạt động',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.normal),
                ),
                bottom: const TabBar(
                    indicatorColor: Colors.grey,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Tab(
                        child: Text(
                          'Đi thuê',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Tab(
                        child: Text('Được thuê',
                            style: TextStyle(
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
                          if (_listCreateOrder!.isEmpty) {
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
                                      _listCreateOrder == null
                                          ? 0
                                          : _listCreateOrder!.length,
                                      (index) => buildListHistory(
                                          _listCreateOrder![index])),
                                ),
                                Visibility(
                                    visible: checkEmptyCreateOrder,
                                    child: const Text('Không có dữ liệu'))
                              ],
                            ),
                          );
                        })),
                SingleChildScrollView(
                    child: FutureBuilder(
                        future: loadListFromReceiveUser(),
                        builder: (context, snapshot) {
                          if (_listReceiveOrder!.isEmpty) {
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
                                      _listReceiveOrder == null
                                          ? 0
                                          : _listReceiveOrder!.length,
                                      (index) => buildListHistory(
                                          _listReceiveOrder![index])),
                                ),
                                Visibility(
                                    visible: checkEmptyReceiveOrder,
                                    child: const Text('Không có dữ liệu'))
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
}
