import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_together_mobile/models/system_feedback_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';

class FeedbackCard extends StatefulWidget {
  final TokenModel tokenModel;
  final UserModel userModel;
  final SystemFeedbackModel systemFeedbackModel;
  const FeedbackCard(
      {Key? key,
      required this.tokenModel,
      required this.userModel,
      required this.systemFeedbackModel})
      : super(key: key);

  @override
  State<FeedbackCard> createState() => _FeedbackCardState();
}

class _FeedbackCardState extends State<FeedbackCard> {
  String date = "";
  String time = "";
  @override
  Widget build(BuildContext context) {
    date = DateFormat('dd/MM/yyyy')
        .format(DateTime.parse(widget.systemFeedbackModel.createdDate));
    time = DateFormat('hh:mm a')
        .format(DateTime.parse(widget.systemFeedbackModel.createdDate));
    return Container(
      child: GestureDetector(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              SizedBox(
                width: 250,
                child: Text(
                  widget.systemFeedbackModel.title,
                  style: GoogleFonts.montserrat(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Spacer(),
              SizedBox(
                width: 120,
                child: Container(
                    alignment: Alignment.centerRight,
                    child: buildApproveStatus(
                        widget.systemFeedbackModel.isApprove)),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            Text(
              date + ', ' + time,
              style: GoogleFonts.montserrat(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget buildApproveStatus(bool status) {
    if (status != null) {
      if (status) {
        return Text('Đã duyệt',
            style: GoogleFonts.montserrat(
                fontSize: 15,
                color: Colors.green,
                fontWeight: FontWeight.normal));
      } else {
        return Text('Bị từ chối',
            style: GoogleFonts.montserrat(
                fontSize: 15,
                color: Colors.red,
                fontWeight: FontWeight.normal));
      }
    } else {
      return Text('Chờ xét duyệt',
          style: GoogleFonts.montserrat(
              fontSize: 15,
              color: Colors.amber,
              fontWeight: FontWeight.normal));
    }
  }
}
