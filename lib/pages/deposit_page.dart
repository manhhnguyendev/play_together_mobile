import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:play_together_mobile/widgets/profile_accept_button.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({Key? key}) : super(key: key);

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  @override
  Widget build(BuildContext context) {
    MaskedTextController customController = MaskedTextController(
      mask: '000.000.000.000',
    );
    MaskedTextController convertController = MaskedTextController(
      mask: '000000000000', //convert lưu vào DB
    );
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
                    onChanged: (value) {
                      setState(() {
                        if (customController.text.length == 1) {
                          if (value == '0') {
                            value = '';
                            //customController.value = '';
                            customController.text = '';
                            convertController.text = customController.text;
                            print(customController.text + " money");
                          }
                        } else {
                          print(customController.text + " money else");
                          convertController.text =
                              customController.text; //lưu giá trị này
                          print(convertController.text + " convert");
                        }
                      });
                    },
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        counter: Container(), hintText: " Nhập số tiền"),
                    maxLength: 11,
                    controller: customController,
                    inputFormatters: [],
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
                    //gửi tiền
                  })),
        ));
  }
}
