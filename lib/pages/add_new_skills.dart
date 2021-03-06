import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/game_of_user_model.dart';
import 'package:play_together_mobile/services/game_of_user_service.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:play_together_mobile/widgets/profile_accept_button.dart';
import 'package:play_together_mobile/models/game_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/services/game_service.dart';
import 'package:play_together_mobile/widgets/checkbox_state.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNewSkillsPage extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;

  const AddNewSkillsPage(
      {Key? key, required this.userModel, required this.tokenModel})
      : super(key: key);

  @override
  State<AddNewSkillsPage> createState() => _AddNewSkillsPageState();
}

class _AddNewSkillsPageState extends State<AddNewSkillsPage> {
  bool checkFirstTime = true;
  List<CreateGameOfUserModel> listCreateGameOfUser = [];
  List<GameOfUserModel> listGameOfUser = [];
  List<CheckBoxState> listGamesCheckBox = [];
  List<GamesModel> listAllGames = [];
  List listGamesChoosen = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllGames(),
        builder: (context, snapshot) {
          if (listGamesCheckBox.isEmpty) {
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
                  'Th??m k??? n??ng',
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.normal),
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
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Column(
                          children: List.generate(
                            listGamesCheckBox.length,
                            (index) =>
                                buildSingleCheckBox(listGamesCheckBox[index]),
                          ),
                        ),
                      ])),
            bottomNavigationBar: BottomAppBar(
              elevation: 0,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: AcceptProfileButton(
                      text: 'C???p nh???t',
                      onPress: () {
                        if (listGamesChoosen.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Vui l??ng ch???n k??? n??ng!"),
                          ));
                        } else if ((listGameOfUser.length +
                                listGamesChoosen.length) <=
                            5) {
                          for (var gameChoose in listGamesChoosen) {
                            for (var game in listAllGames) {
                              if (game.name.contains(gameChoose)) {
                                CreateGameOfUserModel createGameOfUser =
                                    CreateGameOfUserModel(
                                        gameId: game.id, rankId: "");
                                listCreateGameOfUser.add(createGameOfUser);
                              }
                            }
                          }
                          Future<bool?> createGameOfUserModel =
                              GameOfUserService().createGameOfUser(
                                  listCreateGameOfUser,
                                  widget.tokenModel.message);
                          createGameOfUserModel.then((_listCreateGameOfUser) {
                            if (_listCreateGameOfUser == true) {
                              setState(() {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Th??m th??nh c??ng"),
                                ));
                                Navigator.pop(context);
                              });
                            }
                          });
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Ch??? ???????c th??m t???i ??a 5 k??? n??ng"),
                          ));
                        }
                      })),
            ),
          );
        });
  }

  Widget buildSingleCheckBox(CheckBoxState cbState) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: const Color(0xff8980FF),
      value: cbState.value,
      onChanged: (value) => setState(
        () {
          if (cbState.value) {
            listGamesChoosen.remove(cbState.title);
            cbState.value = value!;
          } else {
            listGamesChoosen.add(cbState.title);
            cbState.value = value!;
          }
        },
      ),
      title: Text(
        cbState.title,
        style: GoogleFonts.montserrat(fontSize: 15),
      ),
    );
  }

  Future getAllGames() {
    Future<ResponseListModel<GamesModel>?> gameFuture =
        GameService().getAllGames(widget.tokenModel.message);
    gameFuture.then((listGameValue) {
      if (listGameValue != null) {
        if (checkFirstTime == true) {
          setState(() {
            listAllGames = listGameValue.content;
            Future<ResponseListModel<GameOfUserModel>?> hobbiesFuture =
                UserService().getGameOfUser(
                    widget.userModel.id, widget.tokenModel.message);
            hobbiesFuture.then((listGameOfUserValue) {
              if (listGameOfUserValue != null) {
                listGameOfUser = listGameOfUserValue.content;
                for (var remove in listGameOfUser) {
                  listAllGames
                      .removeWhere((item) => item.name == remove.game.name);
                }
                for (var games in listAllGames) {
                  listGamesCheckBox
                      .add(CheckBoxState(title: games.name, value: false));
                }
              }
            });
          });
          checkFirstTime = false;
        }
      }
    });
    return gameFuture;
  }
}
