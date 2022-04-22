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
                    print(listGamesChoosen);
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
                      Icons.arrow_back_ios,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                centerTitle: true,
                title: Text(
                  'Cài đặt sở thích',
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
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
                    padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                    child: Text(
                      'Bạn thích tựa games nào?',
                      style: GoogleFonts.montserrat(fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: List.generate(
                      listGamesCheckBox.length,
                      (index) => buildSingleCheckBox(listGamesCheckBox[index]),
                    ),
                  ),
                ])),
            bottomNavigationBar: BottomAppBar(
              elevation: 0,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: AcceptProfileButton(
                      text: 'Cập nhật',
                      onPress: () {
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
                            Future<bool?> createHobbiesFuture = HobbiesService()
                                .createHobbies(listCreateHobbies,
                                    widget.tokenModel.message);
                            createHobbiesFuture.then((_listCreateHobbies) {
                              if (_listCreateHobbies == true) {
                                setState(() {
                                  isPress = false;
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Cập nhật thành công"),
                                  ));
                                  print('Cập nhật thành công');
                                });
                              }
                            });
                          }
                        });
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
