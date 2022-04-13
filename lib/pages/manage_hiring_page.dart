import 'package:flutter/material.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:play_together_mobile/models/game_of_user_model.dart';
import 'package:play_together_mobile/models/online_hour_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/update_game_skills_page.dart';
import 'package:play_together_mobile/pages/update_hour_page.dart';
import 'package:play_together_mobile/services/datings_service.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:play_together_mobile/widgets/second_main_button.dart';
import 'package:intl/intl.dart';

class ManageHiringPage extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;
  final UserServiceModel? userServiceModel;

  const ManageHiringPage(
      {Key? key,
      required this.userModel,
      required this.tokenModel,
      this.userServiceModel})
      : super(key: key);

  @override
  State<ManageHiringPage> createState() => _ManageHiringPageState();
}

class _ManageHiringPageState extends State<ManageHiringPage> {
  late UserServiceModel lateUserService;
  late bool isPlayer;
  late double pricePerHour;
  late int maxHourHire;
  bool checkOnPress = true;
  bool checkFirstTime = true;
  int choosenTime = 0;
  int maxHour = 5;
  List<int> listHour = [];
  String money = "";
  double convertMoney = 0;
  List<OnlineHourModel> allDatings = [];
  late List<OnlineHourModel> mondayList;
  late List<OnlineHourModel> tuesdayList;
  late List<OnlineHourModel> wednesdayList;
  late List<OnlineHourModel> thursdayList;
  late List<OnlineHourModel> fridayList;
  late List<OnlineHourModel> saturdayList;
  late List<OnlineHourModel> sundayList;
  List<GameOfUserModel> listGameAndRank = [];
  final displayController = TextEditingController();
  var formatter = NumberFormat('###,###,###');

  String getTimeString(int value) {
    final int hour = value ~/ 60;
    final int minutes = value % 60;
    return '${hour.toString().padLeft(2, "0")}:${minutes.toString().padLeft(2, "0")}';
  }

  Future getGameOfUser() {
    Future<ResponseListModel<GameOfUserModel>?> gameOfUserFuture = UserService()
        .getGameOfUser(widget.userModel.id, widget.tokenModel.message);
    gameOfUserFuture.then((value) {
      if (value != null) {
        listGameAndRank = value.content;
        print(listGameAndRank.length);
      }
    });
    return gameOfUserFuture;
  }

  Future getAllDatings() {
    Future<ResponseListModel<OnlineHourModel>?> getDatingsFuture =
        DatingService()
            .getAllDatings(widget.userModel.id, widget.tokenModel.message);
    getDatingsFuture.then((value) {
      if (value != null) {
        allDatings = value.content;
      }
    });
    return getDatingsFuture;
  }

  Future getUserService() {
    Future<ResponseModel<UserServiceModel>?> getUserServiceFuture =
        UserService()
            .getUserServiceById(widget.userModel.id, widget.tokenModel.message);
    getUserServiceFuture.then((value) {
      if (value != null) {
        if (checkOnPress) {
          lateUserService = value.content;
        }
      }
    });
    return getUserServiceFuture;
  }

  void createHourList() {
    for (var i = 1; i <= maxHour; i++) {
      listHour.add(i);
    }
    choosenTime = listHour[0];
  }

  void loadUserService() {
    isPlayer = widget.userServiceModel!.isPlayer;
    pricePerHour = widget.userServiceModel!.pricePerHour;
    maxHourHire = widget.userServiceModel!.maxHourHire;
    // displayController.text = pricePerHour.toStringAsFixed(0);
    displayController.text = formatter.format(pricePerHour);
  }

