import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/response_model.dart';
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
                  backgroundImage: AssetImage(
                      "assets/images/play_together_logo_no_text.png"),
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
                  children: List.generate(
                      demoListNotifications.length,
                      (index) =>
                          buildListNotification(demoListNotifications[index])),
                ),
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

  Widget buildListNotification(NotificationModel model) =>
      NotificationCard(notificationModel: model);
}
