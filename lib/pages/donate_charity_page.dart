import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:play_together_mobile/models/charity_model.dart';
import 'package:play_together_mobile/widgets/profile_accept_button.dart';
//import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

class DonateCharityPage extends StatefulWidget {
  final CharityModel charityModel;
  const DonateCharityPage({Key? key, required this.charityModel})
      : super(key: key);

  @override
  State<DonateCharityPage> createState() => _DonateCharityPageState();
}

class _DonateCharityPageState extends State<DonateCharityPage> {
  // MaskedTextController customController = MaskedTextController(
  //   mask: '000.000.000',
  // );
  // MaskedTextController convertController = MaskedTextController(
  //   mask: '000000000000', //convert lưu vào DB
  // );
  //var moneyController = TextEditingController();
  var displayController = TextEditingController();
  String money = "";
  double convertMoney = 0;
  String messages = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: FlatButton(
              child: Icon(
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
            style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 15),
                width: 350,
                child: TextField(
                  //initialValue: displayMoney,
                  inputFormatters: [ThousandsFormatter()],
                  controller: displayController,
                  onChanged: (value) {
                    setState(() {
                      money = value; //1 VNĐ
                      print(money + " gia tri luu");
                    });
                  },
                  //textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      counter: Container(), hintText: " Nhập số tiền"),
                  maxLength: 11,
                  keyboardType: TextInputType.number,
                ),
              ),
              Text('đ', style: TextStyle(fontSize: 15, color: Colors.black)),
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
                onSaved: (newValue) => messages = newValue!,
                decoration: const InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
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
                  if (money.length < 6) {
                    print("Không đủ điều kiện");
                  } else {
                    money = money.replaceAll(",", "");
                    convertMoney = double.parse(money);
                    print("Đủ điều kiện: " + convertMoney.toString());
                  }
                })),
      ),
    );
  }
}
