import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/notification_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/receive_request_page.dart';
import 'package:play_together_mobile/widgets/bottom_bar.dart';
import 'package:play_together_mobile/widgets/notification_card.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/services/order_service.dart';
import 'package:play_together_mobile/services/user_service.dart';

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
                lateUser = value;
                helper.pushInto(
                    context,
                    ReceiveRequestPage(
                        orderModel: _listOrder![0],
                        tokenModel: widget.tokenModel,
                        userModel: lateUser!),
                    true);
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
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          bottomOpacity: 0,
          toolbarOpacity: 1,
          toolbarHeight: 65,
          backgroundColor: Colors.white,
          elevation: 1,
          leading: CircleAvatar(
            radius: 27,
            backgroundColor: Colors.white,
            backgroundImage:
                AssetImage("assets/images/play_together_logo_no_text.png"),
          ),
          centerTitle: true,
          title: Text(
            'Thông báo',
            style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: List.generate(demoListNotifications.length,
                (index) => buildListNotification(demoListNotifications[index])),
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(
        userModel: widget.userModel,
        tokenModel: widget.tokenModel,
        bottomBarIndex: 3,
      ),
    );
  }

  Widget buildListNotification(NotificationModel model) =>
      NotificationCard(notificationModel: model);
}
