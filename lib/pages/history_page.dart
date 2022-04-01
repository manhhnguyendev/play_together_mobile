import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/hiring_model.dart';
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

  void check() {
    Future<UserModel?> checkStatus =
        UserService().getUserProfile(widget.tokenModel.message);
    checkStatus.then((value) {
      if (value != null) {
        if (value.status.contains('Online')) {
          setState(() {
            lateUser = value;
          });
        } else {
          Future<List<OrderModel>?> checkPlayer = OrderService()
              .getAllOrdersForPlayer(widget.tokenModel.message, true, "");
          checkPlayer.then(((order) {
            setState(() {
              _listOrder = order;
              if (_listOrder![0].toUserId == widget.userModel.id) {
                setState(() {
                  lateUser = value;
                  helper.pushInto(
                      context,
                      ReceiveRequestPage(
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
            backgroundImage:
                AssetImage("assets/images/play_together_logo_no_text.png"),
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
            //đi thuê
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: List.generate(demoHistoryHiring.length,
                    (index) => buildListHistory(demoHistoryHiring[index])),
              ),
            ),
          ),
          SingleChildScrollView(
            //được thuê
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: List.generate(demoHistoryHiring.length,
                    (index) => buildListHistory(demoHistoryHiring[index])),
              ),
            ),
          ),
        ]),
        bottomNavigationBar: BottomBar(
          userModel: widget.userModel,
          tokenModel: widget.tokenModel,
          bottomBarIndex: 1,
        ),
      ),
    );
  }

  Widget buildListHistory(HistoryHiringModel model) {
    return HistoryHiringCard(historyHiringModel: model);
  }

  Widget buildListHistory2(HistoryHiringModel model) {
    return HistoryHiringCard(historyHiringModel: model);
  }
}
