import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:play_together_mobile/models/charity_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/charity_page.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:play_together_mobile/widgets/profile_accept_button.dart';
import 'package:intl/intl.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;
import 'package:google_fonts/google_fonts.dart';

class DonateCharityPage extends StatefulWidget {
  final CharityModel charityModel;
  final UserModel userModel;
  final TokenModel tokenModel;
  final MakeDonateModel? makeDonateModel;

  const DonateCharityPage({
    Key? key,
    required this.charityModel,
    required this.userModel,
    required this.tokenModel,
    this.makeDonateModel,
  }) : super(key: key);

  @override
  State<DonateCharityPage> createState() => _DonateCharityPageState();
}

class _DonateCharityPageState extends State<DonateCharityPage> {
  var displayController = TextEditingController();
  String money = "";
  String message = "";
  double convertMoney = 0;
  var formatter = NumberFormat('###,###,###');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            widget.charityModel.organizationName,
            style: GoogleFonts.montserrat(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.attach_money_sharp,
                  color: Color(0xff8089FF),
                  size: 22,
                ),
                Text(
                  'Số dư khả dụng: ',
                  style: GoogleFonts.montserrat(fontSize: 18),
                ),
                Text(
                  formatter.format(widget.userModel.userBalance.activeBalance) +
                      "đ",
                  style: GoogleFonts.montserrat(fontSize: 18),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 15),
                width: 350,
                child: TextField(
                  inputFormatters: [ThousandsFormatter()],
                  controller: displayController,
                  onChanged: (value) {
                    setState(() {
                      money = value;
                    });
                  },
                  style: GoogleFonts.montserrat(fontSize: 20),
                  decoration: InputDecoration(
                      counter: Container(), hintText: " Nhập số tiền"),
                  maxLength: 11,
                  keyboardType: TextInputType.number,
                ),
              ),
              Text('đ',
                  style: GoogleFonts.montserrat(
                      fontSize: 20, color: Colors.black)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 35, 10, 20),
            child: Container(
              height: 300,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: TextFormField(
                style: GoogleFonts.montserrat(),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                maxLength: 1000,
                onChanged: (newValue) => message = newValue,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                  counterText: "",
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: "Nhập lời nhắn của bạn...",
                  hintText: "Nhập vào lời nhắn của bạn",
                  hintStyle: GoogleFonts.montserrat(),
                  labelStyle: GoogleFonts.montserrat(),
                  border: InputBorder.none,
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
                text: 'Gửi tiền từ thiện',
                onPress: () {
                  money = money.replaceAll(",", "");
                  convertMoney = double.parse(money);
                  MakeDonateModel makeDonateModel = MakeDonateModel(
                      money: convertMoney,
                      message: message != "" ? message : message);
                  Future<bool?> makeDonateFuture = UserService()
                      .makeDonateToCharity(widget.charityModel.id,
                          widget.tokenModel.message, makeDonateModel);
                  makeDonateFuture.then((_makeDonateModel) {
                    if (_makeDonateModel == true) {
                      setState(() {
                        helper.pushInto(
                            context,
                            CharityPage(
                              tokenModel: widget.tokenModel,
                              userModel: widget.userModel,
                            ),
                            true);
                      });
                      Fluttertoast.showToast(
                          msg: "Gửi từ thiện thành công",
                          textColor: Colors.white,
                          backgroundColor:
                              const Color.fromRGBO(137, 128, 255, 1),
                          toastLength: Toast.LENGTH_SHORT);
                    }
                  });
                })),
      ),
    );
  }
}
