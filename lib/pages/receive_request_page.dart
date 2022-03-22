import 'package:flutter/material.dart';
import 'package:play_together_mobile/pages/hiring_stage_page.dart';
import 'package:play_together_mobile/widgets/decline_button.dart';
import 'package:play_together_mobile/widgets/second_main_button.dart';

class ReceiveRequestPage extends StatefulWidget {
  //final TestModel testModel;
  const ReceiveRequestPage({Key? key}) : super(key: key);
  @override
  State<ReceiveRequestPage> createState() => _ReceiveRequestPageState();
}

class _ReceiveRequestPageState extends State<ReceiveRequestPage> {
  String firstMessage = 'Alo alo?';
  String profileLink = "assets/images/defaultprofile.png";
  List listGamesChoosen = ['Liên Minh', 'CSGO'];

  createAlertDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Từ chối nhận đơn thuê này?"),
              content: TextField(
                controller: customController,
              ), // TextField
              actions: <Widget>[
                MaterialButton(
                  elevation: 5.0,
                  child: Text('Không'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                MaterialButton(
                  elevation: 5.0,
                  child: Text('Có'),
                  onPressed: () {
                    // // widget.testModel.status = "Denied";
                    // // widget.testModel.reason = customController.text;
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) =>
                    //           TestOrder(testModel: testModel)),
                    // );
                  },
                ) // MaterialButton
                // <Widget>[]
              ] // AlertDialog
              );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [],
        centerTitle: true,
        title: Text(
          'Yêu cầu nhận được',
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.normal),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 120,
                      width: 120,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(profileLink),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 15, 0),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Hirer Name',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Thời lượng: ',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Spacer(),
                                Text(
                                  '2' + ' giờ',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Chi phí: ',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Spacer(),
                                Text(
                                  '1.000.000' + 'đ',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ],
                        ),
                      ))
                ],
              )),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(15, 15, 25, 0),
            child: Text(
              'Tựa game đã chọn: ',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 25, 15),
            child: Column(
              children: List.generate(listGamesChoosen.length,
                  (index) => buildGamesChoosenField(listGamesChoosen[index])),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Container(
                alignment: Alignment.centerLeft,
                child: Text('Lời nhắn:', style: TextStyle(fontSize: 18))),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
            child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(border: Border.all()),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    firstMessage,
                    style: TextStyle(fontSize: 18),
                  ),
                )),
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Nhắn tin ',
                      style: TextStyle(
                          fontSize: 18, decoration: TextDecoration.underline)),
                  Icon(
                    Icons.message_outlined,
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
          Divider(
            thickness: 1,
            indent: 15,
            endIndent: 15,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Column(
              children: [
                SecondMainButton(
                    text: 'Chấp nhận',
                    onpress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HiringPage()),
                      );
                    },
                    height: 50,
                    width: 300),
                DeclineButton(
                    text: 'Từ chối',
                    onpress: () {
                      createAlertDialog(context);
                    },
                    height: 50,
                    width: 300)
              ],
            ),
          )
        ],
      )),
    );
  }

  Widget buildGamesChoosenField(String game) => Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.fromLTRB(15, 5, 25, 5),
        child: Text(
          "- " + game,
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      );
}
