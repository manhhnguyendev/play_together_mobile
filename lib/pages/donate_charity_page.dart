import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:play_together_mobile/models/charity_detail_model.dart';
import 'package:play_together_mobile/widgets/profile_accept_button.dart';

class DonateCharityPage extends StatefulWidget {
  final CharityDetailModel charityDetailModel;
  const DonateCharityPage({Key? key, required this.charityDetailModel})
      : super(key: key);

  @override
  State<DonateCharityPage> createState() => _DonateCharityPageState();
}

class _DonateCharityPageState extends State<DonateCharityPage> {
  MaskedTextController customController = MaskedTextController(
    mask: '000.000.000.000',
  );
  MaskedTextController convertController = MaskedTextController(
    mask: '000000000000', //convert lưu vào DB
  );
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
            widget.charityDetailModel.name,
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
                  //gửi tiền
                })),
      ),
    );
  }
}
