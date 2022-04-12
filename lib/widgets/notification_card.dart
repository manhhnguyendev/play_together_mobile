import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:play_together_mobile/models/notification_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';

class NotificationCard extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;
  final NotificationModel notificationModel;

  const NotificationCard(
      {Key? key,
      required this.notificationModel,
      required this.userModel,
      required this.tokenModel})
      : super(key: key);

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    String date = "";
    String time = "";

    date = DateFormat('dd/MM/yyyy')
        .format(DateTime.parse(widget.notificationModel.createdDate));
    time = DateFormat('hh:mm a')
        .format(DateTime.parse(widget.notificationModel.createdDate));
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: GestureDetector(
        onTap: () {},
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.notificationModel.title,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      date + ', ' + time,
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(
              thickness: 0.5,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
