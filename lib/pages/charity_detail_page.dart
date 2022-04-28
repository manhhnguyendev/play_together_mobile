import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/charity_model.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_balance_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/charity_donate_page.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:play_together_mobile/widgets/profile_accept_button.dart';
import 'package:google_fonts/google_fonts.dart';

class CharityDetailPage extends StatefulWidget {
  final CharityModel charityModel;
  final UserModel userModel;
  final TokenModel tokenModel;

  const CharityDetailPage(
      {Key? key,
      required this.charityModel,
      required this.userModel,
      required this.tokenModel})
      : super(key: key);

  @override
  State<CharityDetailPage> createState() => _CharityDetailPageState();
}

class _CharityDetailPageState extends State<CharityDetailPage> {
  final descriptionController = TextEditingController();
  String description = "";
  @override
  Widget build(BuildContext context) {
    description = widget.charityModel.information;
    descriptionController.text = description;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: FlatButton(
              child: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.charityModel.avatar),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.charityModel.organizationName,
                  style: GoogleFonts.montserrat(fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: Text(
              "Giới thiệu",
              style: GoogleFonts.montserrat(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 15),
            child: TextFormField(
              style: GoogleFonts.montserrat(fontSize: 15),
              enabled: false,
              controller: descriptionController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              maxLength: null,
              onSaved: (newValue) => description = newValue!,
              onChanged: (value) {
                description = value;
              },
              decoration: const InputDecoration(
                counterText: "",
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                labelText: "Giới thiệu sơ lược",
                hintText: "Giới thiệu bản thân bạn ...",
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: Text(
              "Thông tin liên hệ",
              style: GoogleFonts.montserrat(fontSize: 18),
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Địa chỉ:",
                    style: GoogleFonts.montserrat(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.charityModel.address,
                    style: GoogleFonts.montserrat(fontSize: 15),
                    maxLines: 2,
                  ),
                  Row(
                    children: [
                      Text(
                        "Điện thoại: ",
                        style: GoogleFonts.montserrat(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.charityModel.phone,
                        style: GoogleFonts.montserrat(fontSize: 15),
                        maxLines: 2,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Email: ",
                        style: GoogleFonts.montserrat(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.charityModel.email,
                        style: GoogleFonts.montserrat(fontSize: 15),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ],
              )),
        ],
      )),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: AcceptProfileButton(
                text: 'Gửi tiền từ thiện',
                onPress: () {
                  Future<ResponseModel<UserBalanceModel>?>
                      getUserServiceFuture = UserService().getUserBalance(
                          widget.userModel.id, widget.tokenModel.message);
                  getUserServiceFuture.then((value) {
                    if (value != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DonateCharityPage(
                                  charityModel: widget.charityModel,
                                  tokenModel: widget.tokenModel,
                                  userModel: widget.userModel,
                                  activeBalance: value.content.activeBalance,
                                )),
                      );
                    }
                  });
                })),
      ),
    );
  }
}
