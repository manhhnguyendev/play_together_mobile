import 'package:flutter/material.dart';
import 'package:play_together_mobile/widgets/second_main_button.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    String profileLink = "assets/images/defaultprofile.png";
    String reason = "";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: FlatButton(
            child: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        centerTitle: true,
        title: Text(
          'Tố cáo',
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.normal),
        ),
      ),
      body: Container(
          child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 150,
            width: 150,
            child: CircleAvatar(
              backgroundImage: AssetImage(profileLink),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Player name",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 25, 10, 20),
            child: Container(
              height: 300,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: TextFormField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                maxLength: 1000,
                onSaved: (newValue) => reason = newValue!,
                decoration: const InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                  counterText: "",
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: "Nhập lý do tố cáo của bạn...",
                  hintText: "Nhập vào lý do tố cáo",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          SecondMainButton(text: 'Gửi', onpress: () {}, height: 50, width: 200),
        ],
      )),
    );
  }
}
