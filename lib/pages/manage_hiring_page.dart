// ignore_for_file: unused_local_variable

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
import 'package:google_fonts/google_fonts.dart';

class ManageHiringPage extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;

  const ManageHiringPage({
    Key? key,
    required this.userModel,
    required this.tokenModel,
  }) : super(key: key);

  @override
  State<ManageHiringPage> createState() => _ManageHiringPageState();
}

class _ManageHiringPageState extends State<ManageHiringPage> {
  final displayController = TextEditingController();
  final formatter = NumberFormat('###,###,###');
  late List<OnlineHourModel> mondayList;
  late List<OnlineHourModel> tuesdayList;
  late List<OnlineHourModel> wednesdayList;
  late List<OnlineHourModel> thursdayList;
  late List<OnlineHourModel> fridayList;
  late List<OnlineHourModel> saturdayList;
  late List<OnlineHourModel> sundayList;
  bool isPlayer = false;
  bool checkFirstTime = true;
  bool checkDataFirstTime = true;
  bool checkOnPress = true;
  bool checkOnChange = true;
  double pricePerHour = 10000;
  double convertMoney = 0;
  int maxHourHire = 1;
  int choosenTime = 0;
  int maxHour = 5;
  String money = "";
  List<int> listHour = [];
  List<OnlineHourModel> listOnlineHours = [];
  List<GameOfUserModel> listGamesOfUser = [];
  UserServiceModel? lateUserService;
  bool isLoading = false;
  bool checkGameOfUserEmpty = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserService(),
        builder: (context, snapshot) {
          if (checkFirstTime) {
            createHourList();
            displayController.text = formatter.format(pricePerHour);
            checkFirstTime = false;
          }
          if (lateUserService == null) {
            isLoading = true;
          } else {
            isLoading = false;
          }
          return Scaffold(
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
                  'Quản lý nhận thuê',
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                ),
              ),
            ),
            body: isLoading
                ? const Center(
                    child: SizedBox(
                      height: 40.0,
                      width: 40.0,
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Color.fromRGBO(137, 128, 255, 1))),
                    ),
                  )
                : SingleChildScrollView(
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
                                padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                                child: Row(
                                  children: [
                                    Text(
                                      'Nhận yêu cầu thuê',
                                      style:
                                          GoogleFonts.montserrat(fontSize: 18),
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      height: 60,
                                      width: 80,
                                      child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: Switch(
                                            activeColor:
                                                const Color(0xff8980FF),
                                            value: isPlayer,
                                            onChanged: (value) {
                                              if (listGamesOfUser.isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content: Text(
                                                      "Thêm kỹ năng để cập nhật trạng thái"),
                                                ));
                                              } else {
                                                checkOnChange = true;
                                                isPlayer = value;
                                                IsPlayerModel isPlayerModel =
                                                    IsPlayerModel(
                                                        isPlayer: isPlayer);
                                                Future<bool?> updateIsPlayer =
                                                    UserService()
                                                        .updateIsPlayer(
                                                            isPlayerModel,
                                                            widget.tokenModel
                                                                .message);
                                                updateIsPlayer.then((value) {
                                                  if (value == true) {
                                                    setState(() {
                                                      checkOnChange = false;
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                        content: Text(
                                                            "Cập nhật trạng thái thành công"),
                                                      ));
                                                    });
                                                  }
                                                });
                                              }
                                            }),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                child: Row(
                                  children: [
                                    Text(
                                      'Số giờ tối đa',
                                      style:
                                          GoogleFonts.montserrat(fontSize: 18),
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      width: 100,
                                      child: DropdownButton(
                                        isExpanded: true,
                                        value: maxHourHire,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        items: listHour.map((item) {
                                          return DropdownMenuItem(
                                            child: Text(
                                              item.toString(),
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 18),
                                            ),
                                            value: item,
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            maxHourHire =
                                                int.parse(value.toString());
                                          });
                                        },
                                      ),
                                    ),
                                    Text(
                                      ' giờ',
                                      style:
                                          GoogleFonts.montserrat(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                child: Row(
                                  children: [
                                    Text(
                                      'Chi phí mỗi giờ',
                                      style:
                                          GoogleFonts.montserrat(fontSize: 18),
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      width: 120,
                                      child: TextField(
                                        inputFormatters: [ThousandsFormatter()],
                                        controller: displayController,
                                        onChanged: (value) {
                                          setState(() {
                                            money = value;
                                          });
                                        },
                                        style: GoogleFonts.montserrat(
                                            fontSize: 18),
                                        decoration: InputDecoration(
                                          counter: Container(),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xff320444),
                                                      width: 1)),
                                        ),
                                        maxLength: 11,
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    Text('đ',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 18)),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: SecondMainButton(
                                    text: 'Cập nhật',
                                    onPress: () {
                                      if (money.isEmpty || money == "") {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "Vui lòng nhập chi phí mỗi giờ!"),
                                        ));
                                      } else if (money.length < 5) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "Chi phí mỗi giờ tối thiểu là 10.000đ"),
                                        ));
                                      } else if (double.parse(
                                              money.replaceAll(",", "")) >=
                                          5000000) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "Chi phí mỗi giờ tối đa là 5.000.000đ"),
                                        ));
                                      } else {
                                        checkOnPress = true;
                                        money = money.replaceAll(",", "");
                                        convertMoney = double.parse(money);
                                        ServiceUserModel serviceUserModel =
                                            ServiceUserModel(
                                                pricePerHour: convertMoney,
                                                maxHourHire: maxHourHire);
                                        Future<bool?>
                                            updatePersonalServiceInfo =
                                            UserService()
                                                .updatePersonalServiceInfo(
                                                    serviceUserModel,
                                                    widget.tokenModel.message);
                                        updatePersonalServiceInfo.then((value) {
                                          if (value == true) {
                                            setState(() {
                                              checkOnPress = false;
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content:
                                                    Text("Cập nhật thành công"),
                                              ));
                                            });
                                          }
                                        });
                                      }
                                    },
                                    height: 50,
                                    width: 180),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                child: Divider(
                                  thickness: 1,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding:
                                    const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                child: Row(
                                  children: [
                                    Text(
                                      'Kỹ năng',
                                      style:
                                          GoogleFonts.montserrat(fontSize: 18),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () async {
                                        final check = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateGameSkillsPage(
                                                    tokenModel:
                                                        widget.tokenModel,
                                                    userModel: widget.userModel,
                                                  )),
                                        );
                                        setState(() {});
                                      },
                                      child: Text(
                                        'Chỉnh sửa kỹ năng',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: FutureBuilder(
                                    future: getGameOfUser(),
                                    builder: (context, snapshot) {
                                      if (listGamesOfUser.isEmpty) {
                                        checkGameOfUserEmpty = true;
                                      } else {
                                        checkGameOfUserEmpty = false;
                                      }
                                      return Column(
                                        children: [
                                          Column(
                                            children: List.generate(
                                                listGamesOfUser.isNotEmpty
                                                    ? listGamesOfUser.length
                                                    : 0,
                                                (index) => buildGameOfUser(
                                                    listGamesOfUser[index])),
                                          ),
                                          Visibility(
                                            visible: checkGameOfUserEmpty,
                                            child: Container(
                                                alignment: Alignment.centerLeft,
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: Text(' Không có dữ liệu',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 15))),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                child: Divider(
                                  thickness: 1,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding:
                                    const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                child: Row(
                                  children: [
                                    Text(
                                      'Giờ online',
                                      style:
                                          GoogleFonts.montserrat(fontSize: 18),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () async {
                                        final check = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateHourPage(
                                                    tokenModel:
                                                        widget.tokenModel,
                                                    userModel: widget.userModel,
                                                  )),
                                        );
                                        setState(() {});
                                      },
                                      child: Text(
                                        'Chỉnh sửa giờ',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Icon(
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
                                      padding: const EdgeInsets.fromLTRB(
                                          30, 5, 0, 5),
                                      child: Text(
                                        'Thứ 2:',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 15),
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
                                      padding: const EdgeInsets.fromLTRB(
                                          30, 5, 0, 5),
                                      child: Text(
                                        'Thứ 3:',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 15),
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
                                      padding: const EdgeInsets.fromLTRB(
                                          30, 5, 0, 5),
                                      child: Text(
                                        'Thứ 4:',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 15),
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
                                      padding: const EdgeInsets.fromLTRB(
                                          30, 5, 0, 5),
                                      child: Text(
                                        'Thứ 5:',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 15),
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
                                      padding: const EdgeInsets.fromLTRB(
                                          30, 5, 0, 5),
                                      child: Text(
                                        'Thứ 6:',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 15),
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
                                      padding: const EdgeInsets.fromLTRB(
                                          30, 5, 0, 5),
                                      child: Text(
                                        'Thứ 7:',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 15),
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
                                      padding: const EdgeInsets.fromLTRB(
                                          30, 5, 0, 5),
                                      child: Text(
                                        'Chủ Nhật:',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 15),
                                      ),
                                    ),
                                    buildListDating(sundayList),
                                  ],
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
        'Sẵn sàng nhận yêu cầu thuê',
        style: GoogleFonts.montserrat(
            fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold),
      );
    } else {
      return Text(
        'Ngừng nhận yêu cầu thuê',
        style: GoogleFonts.montserrat(
            fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold),
      );
    }
  }

  Widget buildGameOfUser(GameOfUserModel gameOfUser) {
    if (listGamesOfUser.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Container(
          alignment: Alignment.topLeft,
          child: Column(
            children: [
              Row(children: [
                Text(
                  (gameOfUser.game.name),
                  style: GoogleFonts.montserrat(fontSize: 15),
                ),
                Text(
                    gameOfUser.rankId != "None"
                        ? (gameOfUser.rank != null
                            ? " : " + gameOfUser.rank!.name
                            : '')
                        : '',
                    style: GoogleFonts.montserrat(fontSize: 15)),
              ]),
            ],
          ),
        ),
      );
    } else {
      return Text('Không có dữ liệu',
          style: GoogleFonts.montserrat(fontSize: 15));
    }
  }

  Widget buildListDating(List<OnlineHourModel> listDating) {
    if (listDating.isNotEmpty) {
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
      return Text(' Không có dữ liệu',
          style: GoogleFonts.montserrat(fontSize: 15));
    }
  }

  Widget buildSingleDatingPerDay(OnlineHourModel model) {
    String rawFromHour = getTimeString(model.fromHour);
    String rawToHour = getTimeString(model.toHour);
    return Text(rawFromHour + ' - ' + rawToHour + ', ',
        style: GoogleFonts.montserrat(fontSize: 15));
  }

  Widget buildSingleDatingLastDay(OnlineHourModel model) {
    String rawFromHour = getTimeString(model.fromHour);
    String rawToHour = getTimeString(model.toHour);
    return Text(rawFromHour + ' - ' + rawToHour,
        style: GoogleFonts.montserrat(fontSize: 15));
  }

  String getTimeString(int value) {
    final int hour = value ~/ 60;
    final int minutes = value % 60;
    return '${hour.toString().padLeft(2, "0")}:${minutes.toString().padLeft(2, "0")}';
  }

  Future getAllDatings() {
    Future<ResponseListModel<OnlineHourModel>?> getDatingsFuture =
        DatingService()
            .getAllDatings(widget.userModel.id, widget.tokenModel.message);
    getDatingsFuture.then((value) {
      if (value != null) {
        listOnlineHours = value.content;
      }
    });
    return getDatingsFuture;
  }

  Future getGameOfUser() {
    Future<ResponseListModel<GameOfUserModel>?> gameOfUserFuture = UserService()
        .getGameOfUser(widget.userModel.id, widget.tokenModel.message);
    gameOfUserFuture.then((value) {
      if (value != null) {
        listGamesOfUser = value.content;
      }
    });
    return gameOfUserFuture;
  }

  Future getUserService() {
    Future<ResponseModel<UserServiceModel>?> getUserServiceFuture =
        UserService()
            .getUserServiceById(widget.userModel.id, widget.tokenModel.message);
    getUserServiceFuture.then((value) {
      if (value != null) {
        if (checkOnPress || checkOnChange) {
          setState(() {
            lateUserService = value.content;
            isPlayer = lateUserService?.isPlayer ?? false;
            pricePerHour = lateUserService?.pricePerHour ?? 10000;
            maxHourHire = lateUserService?.maxHourHire ?? 1;
            displayController.text = formatter.format(pricePerHour);
            checkOnPress = false;
            checkOnChange = false;
          });
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

  void loadDating() {
    mondayList = [];
    tuesdayList = [];
    wednesdayList = [];
    thursdayList = [];
    fridayList = [];
    saturdayList = [];
    sundayList = [];
    if (listOnlineHours.isNotEmpty) {
      for (var hour in listOnlineHours) {
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
