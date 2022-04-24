import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:play_together_mobile/models/game_model.dart';
import 'package:play_together_mobile/models/hobbies_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/services/game_service.dart';
import 'package:play_together_mobile/widgets/checkbox_state.dart';
import 'package:play_together_mobile/widgets/second_main_button.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterPage extends StatefulWidget {
  final TokenModel tokenModel;
  final UserModel userModel;
  final String searchValue;
  final bool sortByRating;
  final bool sortByAlphabet;
  final bool sortByPrice;
  final bool sortByHobby;
  final int sortOrder;
  final String status;
  final int statusOrder;
  final bool isMale;
  final bool isFemale;
  final double startPrice;
  final double endPrice;
  final String defaultGameId;

  const FilterPage(
      {Key? key,
      required this.tokenModel,
      required this.userModel,
      required this.searchValue,
      required this.sortByRating,
      required this.sortByAlphabet,
      required this.sortByPrice,
      required this.sortByHobby,
      required this.sortOrder,
      required this.status,
      required this.isMale,
      required this.isFemale,
      required this.startPrice,
      required this.endPrice,
      required this.defaultGameId,
      required this.statusOrder})
      : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  RangeValues _currentRangeValues = const RangeValues(10000, 5000000);
  List<CheckBoxState> listGamesCheckBox = [];
  List<CreateHobbiesModel> listGameId = [];
  List<PlayerModel> listUserModelFilter = [];
  List<GamesModel> listGames = [];
  List listGamesChoosen = [];
  List listSplitGameId = [];
  List listSplitGameName = [];
  String defaultGameId = "";
  String status = "";
  bool checkFirstTime = true;
  bool checkInitValue = true;
  bool sortByAlphabet = false;
  bool sortByRating = false;
  bool sortByPrice = false;
  bool sortByHobby = false;
  bool isMale = true;
  bool isFemale = true;
  double startPrice = 10000;
  double endPrice = 5000000;
  int sortOrder = 0;
  int statusOrder = 0;

  @override
  Widget build(BuildContext context) {
    if (checkInitValue) {
      sortByRating = widget.sortByRating;
      sortByAlphabet = widget.sortByAlphabet;
      sortByPrice = widget.sortByPrice;
      sortByHobby = widget.sortByHobby;
      sortOrder = widget.sortOrder;
      status = widget.status;
      statusOrder = widget.statusOrder;
      isMale = widget.isMale;
      isFemale = widget.isFemale;
      startPrice = widget.startPrice;
      endPrice = widget.endPrice;
      defaultGameId = widget.defaultGameId;
      listSplitGameId = defaultGameId.split(' ');
      _currentRangeValues = RangeValues(startPrice, endPrice);
      checkInitValue = false;
    }
    return FutureBuilder(
        future: getAllGames(),
        builder: (context, snapshot) {
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
                      Icons.close,
                    ),
                    onPressed: () {
                      Navigator.pop(context, {
                        "searchValue": widget.searchValue,
                        "isMale": widget.isMale,
                        "isFemale": widget.isFemale,
                        "defaultGameId": widget.defaultGameId,
                        "status": widget.status,
                        "sortByAlphabet": widget.sortByAlphabet,
                        "sortByRating": widget.sortByRating,
                        "sortByHobby": widget.sortByHobby,
                        "sortByPrice": widget.sortByPrice,
                        "startPrice": widget.startPrice,
                        "endPrice": widget.endPrice,
                        "sortOrder": widget.sortOrder,
                        "statusOrder": widget.statusOrder,
                      });
                    },
                  ),
                ),
                centerTitle: true,
                title: Text(
                  'Bộ lọc',
                  style: GoogleFonts.montserrat(
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
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                    child: Text(
                      'Lọc theo',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(FontAwesomeIcons.thumbsUp),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Sở thích',
                                style: GoogleFonts.montserrat(
                                    fontWeight: sortOrder == 1
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                              const Spacer(),
                              Radio(
                                  activeColor: const Color(0xff8980FF),
                                  value: 1,
                                  groupValue: sortOrder,
                                  onChanged: (value) {
                                    setState(() {
                                      sortOrder = 1;
                                      sortByHobby = true;
                                      sortByRating = false;
                                      sortByPrice = false;
                                      sortByAlphabet = false;
                                    });
                                  }),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(FontAwesomeIcons.star),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                'Đánh giá',
                                style: GoogleFonts.montserrat(
                                    fontWeight: sortOrder == 2
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                              const Spacer(),
                              Radio(
                                  activeColor: const Color(0xff8980FF),
                                  value: 2,
                                  groupValue: sortOrder,
                                  onChanged: (value) {
                                    setState(() {
                                      sortOrder = 2;
                                      sortByHobby = false;
                                      sortByRating = true;
                                      sortByPrice = false;
                                      sortByAlphabet = false;
                                    });
                                  }),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(FontAwesomeIcons.moneyBill1),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                'Giá tiền',
                                style: GoogleFonts.montserrat(
                                    fontWeight: sortOrder == 3
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                              const Spacer(),
                              Radio(
                                  activeColor: const Color(0xff8980FF),
                                  value: 3,
                                  groupValue: sortOrder,
                                  onChanged: (value) {
                                    setState(() {
                                      sortOrder = 3;
                                      sortByHobby = false;
                                      sortByRating = false;
                                      sortByPrice = false;
                                      sortByAlphabet = false;
                                    });
                                  }),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.abc),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Từ A-Z',
                                style: GoogleFonts.montserrat(
                                    fontWeight: sortOrder == 4
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                              const Spacer(),
                              Radio(
                                  activeColor: const Color(0xff8980FF),
                                  value: 4,
                                  groupValue: sortOrder,
                                  onChanged: (value) {
                                    setState(() {
                                      sortOrder = 4;
                                      sortByHobby = false;
                                      sortByRating = false;
                                      sortByPrice = false;
                                      sortByAlphabet = true;
                                    });
                                  }),
                            ],
                          ),
                        ],
                      )),
                  const Divider(height: 1, thickness: 1),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Text(
                      'Tùy chọn giới tính',
                      style: GoogleFonts.montserrat(
                          fontSize: 18, color: Colors.black),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                activeColor: const Color(0xff8980FF),
                                value: isMale,
                                onChanged: (value) {
                                  setState(() {
                                    isMale = !isMale;
                                  });
                                }),
                            Text(
                              'Nam',
                              style: GoogleFonts.montserrat(),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                activeColor: const Color(0xff8980FF),
                                value: isFemale,
                                onChanged: (value) {
                                  setState(() {
                                    isFemale = !isFemale;
                                  });
                                }),
                            Text('Nữ', style: GoogleFonts.montserrat()),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Divider(height: 1, thickness: 1),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                    child: Text(
                      'Tùy chọn giá thuê mỗi giờ',
                      style: GoogleFonts.montserrat(
                          fontSize: 18, color: Colors.black),
                    ),
                  ),
                  RangeSlider(
                    activeColor: const Color(0xff8980FF),
                    values: _currentRangeValues,
                    max: 5000000,
                    min: 0,
                    divisions: 100,
                    labels: RangeLabels(
                      _currentRangeValues.start.round().toString().toVND(),
                      _currentRangeValues.end.round().toString().toVND(),
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _currentRangeValues = values;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                    child: Row(
                      children: [
                        Text('0đ', style: GoogleFonts.montserrat()),
                        const Spacer(),
                        Text('5.000.000đ', style: GoogleFonts.montserrat())
                      ],
                    ),
                  ),
                  const Divider(height: 1, thickness: 1),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                    child: Text(
                      'Tùy chọn trạng thái của người chơi',
                      style: GoogleFonts.montserrat(
                          fontSize: 18, color: Colors.black),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Tất cả',
                                style: GoogleFonts.montserrat(
                                    fontWeight: statusOrder == 0
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                              const Spacer(),
                              Radio(
                                  activeColor: const Color(0xff8980FF),
                                  value: 0,
                                  groupValue: statusOrder,
                                  onChanged: (value) {
                                    setState(() {
                                      statusOrder = 0;
                                      status = "";
                                    });
                                  }),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Đang online',
                                style: GoogleFonts.montserrat(
                                    fontWeight: statusOrder == 1
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                              const Spacer(),
                              Radio(
                                  activeColor: const Color(0xff8980FF),
                                  value: 1,
                                  groupValue: statusOrder,
                                  onChanged: (value) {
                                    setState(() {
                                      statusOrder = 1;
                                      status = "Online";
                                    });
                                  }),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Đang thương lượng',
                                style: GoogleFonts.montserrat(
                                    fontWeight: statusOrder == 2
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                              const Spacer(),
                              Radio(
                                  activeColor: const Color(0xff8980FF),
                                  value: 2,
                                  groupValue: statusOrder,
                                  onChanged: (value) {
                                    setState(() {
                                      statusOrder = 2;
                                      status = "Processing";
                                    });
                                  }),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Đang được thuê',
                                style: GoogleFonts.montserrat(
                                    fontWeight: statusOrder == 3
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                              const Spacer(),
                              Radio(
                                  activeColor: const Color(0xff8980FF),
                                  value: 3,
                                  groupValue: statusOrder,
                                  onChanged: (value) {
                                    setState(() {
                                      statusOrder = 3;
                                      status = "Hiring";
                                    });
                                  }),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Đang offline',
                                style: GoogleFonts.montserrat(
                                    fontWeight: statusOrder == 4
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                              const Spacer(),
                              Radio(
                                  activeColor: const Color(0xff8980FF),
                                  value: 4,
                                  groupValue: statusOrder,
                                  onChanged: (value) {
                                    setState(() {
                                      statusOrder = 4;
                                      status = "Offline";
                                    });
                                  }),
                            ],
                          ),
                        ],
                      )),
                  const Divider(height: 1, thickness: 1),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                    child: Text(
                      'Chọn các tựa game bạn muốn tìm',
                      style: GoogleFonts.montserrat(
                          fontSize: 18, color: Colors.black),
                    ),
                  ),
                  Column(
                    children: List.generate(
                        listGamesCheckBox.length,
                        (index) =>
                            buildSingleCheckBox(listGamesCheckBox[index])),
                  )
                ],
              ),
            ),
            bottomNavigationBar: BottomAppBar(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: SecondMainButton(
                      text: 'Áp dụng',
                      onPress: () {
                        setState(() {
                          listGameId.clear();
                          listSplitGameId.clear();
                          listSplitGameName.clear();
                          defaultGameId = "";
                        });
                        if (listGamesChoosen.isNotEmpty) {
                          for (var gameChoose in listGamesChoosen) {
                            for (var game in listGames) {
                              if (game.name.contains(gameChoose)) {
                                CreateHobbiesModel getListGameId =
                                    CreateHobbiesModel(gameId: game.id);
                                listGameId.add(getListGameId);
                              }
                            }
                          }
                          for (var id in listGameId) {
                            defaultGameId = defaultGameId + id.gameId + " ";
                          }
                        }
                        listGamesChoosen.clear();
                        Navigator.pop(context, {
                          "searchValue": widget.searchValue,
                          "isMale": isMale,
                          "isFemale": isFemale,
                          "defaultGameId": defaultGameId,
                          "status": status,
                          "sortByAlphabet": sortByAlphabet,
                          "sortByRating": sortByRating,
                          "sortByHobby": sortByHobby,
                          "sortByPrice": sortByPrice,
                          "startPrice": _currentRangeValues.start,
                          "endPrice": _currentRangeValues.end,
                          "sortOrder": sortOrder,
                          "statusOrder": statusOrder,
                        });
                      },
                      height: 50,
                      width: 150),
                )),
          );
        });
  }

  Widget buildListGame(GamesModel gameModel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Row(
        children: [
          Text(
            gameModel.name,
            style: GoogleFonts.montserrat(
                fontWeight: defaultGameId == gameModel.id
                    ? FontWeight.bold
                    : FontWeight.normal),
          ),
          const Spacer(),
          Radio(
              activeColor: const Color(0xff8980FF),
              value: gameModel.id,
              groupValue: defaultGameId,
              onChanged: (value) {
                setState(() {
                  defaultGameId = gameModel.id;
                });
              }),
        ],
      ),
    );
  }

  Widget buildSingleCheckBox(CheckBoxState cbState) => CheckboxListTile(
        activeColor: const Color(0xff8980FF),
        value: cbState.value,
        onChanged: (value) => setState(() {
          if (value == true) {
            cbState.value = value!;
            listGamesChoosen.add(cbState.title);
          } else {
            cbState.value = value!;
            listGamesChoosen.remove(cbState.title);
          }
        }),
        title: Text(
          cbState.title,
          style: GoogleFonts.montserrat(fontSize: 15),
        ),
      );

  Future getAllGames() {
    Future<ResponseListModel<GamesModel>?> gameFuture =
        GameService().getAllGames(widget.tokenModel.message);
    gameFuture.then((value) {
      if (value != null) {
        if (checkFirstTime) {
          setState(() {
            listGames = value.content;
          });
          createAListCheckBox();
          checkFirstTime = false;
        }
      }
    });
    return gameFuture;
  }

  void createAListCheckBox() {
    if (listGames.isEmpty) {
    } else {
      for (var gameId in listSplitGameId) {
        for (var games in listGames) {
          if (gameId == games.id) {
            listSplitGameName.add(games.name);
          }
        }
      }
      for (var i = 0; i < listGames.length; i++) {
        listGamesCheckBox.add(CheckBoxState(title: listGames[i].name));
      }
      for (var checkTrue in listSplitGameName) {
        for (var checkbox in listGamesCheckBox) {
          if (checkTrue == checkbox.title) {
            checkbox.value = true;
          }
        }
      }
      for (var choosen in listGamesCheckBox) {
        if (choosen.value) {
          listGamesChoosen.add(choosen.title);
        }
      }
    }
  }
}
