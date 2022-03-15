import 'package:flutter/material.dart';
import 'package:play_together_mobile/pages/hiring_negotiating_page.dart';
import 'package:play_together_mobile/widgets/decline_button.dart';
import 'package:play_together_mobile/widgets/second_main_button.dart';

class SendHiringRequestPage extends StatefulWidget {
  static String routeName = "HiringNegotiation";

  const SendHiringRequestPage({Key? key}) : super(key: key);

  @override
  _SendHiringRequestPageState createState() => _SendHiringRequestPageState();
}

class _SendHiringRequestPageState extends State<SendHiringRequestPage> {
  bool checkFirstTime = true;
  String profileLink = "assets/images/defaultprofile.png";
  int choosenTime = 1;
  int maxHour = 5;
  String beginMessage = '';
  List<int> listHour = [];

  void createHourList() {
    for (var i = 1; i <= maxHour; i++) {
      listHour.add(i);
    }
    choosenTime = listHour[0];
  }

  @override
  Widget build(BuildContext context) {
    if (checkFirstTime) {
      createHourList();
      checkFirstTime = false;
    }
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: FlatButton(
                child: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
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
                    height: 2,
                  ),
                  Text(
                    "status",
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 25, 10),
              child: Row(
                children: [
                  Text(
                    'Thời lượng thuê: ',
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  Container(
                    width: 80,
                    child: DropdownButton(
                      //underline: SizedBox.shrink(),
                      isExpanded: true,
                      value: choosenTime,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: listHour.map((item) {
                        return DropdownMenuItem(
                            child: new Text(item.toString()), value: item);
                      }).toList(),
                      onChanged: (value) {
                        choosenTime = int.parse(value.toString());
                        setState(() {
                          choosenTime = int.parse(value.toString());
                        });
                      },
                    ),
                  ),
                  Text(
                    ' giờ',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 25, 10),
              child: Row(
                children: [
                  Text(
                    'Chi phí tổng ',
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  Text(
                    '1.000.000',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    ' đ',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 25, 10),
              child: Row(
                children: [
                  Text(
                    'Số dư hiện tại ',
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_circle_outline)),
                  Text(
                    '2.000.000',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' đ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
              child: Container(
                height: 250,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: TextFormField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  maxLength: 1000,
                  onSaved: (newValue) => beginMessage = newValue!,
                  decoration: const InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 0, horizontal: 10.0),
                    counterText: "",
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: "Nhập lời nhắn...",
                    hintText: "Nhập vào lời nhắn của bạn",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SecondMainButton(
                text: 'Gửi yêu cầu',
                onpress: () {
                  Navigator.pushNamed(context, HiringNegotiatingPage.routeName);
                },
                height: 50,
                width: 200),
          ]),
        ));
  }
}
