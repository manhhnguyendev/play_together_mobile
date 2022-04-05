import 'package:flutter/material.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:play_together_mobile/models/charity_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/charity_page.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:play_together_mobile/widgets/profile_accept_button.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;

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
            style: const TextStyle(
                fontSize: 18,
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
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      counter: Container(), hintText: " Nhập số tiền"),
                  maxLength: 11,
                  keyboardType: TextInputType.number,
                ),
              ),
              const Text('đ',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 35, 10, 20),
            child: Container(
              height: 300,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: TextFormField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                maxLength: 1000,
                onChanged: (newValue) => message = newValue,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                  counterText: "",
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: "Nhập lời nhắn của bạn...",
                  hintText: "Nhập vào lời nhắn của bạn",
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
                onpress: () {
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
                    }
                  });
                })),
      ),
    );
  }
}
