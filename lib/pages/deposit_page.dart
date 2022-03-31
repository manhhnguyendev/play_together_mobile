import 'package:flutter/material.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:play_together_mobile/widgets/profile_accept_button.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({Key? key}) : super(key: key);

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  @override
  Widget build(BuildContext context) {
    var displayController = TextEditingController();
    String money = "";
    double convertMoney = 0;
    String messages = "";
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
              'Thanh toán qua MOMO',
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
                  text: 'Nạp tiền',
                  onpress: () {
                    if (money.length < 6) {
                      print("Không đủ điều kiện");
                    } else {
                      money = money.replaceAll(",", "");
                      convertMoney = double.parse(money);
                      print("Đủ điều kiện: " + convertMoney.toString());
                    }
                  })),
        ));
  }
}
