import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/deposit_page.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectDepositMethodPage extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;

  const SelectDepositMethodPage(
      {Key? key, required this.userModel, required this.tokenModel})
      : super(key: key);

  @override
  State<SelectDepositMethodPage> createState() =>
      _SelectDepositMethodPageState();
}

class _SelectDepositMethodPageState extends State<SelectDepositMethodPage> {
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
            'Phương thức thanh toán',
            style: GoogleFonts.montserrat(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
      body: Container(
          child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DepositPage(
                          tokenModel: widget.tokenModel,
                          userModel: widget.userModel,
                        )),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(border: Border.all(width: 0.1)),
              width: double.infinity,
              child: Row(children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.2),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      child: Image.asset("assets/images/momologo.png",
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Thanh toán qua MOMO",
                          style: GoogleFonts.montserrat(
                              fontSize: 18, color: Colors.black),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Hỗ trợ từ 8:30 -> 22:00 (trừ CN, ngày lễ)",
                          style: GoogleFonts.montserrat(
                              fontSize: 15, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                )
              ]),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(border: Border.all(width: 0.1)),
            width: double.infinity,
            child: Row(children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.2),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    child: Image.asset("assets/images/paypallogo.png",
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Thanh toán qua Paypal",
                          style: GoogleFonts.montserrat(
                              fontSize: 18, color: Colors.black),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "(Sắp ra mắt)",
                          style: GoogleFonts.montserrat(
                              fontSize: 15, color: Colors.grey),
                        ),
                      ],
                    ),
                  ))
            ]),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(border: Border.all(width: 0.1)),
            width: double.infinity,
            child: Row(children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.2),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    child: Image.asset("assets/images/onlinebankinglogo.png",
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Thanh toán Internet banking",
                          style: GoogleFonts.montserrat(
                              fontSize: 18, color: Colors.black),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "(Sắp ra mắt)",
                          style: GoogleFonts.montserrat(
                              fontSize: 15, color: Colors.grey),
                        ),
                      ],
                    ),
                  ))
            ]),
          ),
        ],
      )),
    );
  }
}
