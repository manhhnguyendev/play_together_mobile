import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_together_mobile/models/system_feedback_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';

class FeedbackDetailPage extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;
  final SystemFeedbackDetailModel systemFeedbackDetailModel;
  const FeedbackDetailPage(
      {Key? key,
      required this.userModel,
      required this.tokenModel,
      required this.systemFeedbackDetailModel})
      : super(key: key);

  @override
  State<FeedbackDetailPage> createState() => _FeedbackDetailPageState();
}

class _FeedbackDetailPageState extends State<FeedbackDetailPage> {
  String message = '';
  String title = '';
  bool checkFirstTime = true;
  String type = '';
  String displayType = '';
  int isApprove = -1;
  @override
  Widget build(BuildContext context) {
    if (checkFirstTime) {
      message = widget.systemFeedbackDetailModel.message;
      title = widget.systemFeedbackDetailModel.title;
      type = widget.systemFeedbackDetailModel.typeOfFeedback;
      isApprove = widget.systemFeedbackDetailModel.isApprove;
      checkFirstTime = false;
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: TextButton(
              style: TextButton.styleFrom(primary: Colors.black),
              child: const Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          centerTitle: true,
          title: Text(
            'Chi tiết phản hồi',
            style: GoogleFonts.montserrat(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
              child: buildApproveStatus(isApprove)),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: Text(
              'Thể loại: ',
              style: GoogleFonts.montserrat(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
          ),
          buildTypeOfFeedbackField(type),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: Text(
              'Tiêu đề: ',
              style: GoogleFonts.montserrat(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
          ),
          buildTitleField(title),
          buildMessageField(message),
        ],
      )),
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

  Widget buildTypeOfFeedbackField(String type) {
    if (type == 'Suggest') {
      return Padding(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
        child: Container(
          height: 70,
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: TextFormField(
              initialValue: 'Đề xuất tính năng hoặc thêm mới danh mục game',
              style: GoogleFonts.montserrat(),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              maxLength: 200,
              enabled: false,
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                counterText: "",
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      );
    } else if (type == 'SystemError') {
      return Padding(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
        child: Container(
          height: 70,
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: TextFormField(
              initialValue: 'Báo cáo lỗi của hệ thống',
              style: GoogleFonts.montserrat(),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              maxLength: 200,
              enabled: false,
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                counterText: "",
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      );
    } else if (type == 'Service') {
      return Padding(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
        child: Container(
          height: 70,
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: TextFormField(
              initialValue: 'Phản hồi về dịch vụ',
              style: GoogleFonts.montserrat(),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              maxLength: 200,
              enabled: false,
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                counterText: "",
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      );
    }
    return const Text(
      'Lỗi gửi',
    );
  }

  Widget buildMessageField(String message) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
      child: Container(
        height: 300,
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: TextFormField(
            initialValue: message,
            enabled: false,
            style: GoogleFonts.montserrat(),
            maxLines: null,
            keyboardType: TextInputType.multiline,
            maxLength: 1000,
            onChanged: (newValue) {
              message = newValue;
            },
            decoration: const InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
              counterText: "",
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTitleField(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
      child: Container(
        height: 70,
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: TextFormField(
            initialValue: title,
            enabled: false,
            style: GoogleFonts.montserrat(),
            maxLines: null,
            keyboardType: TextInputType.multiline,
            maxLength: 200,
            onChanged: (newValue) => title = newValue,
            decoration: const InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
              counterText: "",
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
