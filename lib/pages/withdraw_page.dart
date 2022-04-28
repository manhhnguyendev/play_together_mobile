import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/transaction_page.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:play_together_mobile/widgets/profile_accept_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;

class WithdrawPage extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;
  final double money;
  const WithdrawPage(
      {Key? key,
      required this.userModel,
      required this.tokenModel,
      required this.money})
      : super(key: key);

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  final phoneController = TextEditingController();
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
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(fontSize: 20),
                    decoration: InputDecoration(
                        counter: Container(),
                        hintText: " Nhập số điện thoại",
                        hintStyle: GoogleFonts.montserrat()),
                    maxLength: 10,
                    controller: phoneController,
                    inputFormatters: const [],
                    keyboardType: TextInputType.phone,
                  ),
                ),
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
                    if (phoneController.text.isEmpty ||
                        phoneController.text == "" ||
                        phoneController.text.length < 10) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Vui lòng nhập số điện thoại"),
                      ));
                    } else {
                      WithdrawModel withdrawModel = WithdrawModel(
                          moneyWithdraw: widget.money,
                          phoneNumberMomo: phoneController.text);
                      Future<bool?> withdrawMoneyFuture = UserService()
                          .withdrawMoney(
                              widget.tokenModel.message, withdrawModel);
                      withdrawMoneyFuture.then((_withdrawMoney) {
                        if (_withdrawMoney == true) {
                          helper.pushInto(
                              context,
                              TransactionPage(
                                tokenModel: widget.tokenModel,
                                userModel: widget.userModel,
                              ),
                              true);
                          Fluttertoast.showToast(
                              msg: "RÚT TIỀN THÀNH CÔNG",
                              textColor: Colors.white,
                              backgroundColor:
                                  const Color.fromRGBO(137, 128, 255, 1),
                              toastLength: Toast.LENGTH_SHORT);
                        }
                      });
                    }
                  })),
        ));
  }
}
