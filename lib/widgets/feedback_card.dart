import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_together_mobile/models/system_feedback_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/feedback_details_page.dart';
import 'package:play_together_mobile/services/system_feedback_service.dart';

import '../models/response_model.dart';

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
  late SystemFeedbackDetailModel systemFeedbackDetailModel;
  @override
  Widget build(BuildContext context) {
    date = DateFormat('dd/MM/yyyy')
        .format(DateTime.parse(widget.systemFeedbackModel.createdDate));
    time = DateFormat('hh:mm a')
        .format(DateTime.parse(widget.systemFeedbackModel.createdDate));
    return Container(
      child: GestureDetector(
        onTap: () {
          Future<ResponseModel<SystemFeedbackDetailModel>?>
              getFeedbackDetailFuture = SystemFeedbackService()
                  .getFeedbackDetail(
                      widget.systemFeedbackModel.id, widget.tokenModel.message);
          getFeedbackDetailFuture.then((value) {
            if (value != null) {
              systemFeedbackDetailModel = value.content;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FeedbackDetailPage(
                      userModel: widget.userModel,
                      tokenModel: widget.tokenModel,
                      systemFeedbackDetailModel: systemFeedbackDetailModel,
                    ),
                  ));
            }
          });
        },
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

  Widget buildApproveStatus(int status) {
    if (status == 1) {
      return Text('Đã duyệt',
          style: GoogleFonts.montserrat(
              fontSize: 15,
              color: Colors.green,
              fontWeight: FontWeight.normal));
    } else if (status == 0) {
      return Text('Bị từ chối',
          style: GoogleFonts.montserrat(
              fontSize: 15, color: Colors.red, fontWeight: FontWeight.normal));
    } else if (status == -1) {
      return Text('Chờ xét duyệt',
          style: GoogleFonts.montserrat(
              fontSize: 15,
              color: Colors.amber,
              fontWeight: FontWeight.normal));
    } else {
      return Text('Chờ xét duyệt',
          style: GoogleFonts.montserrat(
              fontSize: 15,
              color: Colors.amber,
              fontWeight: FontWeight.normal));
    }
  }
}
