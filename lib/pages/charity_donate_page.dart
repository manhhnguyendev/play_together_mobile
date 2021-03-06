import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:play_together_mobile/models/charity_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/transaction_page.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:play_together_mobile/widgets/profile_accept_button.dart';
import 'package:intl/intl.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;
import 'package:google_fonts/google_fonts.dart';

class DonateCharityPage extends StatefulWidget {
  final CharityModel charityModel;
  final UserModel userModel;
  final TokenModel tokenModel;
  final double activeBalance;

  const DonateCharityPage({
    Key? key,
    required this.charityModel,
    required this.userModel,
    required this.tokenModel,
    required this.activeBalance,
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
                  'S??? d?? kh??? d???ng: ',
                  style: GoogleFonts.montserrat(fontSize: 18),
                ),
                Text(
                  formatter.format(widget.activeBalance) + "??",
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
                      counter: Container(), hintText: " Nh???p s??? ti???n"),
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                ),
              ),
              Text('??',
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
                  labelText: "Nh???p l???i nh???n c???a b???n...",
                  hintText: "Nh???p v??o l???i nh???n c???a b???n",
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
                text: 'G???i ti???n t??? thi???n',
                onPress: () {
                  if (money.isEmpty || money == "") {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Vui l??ng nh???p s??? ti???n!"),
                    ));
                  } else if (money.length <= 4) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("S??? ti???n g???i t??? thi???n t???i thi???u l?? 1.000??"),
                    ));
                  } else {
                    if (message.isEmpty || message == "") {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Vui l??ng nh???p l???i nh???n!"),
                      ));
                    } else {
                      money = money.replaceAll(",", "");
                      convertMoney = double.parse(money);
                      MakeDonateModel makeDonateModel = MakeDonateModel(
                          money: convertMoney, message: message);
                      if (convertMoney > widget.activeBalance) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("S??? d?? kh??? d???ng kh??ng ?????!"),
                        ));
                      } else {
                        Future<bool?> makeDonateFuture = UserService()
                            .makeDonateToCharity(widget.charityModel.id,
                                widget.tokenModel.message, makeDonateModel);
                        makeDonateFuture.then((_makeDonateModel) {
                          if (_makeDonateModel == true) {
                            setState(() {
                              helper.pushInto(
                                  context,
                                  TransactionPage(
                                    tokenModel: widget.tokenModel,
                                    userModel: widget.userModel,
                                  ),
                                  true);
                            });
                            Fluttertoast.showToast(
                                msg: "G???i t??? thi???n th??nh c??ng",
                                textColor: Colors.white,
                                backgroundColor:
                                    const Color.fromRGBO(137, 128, 255, 1),
                                toastLength: Toast.LENGTH_SHORT);
                          } else {
                            Fluttertoast.showToast(
                                msg: "G???i t??? thi???n th???t b???i",
                                textColor: Colors.white,
                                backgroundColor:
                                    const Color.fromRGBO(137, 128, 255, 1),
                                toastLength: Toast.LENGTH_SHORT);
                          }
                        });
                      }
                    }
                  }
                })),
      ),
    );
  }
}
