import 'package:flutter/material.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/select_withdraw_method.dart';
import 'package:play_together_mobile/widgets/profile_accept_button.dart';
import 'package:google_fonts/google_fonts.dart';

class EnterWithdrawAmount extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;

  const EnterWithdrawAmount({
    Key? key,
    required this.userModel,
    required this.tokenModel,
  }) : super(key: key);

  @override
  State<EnterWithdrawAmount> createState() => _EnterWithdrawAmountState();
}

class _EnterWithdrawAmountState extends State<EnterWithdrawAmount> {
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
            title: Text(
              'Rút tiền',
              style: GoogleFonts.montserrat(
                  fontSize: 20,
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
                    cursorColor: Color(0xff320444),

                    inputFormatters: [ThousandsFormatter()],
                    controller: displayController,
                    onChanged: (value) {
                      setState(() {
                        money = value; //1 VNĐ
                        print(money + " gia tri luu");
                      });
                    },
                    //textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        fontSize: 20, color: Color(0xff320444)),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff320444)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff320444)),
                      ),
                      counter: Container(),
                      hintText: " Nhập số tiền",
                      hintStyle: GoogleFonts.montserrat(),
                    ),
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
                  text: 'Rút tiền',
                  onPress: () {
                    if (money.isEmpty || money == "") {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Vui lòng nhập số tiền"),
                      ));
                    } else if (money.length < 6) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Số tiền rút tối thiểu là 10.000đ"),
                      ));
                    } else {
                      money = money.replaceAll(",", "");
                      convertMoney = double.parse(money);
                      print("Đủ điều kiện: " + convertMoney.toString());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectWithdrawMethod(
                                  money: convertMoney,
                                  tokenModel: widget.tokenModel,
                                  userModel: widget.userModel,
                                )),
                      );
                    }
                  })),
        ));
  }
}
