import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/game_model.dart';
import 'package:play_together_mobile/models/hobbies_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/services/game_service.dart';
import 'package:play_together_mobile/services/hobbies_service.dart';
import 'package:play_together_mobile/widgets/checkbox_state.dart';
import 'package:play_together_mobile/widgets/profile_accept_button.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateHobbiesPage extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;

  const UpdateHobbiesPage(
      {Key? key, required this.userModel, required this.tokenModel})
      : super(key: key);

  @override
  State<UpdateHobbiesPage> createState() => _UpdateHobbiesPageState();
}

class _UpdateHobbiesPageState extends State<UpdateHobbiesPage> {
  List<HobbiesModel> listHobbies = [];
  List<GamesModel> listAllGames = [];
  List<CheckBoxState> listGamesCheckBox = [];
  List<CreateHobbiesModel> listCreateHobbies = [];
  List<DeleteHobbiesModel> listDeleteHobbies = [];
  List listGamesChoosen = [];
  bool checkFirstTime = true;
  bool checkAddChoosen = true;
  bool isPress = false;
  bool isLoading = false;

  Future getAllGames() {
    Future<ResponseListModel<GamesModel>?> gameFuture =
        GameService().getAllGames(widget.tokenModel.message);
    gameFuture.then((listGameValue) {
      if (listGameValue != null) {
        if (isPress || checkFirstTime) {
          setState(() {
            listAllGames = listGameValue.content;
            Future<ResponseListModel<HobbiesModel>?> hobbiesFuture =
                HobbiesService().getHobbiesOfUser(
                    widget.userModel.id, widget.tokenModel.message);
            hobbiesFuture.then((listHobbiesValue) {
              if (listHobbiesValue != null) {
                setState(() {
                  listHobbies = listHobbiesValue.content;
                  for (var games in listAllGames) {
                    listGamesCheckBox
                        .add(CheckBoxState(title: games.name, value: false));
                  }
                  if (checkAddChoosen) {
                    for (var hobby in listHobbies) {
                      listGamesChoosen.add(hobby.game.name);
                    }
                    checkAddChoosen = false;
                  }
                  for (var item in listGamesCheckBox) {
                    for (var hobby in listHobbies) {
                      if (item.title == hobby.game.name) {
                        item.value = true;
                      }
                    }
                  }
                });
              }
            });
          });
          checkFirstTime = false;
        }
      }
    });
    return gameFuture;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllGames(),
        builder: (context, snapshot) {
          if (listHobbies.isEmpty) {
            isLoading = true;
          } else {
            isLoading = false;
          }
          return Scaffold(
            backgroundColor: Colors.white,
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
                  'C??i ?????t s??? th??ch',
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                          child: Text(
                            'B???n th??ch t???a games n??o?',
                            style: GoogleFonts.montserrat(fontSize: 18),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
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
                            content: Text("Vui l??ng ch???n ??t nh???t 1 s??? th??ch"),
                          ));
                        } else {
                          setState(() {
                            isPress = true;
                            listCreateHobbies.clear();
                            listDeleteHobbies.clear();
                          });
                          for (var gameChoose in listGamesChoosen) {
                            for (var game in listAllGames) {
                              if (game.name.contains(gameChoose)) {
                                CreateHobbiesModel createHobbies =
                                    CreateHobbiesModel(gameId: game.id);
                                listCreateHobbies.add(createHobbies);
                              }
                            }
                          }
                          for (var hobby in listHobbies) {
                            DeleteHobbiesModel deleteHobbies =
                                DeleteHobbiesModel(hobbyId: hobby.id);
                            listDeleteHobbies.add(deleteHobbies);
                          }
                          Future<bool?> deleteHobbiesFuture = HobbiesService()
                              .deleteHobbies(
                                  listDeleteHobbies, widget.tokenModel.message);
                          deleteHobbiesFuture.then((_listDeleteHobbies) {
                            if (_listDeleteHobbies == true) {
                              Future<bool?> createHobbiesFuture =
                                  HobbiesService().createHobbies(
                                      listCreateHobbies,
                                      widget.tokenModel.message);
                              createHobbiesFuture.then((_listCreateHobbies) {
                                if (_listCreateHobbies == true) {
                                  setState(() {
                                    isPress = false;
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("C???p nh???t th??nh c??ng"),
                                    ));
                                  });
                                }
                              });
                            }
                          });
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
}
