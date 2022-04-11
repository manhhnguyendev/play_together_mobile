import 'package:flutter/material.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/rating_and_comment_page.dart';
import 'package:play_together_mobile/pages/update_game_skills_page.dart';
import 'package:play_together_mobile/widgets/second_main_button.dart';

class ManageHiringPage extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;
  const ManageHiringPage(
      {Key? key, required this.userModel, required this.tokenModel})
      : super(key: key);

  @override
  State<ManageHiringPage> createState() => _ManageHiringPageState();
}

class _ManageHiringPageState extends State<ManageHiringPage> {
  bool checkFirstTime = true;
  bool isPlayer = false;
  int choosenTime = 1;
  int maxHour = 5;
  List<int> listHour = [];
  List<String> listTop3Hirer = ['aaa', 'bbb', 'ccc'];
  List<String> providedGames = ['LOL', 'CSGO', 'Game V'];

  void createHourList() {
    for (var i = 1; i <= maxHour; i++) {
      listHour.add(i);
    }
    choosenTime = listHour[0];
  }

  @override
  Widget build(BuildContext context) {
    var displayController = TextEditingController();
    String money = "";
    double convertMoney = 0;
    if (checkFirstTime) {
      createHourList();
      checkFirstTime = false;
    }
    return Scaffold(
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
            'Quản lý nhận thuê',
            style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.center,
                child: createStatus(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Row(
                children: [
                  Text(
                    'Nhận thuê',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Spacer(),
                  SizedBox(
                    height: 60,
                    width: 80,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Switch(
                          activeColor: Color(0xff8980FF),
                          value: isPlayer,
                          onChanged: (value) {
                            setState(() {
                              isPlayer = value;
                            });
                          }),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Row(
                children: [
                  Text(
                    'Số giờ tối đa',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Spacer(),
                  Container(
                    width: 100,
                    child: IgnorePointer(
                      ignoring: !isPlayer,
                      child: DropdownButton(
                        //underline: SizedBox.shrink(),
                        isExpanded: true,
                        value: choosenTime,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: listHour.map((item) {
                          return DropdownMenuItem(
                            child: new Text(
                              item.toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                            value: item,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            choosenTime = int.parse(value.toString());
                            print(choosenTime.toString() + "toi chon");
                          });
                        },
                      ),
                    ),
                  ),
                  Text(
                    ' giờ',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
              child: Row(
                children: [
                  Text(
                    'Chi phí mỗi giờ',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Spacer(),
                  Container(
                    //decoration: BoxDecoration(border: Border.all()),
                    width: 120,
                    child: TextField(
                      inputFormatters: [ThousandsFormatter()],
                      controller: displayController,
                      onChanged: (value) {
                        setState(() {
                          money = value; //1 VNĐ
                          print(money + " gia tri luu");
                        });
                      },
                      //textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                          counter: Container(), hintText: " Nhập số tiền"),
                      maxLength: 11,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Text('đ',
                      style: TextStyle(fontSize: 15, color: Colors.black)),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: SecondMainButton(
                  text: 'Cập nhật', onpress: () {}, height: 50, width: 200),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Divider(
                thickness: 1,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(15, 5, 5, 0),
              child: Row(
                children: [
                  Text(
                    'Kỹ năng',
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateGameSkillsPage(
                                // userModel: widget.userModel,
                                // tokenModel: widget.tokenModel,
                                )),
                      );
                    },
                    child: Text(
                      'Chỉnh sửa',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 25, 0),
              child: Column(
                children: List.generate(providedGames.length,
                    (index) => buildGamesChoosenField(providedGames[index])),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Divider(
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Container(
                decoration: BoxDecoration(border: Border.all(width: 1)),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Tỷ lệ hoàn thành',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.pie_chart,
                                          size: 30,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          '100' + '%',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.green),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Theo ngày',
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.pie_chart,
                                          size: 30,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          '100' + '%',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.green),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Theo tháng',
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )),
                      VerticalDivider(
                        color: Colors.black,
                        thickness: 1,
                        width: 1,
                      ),
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              print("tap tap");
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => RatingCommentPage()),
                              // );
                            },
                            child: Column(
                              children: [
                                Text(
                                  'Đánh giá',
                                  style: TextStyle(
                                      fontSize: 16,
                                      decoration: TextDecoration.underline),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 50,
                                  color: Colors.yellow,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '4.5',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Container(
                decoration: BoxDecoration(border: Border.all()),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Doanh thu',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                '1.000.000' + 'đ',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.green),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('Theo ngày',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey)),
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Text(
                                '15.000.000' + 'đ',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.green),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('Theo tháng',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createStatus() {
    if (isPlayer) {
      return Text(
        'Sẵn sàng nhận thuê',
        style: TextStyle(fontSize: 18, color: Colors.green),
      );
    } else {
      return Text(
        'Không nhận thuê',
        style: TextStyle(fontSize: 18, color: Colors.grey),
      );
    }
  }

  Widget buildGamesChoosenField(String game) => Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.fromLTRB(15, 5, 25, 5),
        child: Text(
          "• " + game,
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      );
}
