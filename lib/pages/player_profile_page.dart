import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:play_together_mobile/models/game_of_user_model.dart';
import 'package:play_together_mobile/models/online_hour_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/rating_and_comment_page.dart';
import 'package:play_together_mobile/pages/send_hiring_request_page.dart';
import 'package:play_together_mobile/services/datings_service.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:play_together_mobile/widgets/second_main_button.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:google_fonts/google_fonts.dart';

class PlayerProfilePage extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;
  final PlayerModel playerModel;

  const PlayerProfilePage({
    Key? key,
    required this.userModel,
    required this.playerModel,
    required this.tokenModel,
  }) : super(key: key);

  @override
  State<PlayerProfilePage> createState() => _PlayerProfilePageState();
}

class _PlayerProfilePageState extends State<PlayerProfilePage> {
  List listPlayerImage = [];
  List<GameOfUserModel> listGameAndRank = [];
  List<OnlineHourModel> listOnlineHours = [];
  late List<OnlineHourModel> mondayList;
  late List<OnlineHourModel> tuesdayList;
  late List<OnlineHourModel> wednesdayList;
  late List<OnlineHourModel> thursdayList;
  late List<OnlineHourModel> fridayList;
  late List<OnlineHourModel> saturdayList;
  late List<OnlineHourModel> sundayList;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getGameOfUser(),
        builder: (context, snapshot) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: FlatButton(
                    child: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
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
                        Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 160,
                                width: 160,
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(widget.playerModel.avatar),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.playerModel.name,
                                style: GoogleFonts.montserrat(fontSize: 22),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              createStatus(widget.playerModel.status),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                          child: Row(
                            children: [
                              Text(
                                'Hình ảnh ',
                                style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                FontAwesomeIcons.image,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: List.generate(
                                  widget.playerModel.images.isNotEmpty
                                      ? widget.playerModel.images.length
                                      : 0,
                                  (index) => buildImageItem(widget
                                      .playerModel.images[index].imageLink))),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 1,
                          decoration: const BoxDecoration(
                              border: Border(
                            top: BorderSide(
                              color: Colors.grey,
                              width: 0.1,
                            ),
                          )),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RatingCommentPage(
                                        userModel: widget.userModel,
                                        tokenModel: widget.tokenModel,
                                        playerModel: widget.playerModel,
                                      )),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 10, 0, 15),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Đánh giá',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(
                                      FontAwesomeIcons.solidStar,
                                      color: Colors.amber,
                                      size: 15,
                                    ),
                                    Text(
                                      ' ' +
                                          widget.playerModel.rate
                                              .toStringAsFixed(1),
                                      style:
                                          GoogleFonts.montserrat(fontSize: 15),
                                    ),
                                    Text(
                                      "(" +
                                          widget.playerModel.numOfRate
                                              .toString() +
                                          ")",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 15, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Chi tiết đánh giá',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 1,
                          decoration: const BoxDecoration(
                              border: Border(
                            top: BorderSide(
                              color: Colors.grey,
                              width: 0.1,
                            ),
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Thông tin',
                              style: GoogleFonts.montserrat(
                                  fontSize: 20, fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              (widget.playerModel.description),
                              style: GoogleFonts.montserrat(
                                  fontSize: 15, fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        Container(
                          height: 1,
                          decoration: const BoxDecoration(
                              border: Border(
                            top: BorderSide(
                              color: Colors.grey,
                              width: 0.1,
                            ),
                          )),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Kỹ năng',
                              style: GoogleFonts.montserrat(
                                  fontSize: 20, fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Column(
                              children: List.generate(
                                  listGameAndRank.isNotEmpty
                                      ? listGameAndRank.length
                                      : 0,
                                  (index) => buildGameAndRankPlayer(
                                      listGameAndRank[index])),
                            ),
                          ),
                        ),
                        Container(
                          height: 1,
                          decoration: const BoxDecoration(
                              border: Border(
                            top: BorderSide(
                              color: Colors.grey,
                              width: 0.1,
                            ),
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Giờ online',
                              style: GoogleFonts.montserrat(
                                  fontSize: 20, fontWeight: FontWeight.normal),
                            ),
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
                                  style: GoogleFonts.montserrat(fontSize: 15),
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
                                  style: GoogleFonts.montserrat(fontSize: 15),
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
                                  style: GoogleFonts.montserrat(fontSize: 15),
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
                                  style: GoogleFonts.montserrat(fontSize: 15),
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
                                  style: GoogleFonts.montserrat(fontSize: 15),
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
                                  style: GoogleFonts.montserrat(fontSize: 15),
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
                                  style: GoogleFonts.montserrat(fontSize: 15),
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
            bottomNavigationBar: BottomAppBar(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Row(
                  children: [
                    Text(
                      widget.playerModel.pricePerHour
                              .toStringAsFixed(0)
                              .toVND() +
                          '/h',
                      style: GoogleFonts.montserrat(
                          fontSize: 22, color: const Color(0xff320444)),
                    ),
                    const Spacer(),
                    SecondMainButton(
                        text: 'Thuê',
                        onpress: () {
                          if (widget.userModel.isPlayer == true) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                  "Bạn không thể thuê, vui lòng tắt nhận thuê để thực hiện"),
                            ));
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SendHiringRequestPage(
                                        userModel: widget.userModel,
                                        listGameAndRank: listGameAndRank,
                                        playerModel: widget.playerModel,
                                        tokenModel: widget.tokenModel,
                                      )),
                            );
                          }
                        },
                        height: 50,
                        width: 140),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget buildImageItem(String imageLink) => Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: NetworkImage(imageLink), fit: BoxFit.cover)),
        ),
      );

  Widget buildGameAndRankPlayer(GameOfUserModel gameOfUser) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
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
                          ? " : " + gameOfUser.rank.name
                          : '')
                      : '',
                  style: GoogleFonts.montserrat(fontSize: 15)),
            ]),
            const SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }

  Widget createStatus(String status) {
    if (status == 'Hiring') {
      return Text(
        'Đang được thuê',
        style: GoogleFonts.montserrat(fontSize: 18, color: Colors.red),
      );
    }

    if (status == 'Processing') {
      return Text(
        'Đang xử lý',
        style: GoogleFonts.montserrat(fontSize: 18, color: Colors.amber),
      );
    }

    if (status == 'Offline') {
      return Text(
        'Đang offline',
        style: GoogleFonts.montserrat(fontSize: 18, color: Colors.grey),
      );
    }

    if (status == 'Online') {
      return Text(
        'Có thể thuê',
        style: GoogleFonts.montserrat(fontSize: 18, color: Colors.green),
      );
    }

    return Text(
      status,
      style: GoogleFonts.montserrat(fontSize: 18, color: Colors.black),
    );
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
    return Text(rawFromHour + ' : ' + rawToHour + ', ',
        style: GoogleFonts.montserrat(fontSize: 15));
  }

  Widget buildSingleDatingLastDay(OnlineHourModel model) {
    String rawFromHour = getTimeString(model.fromHour);
    String rawToHour = getTimeString(model.toHour);
    return Text(rawFromHour + ' : ' + rawToHour,
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
        .getGameOfUser(widget.playerModel.id, widget.tokenModel.message);
    gameOfUserFuture.then((value) {
      if (value != null) {
        listGameAndRank = value.content;
      }
    });
    return gameOfUserFuture;
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
