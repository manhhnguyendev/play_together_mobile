import 'package:flutter/material.dart';
import 'package:play_together_mobile/pages/hiring_negotiating_page.dart';
import 'package:play_together_mobile/widgets/checkbox_state.dart';
import 'package:play_together_mobile/widgets/decline_button.dart';
import 'package:play_together_mobile/widgets/second_main_button.dart';

class SendHiringRequestPage extends StatefulWidget {
  const SendHiringRequestPage({Key? key}) : super(key: key);

  @override
  _SendHiringRequestPageState createState() => _SendHiringRequestPageState();
}

class _SendHiringRequestPageState extends State<SendHiringRequestPage> {
  bool checkFirstTime = true;
  String profileLink = "assets/images/play_together_logo_text.png";
  int choosenTime = 1;
  int maxHour = 5;
  String beginMessage = '';
  List<int> listHour = [];
  List listGames = ['Liên Minh', 'CSGO', 'Game V'];
  List listGamesCheckBox = [];
  List listGamesChoosen = [];

  void createAListCheckBox() {
    for (var i = 0; i < listGames.length; i++) {
      listGamesCheckBox.add(CheckBoxState(title: listGames[i]));
    }
  }

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
      createAListCheckBox();
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
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
              child: Text(
                'Tựa game bạn chọn ',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 25, 10),
              child: Column(
                children: List.generate(listGamesCheckBox.length,
                    (index) => buildSingleCheckBox(listGamesCheckBox[index])),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HiringNegotiatingPage()),
                  );
                },
                height: 50,
                width: 200),
          ]),
        ));
  }

  Widget buildSingleCheckBox(CheckBoxState cbState) => CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Color(0xff8980FF),
        value: cbState.value,
        onChanged: (value) => setState(() {
          if (value == true) {
            cbState.value = value!;
            listGamesChoosen.add(cbState.title);
            print(listGamesChoosen.toString());
          } else {
            cbState.value = value!;
            listGamesChoosen.remove(cbState.title);
            print(listGamesChoosen.toString());
          }
        }),
        title: Text(
          cbState.title,
          style: TextStyle(fontSize: 15),
        ),
      );
}
