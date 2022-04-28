import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_together_mobile/models/rating_comment_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/services/rating_service.dart';
import 'package:play_together_mobile/widgets/second_main_button.dart';

class ReportCommentPage extends StatefulWidget {
  final RatingModel ratingModel;
  final TokenModel tokenModel;
  const ReportCommentPage({
    Key? key,
    required this.ratingModel,
    required this.tokenModel,
  }) : super(key: key);

  @override
  State<ReportCommentPage> createState() => _ReportCommentPageState();
}

class _ReportCommentPageState extends State<ReportCommentPage> {
  final _controller = TextEditingController();
  bool checkReason = true;
  String reason = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: FlatButton(
            child: const Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          'Báo cáo bình luận này',
          style: GoogleFonts.montserrat(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Row(
            children: [
              Radio<String>(
                  activeColor: const Color(0xff320444),
                  value: "Ngôn ngữ đả kích phản cảm",
                  groupValue: reason,
                  onChanged: (value) {
                    setState(() {
                      reason = value!;
                      checkReason = false;
                    });
                  }),
              Text(
                "Ngôn ngữ đả kích phản cảm",
                style: GoogleFonts.montserrat(fontSize: 15),
              )
            ],
          ),
          Row(
            children: [
              Radio<String>(
                  activeColor: const Color(0xff320444),
                  value: "Đánh giá không chính xác",
                  groupValue: reason,
                  onChanged: (value) {
                    setState(() {
                      reason = value!;
                      checkReason = false;
                    });
                  }),
              Text(
                "Đánh giá không chính xác",
                style: GoogleFonts.montserrat(fontSize: 15),
              )
            ],
          ),
          Row(
            children: [
              Radio<String>(
                  activeColor: const Color(0xff320444),
                  value: "Quảng cáo trái phép",
                  groupValue: reason,
                  onChanged: (value) {
                    setState(() {
                      reason = value!;
                      checkReason = false;
                    });
                  }),
              Text(
                "Quảng cáo trái phép",
                style: GoogleFonts.montserrat(fontSize: 15),
              )
            ],
          ),
          Row(
            children: [
              Radio<String>(
                  activeColor: const Color(0xff320444),
                  value: "Chứa thông tin cá nhân",
                  groupValue: reason,
                  onChanged: (value) {
                    setState(() {
                      reason = value!;
                      checkReason = false;
                    });
                  }),
              Text(
                "Chứa thông tin cá nhân",
                style: GoogleFonts.montserrat(fontSize: 15),
              )
            ],
          ),
          Row(
            children: [
              Radio<String>(
                  activeColor: const Color(0xff320444),
                  value: _controller.text,
                  groupValue: reason,
                  onChanged: (value) {
                    setState(() {
                      reason = value!;
                      checkReason = true;
                    });
                  }),
              Text(
                "Lý do khác",
                style: GoogleFonts.montserrat(fontSize: 15),
              )
            ],
          ),
          Visibility(
            visible: checkReason,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
              child: TextField(
                controller: _controller,
                onChanged: (value) {
                  setState(() {
                    reason = _controller.text;
                    checkReason = true;
                  });
                },
                style: GoogleFonts.montserrat(fontSize: 15),
              ),
            ),
          )
        ],
      )),
      bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: SecondMainButton(
                text: 'Tố cáo',
                onPress: () {
                  if (checkReason == true && _controller.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Vui lòng nhập lý do!"),
                    ));
                  } else {
                    _controller.text = reason;
                    ReportCommentModel reportCommentModel =
                        ReportCommentModel(reason: _controller.text);
                    Future<bool?> reportComment = RatingService().reportComment(
                        widget.ratingModel.id,
                        widget.tokenModel.message,
                        reportCommentModel);
                    reportComment.then((value) {
                      if (value == true) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Báo cáo thành công"),
                        ));
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Báo cáo thất bại"),
                        ));
                      }
                    });
                  }
                },
                height: 50,
                width: 200),
          )),
    );
  }
}
