import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_together_mobile/models/system_feedback_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/services/system_feedback_service.dart';
import 'package:play_together_mobile/widgets/profile_accept_button.dart';

class CreateFeedbackPage extends StatefulWidget {
  final TokenModel tokenModel;
  final UserModel userModel;
  const CreateFeedbackPage(
      {Key? key, required this.tokenModel, required this.userModel})
      : super(key: key);

  @override
  State<CreateFeedbackPage> createState() => _CreateFeedbackPageState();
}

class _CreateFeedbackPageState extends State<CreateFeedbackPage> {
  List<DropdownMenuItem<String>> listDrop = [];
  String message = '';
  String title = '';
  bool checkFirstTime = true;
  String type = '';
  String? displayType;
  List<String> drop = [
    'Báo cáo lỗi của hệ thống',
    'Đề xuất tính năng hoặc thêm mới danh mục game',
    'Phản hồi về dịch vụ'
  ];

  void loadData() {
    listDrop = drop
        .map((val) => DropdownMenuItem<String>(
              child: Text(
                val,
                style: GoogleFonts.montserrat(),
              ),
              value: val,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    if (checkFirstTime) {
      loadData();
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
            child: FlatButton(
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
            'Tạo phản hồi về hệ thống',
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
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: Text(
              'Chọn thể loại: ',
              style: GoogleFonts.montserrat(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: Container(
                decoration: BoxDecoration(border: Border.all()),
                child: buildTypeOfFeedbackField()),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: Container(
              height: 70,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: TextFormField(
                  style: GoogleFonts.montserrat(),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  maxLength: 200,
                  onChanged: (newValue) => title = newValue,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 0, horizontal: 10.0),
                    counterText: "",
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: "Nhập tiêu đề phản hồi",
                    hintText: "Nhập vào tiêu đề phản hồi của bạn",
                    hintStyle: GoogleFonts.montserrat(),
                    labelStyle: GoogleFonts.montserrat(),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: Container(
              height: 300,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: TextFormField(
                  style: GoogleFonts.montserrat(),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  maxLength: 1000,
                  onChanged: (newValue) {
                    message = newValue;
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 0, horizontal: 10.0),
                    counterText: "",
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: "Nhập phản hồi của bạn",
                    hintText: "Nhập vào phản hồi của bạn",
                    hintStyle: GoogleFonts.montserrat(),
                    labelStyle: GoogleFonts.montserrat(),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: AcceptProfileButton(
                text: 'Tạo phản hồi',
                onPress: () {
                  if (displayType.toString() == 'Báo cáo lỗi của hệ thống') {
                    type = 'SystemError';
                  }

                  if (displayType.toString() ==
                      'Đề xuất tính năng hoặc thêm mới danh mục game') {
                    type = 'Suggest';
                  }

                  if (displayType.toString() == 'Phản hồi về dịch vụ') {
                    type = 'Service';
                  }

                  if (type == '' || title == '' || message == '') {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Vui lòng nhập toàn bộ thông tin phản hồi"),
                    ));
                  } else {
                    CreateFeedBacksModel newModel = CreateFeedBacksModel(
                        title: title, message: message, typeOfFeedback: type);
                    Future<bool?> createFeedback = SystemFeedbackService()
                        .createFeedBacks(newModel, widget.tokenModel.message);
                    createFeedback.then((value) {
                      if (value != null) {
                        if (value == true) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Gửi phản hồi thành công"),
                          ));
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Gửi phản hồi thất bại"),
                          ));
                        }
                      }
                    });
                  }
                })),
      ),
    );
  }

  Container buildTypeOfFeedbackField() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
            isExpanded: true,
            value: displayType,
            menuMaxHeight: 3 * 48,
            hint: Text(
              'Thể loại phản hồi',
              style: GoogleFonts.montserrat(),
            ),
            items: listDrop,
            iconSize: 20.0,
            elevation: 16,
            onChanged: (value) {
              displayType = value as String;
              setState(() {
                displayType = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
