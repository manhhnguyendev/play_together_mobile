import 'package:flutter/material.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:play_together_mobile/pages/select_withdraw_method.dart';
import 'package:play_together_mobile/widgets/profile_accept_button.dart';

class EnterWithdrawAmount extends StatefulWidget {
  const EnterWithdrawAmount({Key? key}) : super(key: key);

  @override
  State<EnterWithdrawAmount> createState() => _EnterWithdrawAmountState();
}

class _EnterWithdrawAmountState extends State<EnterWithdrawAmount> {
  // MaskedTextController customController = MaskedTextController(
  //   mask: '000.000.000.000',
  // );
  // MaskedTextController convertController = MaskedTextController(
  //   mask: '000000000000', //convert lưu vào DB
  // );
  var displayController = TextEditingController();
  String money = "";
  double convertMoney = 0;
  String messages = "";
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
            title: const Text(
              'Rút tiền',
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
          ],
        )),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: AcceptProfileButton(
                  text: 'Rút tiền',
                  onpress: () {
                    if (money.length < 6) {
                      print("Không đủ điều kiện");
                    } else {
                      money = money.replaceAll(",", "");
                      convertMoney = double.parse(money);
                      print("Đủ điều kiện: " + convertMoney.toString());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectWithdrawMethod()),
                      );
                    }
                  })),
        ));
  }
}
