import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:play_together_mobile/models/game_of_user_model.dart';
import 'package:play_together_mobile/models/rank_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/add_new_skills.dart';
import 'package:play_together_mobile/services/game_of_user_service.dart';
import 'package:play_together_mobile/services/rank_service.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateGameSkillsPage extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;

  const UpdateGameSkillsPage(
      {Key? key, required this.userModel, required this.tokenModel})
      : super(key: key);

  @override
  State<UpdateGameSkillsPage> createState() => _UpdateGameSkillsPageState();
}

class _UpdateGameSkillsPageState extends State<UpdateGameSkillsPage> {
  List<GameOfUserModel> listGameOfUser = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllGameOfUser(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: AppBar(
                backgroundColor: Colors.white,
                elevation: 1,
                leading: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: FlatButton(
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
                  'Chỉnh sửa kỹ năng',
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.normal),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: (() async {
                      final check = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddNewSkillsPage(
                                    userModel: widget.userModel,
                                    tokenModel: widget.tokenModel,
                                  )));
                      setState(() {});
                    }),
                    child: const Icon(
                      FontAwesomeIcons.plus,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: List.generate(listGameOfUser.length,
                    (index) => buildSkills(listGameOfUser[index])),
              ),
            ),
          );
        });
  }

  Widget buildSkills(GameOfUserModel _gameOfUserModel) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool checkListRank = false;
    bool checkOnPress = true;
    List<RankModel> listRanksOfGame = [];
    RankModel? rankChoosenModel;

    Future getListRanksOfGame() {
      Future<ResponseListModel<RankModel>?> ranksOfGameFuture = RankService()
          .getAllRanksInGame(
              _gameOfUserModel.gameId, widget.tokenModel.message);
      ranksOfGameFuture.then((value) {
        if (value != null) {
          if (checkOnPress) {
            listRanksOfGame = value.content;
          }
        }
      });
      return ranksOfGameFuture;
    }

    return FutureBuilder(
        future: getListRanksOfGame(),
        builder: (context, snapshot) {
          if (_gameOfUserModel.rankId != "None") {
            checkListRank = true;
          }
          return Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.4,
                      child: Text(
                        _gameOfUserModel.game.name,
                        maxLines: 2,
                        style: GoogleFonts.montserrat(fontSize: 15),
                      ),
                    ),
                    const Spacer(),
                    Visibility(
                      visible: checkListRank,
                      child: SizedBox(
                        width: width * 0.4,
                        height: height * 0.05,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(5)),
                          child: DropdownButtonHideUnderline(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: DropdownButton<RankModel>(
                                isExpanded: true,
                                menuMaxHeight: 5 * 48,
                                hint: Text(
                                  _gameOfUserModel.rank != null
                                      ? _gameOfUserModel.rank!.name
                                      : '',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.black, fontSize: 15),
                                ),
                                value: rankChoosenModel,
                                onChanged: (RankModel? newValue) {
                                  checkOnPress = true;
                                  rankChoosenModel = newValue;
                                  UpdateGameOfUserModel updateGameOfUserModel =
                                      UpdateGameOfUserModel(
                                          rankId: rankChoosenModel!.id);
                                  Future<bool?> updateFuture =
                                      GameOfUserService().updateGameOfUser(
                                          _gameOfUserModel.id,
                                          updateGameOfUserModel,
                                          widget.tokenModel.message);
                                  updateFuture.then((value) {
                                    setState(() {
                                      if (value == true) {
                                        checkOnPress = false;
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text("Cập nhật thành công"),
                                        ));
                                      }
                                    });
                                  });
                                },
                                items: listRanksOfGame
                                    .map<DropdownMenuItem<RankModel>>(
                                        (RankModel value) {
                                  return DropdownMenuItem<RankModel>(
                                    value: value,
                                    child: Text(value.name),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          checkOnPress = true;
                          Future<bool?> deleteFuture = GameOfUserService()
                              .deleteGameOfUser(_gameOfUserModel.id,
                                  widget.tokenModel.message);
                          deleteFuture.then((value) {
                            setState(() {
                              if (value == true) {
                                checkOnPress = false;
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Xóa thành công"),
                                ));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Xóa thất bại"),
                                ));
                              }
                            });
                          });
                        },
                        icon: const Icon(
                          FontAwesomeIcons.solidTrashAlt,
                        )),
                  ],
                ),
                const Divider(
                  height: 10,
                  thickness: 1,
                ),
              ],
            ),
          );
        });
  }

  Future getAllGameOfUser() {
    Future<ResponseListModel<GameOfUserModel>?> gameOfUserFuture = UserService()
        .getGameOfUser(widget.userModel.id, widget.tokenModel.message);
    gameOfUserFuture.then((value) {
      if (value != null) {
        listGameOfUser = value.content;
      }
    });
    return gameOfUserFuture;
  }
}
