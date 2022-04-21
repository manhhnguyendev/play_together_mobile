import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/game_model.dart';
import 'package:play_together_mobile/models/hobbies_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/services/game_service.dart';
import 'package:play_together_mobile/services/search_service.dart';
import 'package:play_together_mobile/widgets/checkbox_state.dart';
import 'package:play_together_mobile/widgets/second_main_button.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

class FilterPage extends StatefulWidget {
  final TokenModel tokenModel;
  final UserModel userModel;
  final String searchValue;
  final bool sortByRating;
  final bool sortByAlphabet;
  final bool sortByPrice;
  final bool sortByRecommend;
  final int sortOrder;
  final String status;
  final int statusOrder = 0;
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
      required this.sortByRecommend,
      required this.sortOrder,
      required this.status,
      required this.isMale,
      required this.isFemale,
      required this.startPrice,
      required this.endPrice,
      required this.defaultGameId})
      : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String defaultGameId = "";
  bool sortByRating = false;
  bool sortByAlphabet = false;
  bool sortByPrice = false;
  bool sortByRecommend = false;
  int sortOrder = 0;
  String status = "";
  int statusOrder = 0;
  bool isMale = true;
  bool isFemale = true;
  double startPrice = 10000;
  double endPrice = 5000000;
  RangeValues _currentRangeValues = RangeValues(10000, 5000000);
  bool checkInitValue = true;
  List<GamesModel>? listGames;
  List<CheckBoxState> listGamesCheckBox = [];
  List listGamesChoosen = [];
  List<CreateHobbiesModel> listGameId = [];
  List<PlayerModel> listUserModelFilter = [];
  List listSplitGameId = [];
  List listSplitGameName = [];
  bool checkFirstTime = true;
  Future getAllGames() {
    listGames ??= [];
    Future<ResponseListModel<GamesModel>?> gameFuture =
        GameService().getAllGames(widget.tokenModel.message);
    gameFuture.then((value) {
      if (value != null) {
        if (checkFirstTime) {
          setState(() {
            listGames = value.content;
            checkFirstTime = false;
          });
          createAListCheckBox();
        }
      }
    });
    return gameFuture;
  }

  void createAListCheckBox() {
    if (listGames == null) {
    } else {
      for (var gameId in listSplitGameId) {
        for (var games in listGames!) {
          if (gameId == games.id) {
            listSplitGameName.add(games.name);
          }
        }
      }
      for (var item in listSplitGameName) {
        print('List Game Name Split: ' + item);
      }

      for (var i = 0; i < listGames!.length; i++) {
        listGamesCheckBox.add(CheckBoxState(title: listGames![i].name));
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

      for (var choose in listGamesChoosen) {
        print(choose + " init choosen");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (checkInitValue) {
      sortByRating = widget.sortByRating;
      sortByAlphabet = widget.sortByAlphabet;
      sortByPrice = widget.sortByPrice;
      sortByRecommend = widget.sortByRecommend;
      sortOrder = widget.sortOrder;
      status = widget.status;
      statusOrder = widget.statusOrder;
      isMale = widget.isMale;
      isFemale = widget.isFemale;
      startPrice = widget.startPrice;
      endPrice = widget.endPrice;
      defaultGameId = widget.defaultGameId;
      listSplitGameId = defaultGameId.split(' ');

      for (var item in listSplitGameId) {
        print(item);
      }

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
                        "sortByRecommend": widget.sortByRecommend,
                        "sortByPrice": widget.sortByPrice,
                        "sPrice": widget.startPrice,
                        "ePrice": widget.endPrice,
                        "sortOrd": widget.sortOrder,
                        "sttOrder": widget.statusOrder,
                      });
                    },
                  ),
                ),
                centerTitle: true,
                title: const Text(
                  'Bộ lọc',
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
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                    child: Text(
                      'Lọc theo',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.thumb_up_alt_outlined),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Sở thích',
                                style: TextStyle(
                                    fontWeight: sortOrder == 1
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                              Spacer(),
                              Radio(
                                  activeColor: const Color(0xff8980FF),
                                  value: 1,
                                  groupValue: sortOrder,
                                  onChanged: (value) {
                                    setState(() {
                                      sortOrder = 1;
                                      sortByRecommend = true;
                                      sortByRating = false;
                                      sortByPrice = false;
                                      sortByAlphabet = false;
                                    });
                                  }),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.star_border),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Đánh giá',
                                style: TextStyle(
                                    fontWeight: sortOrder == 2
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                              Spacer(),
                              Radio(
                                  activeColor: const Color(0xff8980FF),
                                  value: 2,
                                  groupValue: sortOrder,
                                  onChanged: (value) {
                                    setState(() {
                                      sortOrder = 2;
                                      sortByRecommend = false;
                                      sortByRating = true;
                                      sortByPrice = false;
                                      sortByAlphabet = false;
                                    });
                                  }),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.money),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Giá tiền',
                                style: TextStyle(
                                    fontWeight: sortOrder == 3
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                              Spacer(),
                              Radio(
                                  activeColor: const Color(0xff8980FF),
                                  value: 3,
                                  groupValue: sortOrder,
                                  onChanged: (value) {
                                    setState(() {
                                      sortOrder = 3;
                                      sortByRecommend = false;
                                      sortByRating = false;
                                      sortByPrice = true;
                                      sortByAlphabet = false;
                                    });
                                  }),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.abc_rounded),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Từ A-Z',
                                style: TextStyle(
                                    fontWeight: sortOrder == 4
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                              Spacer(),
                              Radio(
                                  activeColor: const Color(0xff8980FF),
                                  value: 4,
                                  groupValue: sortOrder,
                                  onChanged: (value) {
                                    setState(() {
                                      sortOrder = 4;
                                      sortByRecommend = false;
                                      sortByRating = false;
                                      sortByPrice = false;
                                      sortByAlphabet = true;
                                    });
                                  }),
                            ],
                          ),
                        ],
                      )),
                  Divider(height: 1, thickness: 1),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Text(
                      'Tùy chọn giới tính',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                            Text('Nam'),
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
                            Text('Nữ'),
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(height: 1, thickness: 1),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                    child: Text(
                      'Tùy chọn giá thuê mỗi giờ',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                  Container(
                    child: RangeSlider(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                    child: Row(
                      children: [Text('0đ'), Spacer(), Text('5.000.000đ')],
                    ),
                  ),
                  Divider(height: 1, thickness: 1),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                    child: Text(
                      'Tùy chọn trạng thái của người chơi',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Tất cả',
                                style: TextStyle(
                                    fontWeight: statusOrder == 0
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                              Spacer(),
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
                                'Có thể thuê',
                                style: TextStyle(
                                    fontWeight: statusOrder == 1
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                              Spacer(),
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
                                style: TextStyle(
                                    fontWeight: statusOrder == 2
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                              Spacer(),
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
                                style: TextStyle(
                                    fontWeight: statusOrder == 3
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                              Spacer(),
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
                                style: TextStyle(
                                    fontWeight: statusOrder == 4
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                              Spacer(),
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
                  Divider(height: 1, thickness: 1),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                    child: Text(
                      'Chọn các tựa game bạn muốn tìm',
                      style: TextStyle(fontSize: 18, color: Colors.black),
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
                            for (var game in listGames!) {
                              if (game.name.contains(gameChoose)) {
                                CreateHobbiesModel createHobbies =
                                    CreateHobbiesModel(gameId: game.id);
                                listGameId.add(createHobbies);
                              }
                            }
                          }
                          for (var id in listGameId) {
                            defaultGameId = defaultGameId + id.gameId + " ";
                          }
                        }
                        listGamesChoosen.clear();
                        print(sortOrder.toString() + " sortOrder Filter");
                        print(statusOrder.toString() + " status ord filter");
                        print(_currentRangeValues.start.toString() +
                            " start price filter");
                        print((_currentRangeValues.end.toString() +
                            "end price filter"));
                        Navigator.pop(context, {
                          "searchValue": widget.searchValue,
                          "isMale": isMale,
                          "isFemale": isFemale,
                          "defaultGameId": defaultGameId,
                          "status": status,
                          "sortByAlphabet": sortByAlphabet,
                          "sortByRating": sortByRating,
                          "sortByRecommend": sortByRecommend,
                          "sortByPrice": sortByPrice,
                          "sPrice": _currentRangeValues.start,
                          "ePrice": _currentRangeValues.end,
                          "sortOrd": sortOrder,
                          "sttOrder": statusOrder,
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
            style: TextStyle(
                fontWeight: defaultGameId == gameModel.id
                    ? FontWeight.bold
                    : FontWeight.normal),
          ),
          Spacer(),
          //Checkbox(value: value, onChanged: onChanged)
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
        //controlAffinity: ListTileControlAffinity.leading,
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
          for (var item in listGamesChoosen) {
            print(item + " choosen");
          }
          // print(listGamesChoosen.length.toString() + " choosen");
        }),
        title: Text(
          cbState.title,
          style: const TextStyle(fontSize: 15),
        ),
      );
}
