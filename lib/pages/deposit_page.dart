// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:play_together_mobile/models/momo_model.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/personal_page.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:play_together_mobile/widgets/profile_accept_button.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;

class DepositPage extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;

  const DepositPage(
      {Key? key, required this.userModel, required this.tokenModel})
      : super(key: key);

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  final displayController = TextEditingController();
  String money = "";
  String message = "";
  double convertMoney = 0;
  var formatter = NumberFormat('###,###,###');
  String url = "";

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
              'Thanh toán qua MOMO',
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
                        counter: Container(),
                        hintText: " Nhập số tiền",
                        hintStyle: GoogleFonts.montserrat()),
                    maxLength: 11,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Text('đ',
                    style: GoogleFonts.montserrat(
                        fontSize: 15, color: Colors.black)),
              ],
            ),
          ],
        )),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: AcceptProfileButton(
                  text: 'Nạp tiền',
                  onPress: () async {
                    if (money.isEmpty || money == "") {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Vui lòng nhập số tiền!"),
                      ));
                    } else if (double.parse(money.replaceAll(",", "")) <
                        10000) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Số tiền nạp tối thiểu là 10.000đ"),
                      ));
                    } else if (double.parse(money.replaceAll(",", "")) >=
                        50000000) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Số tiền nạp tối đa là 50.000.000đ"),
                      ));
                    } else {
                      money = displayController.text.replaceAll(",", "");
                      convertMoney = double.parse(money);
                      MomoCreateModel momoCreateModel = MomoCreateModel(
                          userId: widget.userModel.id, amount: convertMoney);
                      Future<ResponseModel<MomoModel>?> genUrl = UserService()
                          .getLinkMomo(
                              momoCreateModel, widget.tokenModel.message);
                      genUrl.then((value) async {
                        if (value != null) {
                          url = value.content.payUrl;
                          if (await canLaunch(url)) {
                            await launch(url);
                            helper.pushInto(
                                context,
                                PersonalPage(
                                  tokenModel: widget.tokenModel,
                                  userModel: widget.userModel,
                                ),
                                true);
                          } else {
                            throw "Could not launch $url";
                          }
                        }
                      });
                    }
                  })),
        ));
  }
}