  void loadDating() {
    mondayList = [];
    tuesdayList = [];
    wednesdayList = [];
    thursdayList = [];
    fridayList = [];
    saturdayList = [];
    sundayList = [];
    if (allDatings != null) {
      if (allDatings.length > 0) {
        for (var hour in allDatings) {
          switch (hour.dayInWeek) {
            case 2:
              mondayList.add(hour);
              break;
            case 3:
              tuesdayList.add(hour);
              break;
            case 4:
              wednesdayList.add(hour);
              break;
            case 5:
              thursdayList.add(hour);
              break;
            case 6:
              fridayList.add(hour);
              break;
            case 7:
              saturdayList.add(hour);
              break;
            case 8:
              sundayList.add(hour);
              break;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserService(),
        builder: (context, snapshot) {
          if (checkFirstTime) {
            loadUserService();
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
              child: FutureBuilder(
                  future: getAllDatings(),
                  builder: (context, snapshot) {
                    loadDating();
                    return Column(
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
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
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
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                              Spacer(),
                              Container(
                                width: 100,
                                child: DropdownButton(
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
                                      print(
                                          choosenTime.toString() + "toi chon");
                                    });
                                  },
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
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                              Spacer(),
                              Container(
                                //decoration: BoxDecoration(border: Border.all()),
                                width: 120,
                                child: TextField(
                                  inputFormatters: [ThousandsFormatter()],
                                  controller: displayController,
                                  onChanged: (value) {
                                    // setState(() {
                                    //   money = value; //1 VNĐ
                                    //   print(money + " gia tri luu");
                                    // });
                                    // money = money.replaceAll(",", "");
                                    // convertMoney = double.parse(money);
                                  },
                                  //textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 15),
                                  decoration: InputDecoration(
                                      counter: Container(),
                                      hintText: " Nhập số tiền"),
                                  maxLength: 11,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              Text('đ',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black)),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: SecondMainButton(
                              text: 'Cập nhật',
                              onpress: () {},
                              height: 50,
                              width: 200),
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
                                onTap: () async {
                                  final check = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateGameSkillsPage(
                                              tokenModel: widget.tokenModel,
                                              userModel: widget.userModel,
                                            )),
                                  );
                                  setState(() {});
                                },
                                child: Text(
                                  'Chỉnh sửa kỹ năng',
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
                          padding: const EdgeInsets.fromLTRB(15, 5, 20, 10),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: FutureBuilder(
                              future: getGameOfUser(),
                              builder: (context, snapshot) {
                                return Column(
                                  children: List.generate(
                                      listGameAndRank != null
                                          ? listGameAndRank.length
                                          : 0,
                                      (index) => buildGameOfUser(
                                          listGameAndRank[index])),
                                );
                              },
                            ),
                          ),
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
                                'Giờ online',
                                style: TextStyle(fontSize: 18),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  final check = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UpdateHourPage(
                                              tokenModel: widget.tokenModel,
                                              userModel: widget.userModel,
                                            )),
                                  );
                                  setState(() {});
                                },
                                child: Text(
                                  'Chỉnh sửa giờ',
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
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(30, 5, 0, 5),
                                child: Text(
                                  'Thứ 2:',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              buildListDating(mondayList),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(30, 5, 0, 5),
                                child: Text(
                                  'Thứ 3:',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              buildListDating(tuesdayList),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(30, 5, 0, 5),
                                child: Text(
                                  'Thứ 4:',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              buildListDating(wednesdayList),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(30, 5, 0, 5),
                                child: Text(
                                  'Thứ 5:',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              buildListDating(thursdayList),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(30, 5, 0, 5),
                                child: Text(
                                  'Thứ 6:',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              buildListDating(fridayList),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(30, 5, 0, 5),
                                child: Text(
                                  'Thứ 7:',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              buildListDating(saturdayList),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(30, 5, 0, 5),
                                child: Text(
                                  'Chủ Nhật: ',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              buildListDating(sundayList),
                            ],
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
                            decoration:
                                BoxDecoration(border: Border.all(width: 1)),
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                                          fontSize: 16,
                                                          color: Colors.grey),
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
                                                          fontSize: 16,
                                                          color: Colors.grey),
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
                                                  decoration:
                                                      TextDecoration.underline),
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
                                                  fontSize: 16,
                                                  color: Colors.black),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 0, 15, 10),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            '1.000.000' + 'đ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.green),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text('Theo ngày',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey)),
                                        ],
                                      ),
                                      Spacer(),
                                      Column(
                                        children: [
                                          Text(
                                            '15.000.000' + 'đ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.green),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text('Theo tháng',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey)),
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
                    );
                  }),
            ),
          );
        });
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

  Widget buildGameOfUser(GameOfUserModel gameOfUser) => Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
          alignment: Alignment.topLeft,
          child: Column(
            children: [
              Row(children: [
                Text(
                  ('• ' + gameOfUser.game.name),
                  style: const TextStyle(fontSize: 15),
                ),
                Text(
                    gameOfUser.rankId != "None"
                        ? (gameOfUser.rank != null
                            ? " : " + gameOfUser.rank.name
                            : '')
                        : '',
                    style: const TextStyle(fontSize: 15)),
              ]),
              const SizedBox(
                height: 5,
              )
            ],
          ),
        ),
      );

  Widget buildListDating(List<OnlineHourModel> listDating) {
    if (listDating.length > 0) {
      return Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: List.generate(listDating.length, (index) {
            if (index == listDating.length - 1) {
              return buildSingleDatingLastDay(listDating[index]);
            } else {
              return buildSingleDatingPerDay(listDating[index]);
            }
          }),
        ),
      );
    } else {
      return Text(' Không có dữ liệu');
    }
  }

  Widget buildSingleDatingPerDay(OnlineHourModel model) {
    String rawFromHour = getTimeString(model.fromHour);
    String rawToHour = getTimeString(model.toHour);
    return Container(
      child: Text(rawFromHour + ' : ' + rawToHour + ', '),
    );
  }

  Widget buildSingleDatingLastDay(OnlineHourModel model) {
    String rawFromHour = getTimeString(model.fromHour);
    String rawToHour = getTimeString(model.toHour);
    return Container(
      child: Text(rawFromHour + ' : ' + rawToHour),
    );
  }
}
