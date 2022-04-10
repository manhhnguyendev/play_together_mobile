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
  late bool checkDelete;
  late bool checkAdd;
  List<HobbiesModel> listHobbies = [];
  List<GamesModel> listAllGames = [];
  List<CheckBoxState> listGamesCheckBox = [];
  List<CreateHobbiesModel> listCreateHobbies = [];
  List<DeleteHobbiesModel> listDeleteHobbies = [];
  List listGamesChoosen = [];
  bool checkUpdate = false;
  bool checkFirstTime = true;
  bool checkAddChoosen = true;

  Future getAllGames() {
    Future<List<GamesModel>?> gameFuture =
        GameService().getAllGames(widget.tokenModel.message);
    gameFuture.then((listGameValue) {
      if (listGameValue != null) {
        if (checkFirstTime) {
          setState(() {
            listAllGames = listGameValue;
            Future<ResponseListModel<HobbiesModel>?> hobbiesFuture =
                HobbiesService().getHobbiesOfUser(
                    widget.userModel.id, widget.tokenModel.message);
            hobbiesFuture.then((listHobbiesValue) {
              if (listHobbiesValue != null) {
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
                // for (var hobby in listHobbies) {
                //   print(hobby.id + " id id");
                //   listDeleteHobbies.add(hobby.id);
                // }
                // print(listDeleteHobbies);
                // for (var hobby in listHobbies) {
                //   listGamesCheckBox
                //       .add(CheckBoxState(title: hobby.game.name, value: true));
                // }
                // for (var cbState in listGamesCheckBox) {
                //   for (var games in listAllGames) {
                //     if (games.name != cbState.title) {
                //       listGamesCheckBox
                //           .add(CheckBoxState(title: games.name, value: false));
                //     }
                //   }
                // }

                //add list hobbies rồi mình add những game ko có trong list hobbies.

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
                      if (!checkUpdate) {
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Ấn cập nhật sở thích"),
                        ));
                      }
                    },
                  ),
                ),
                centerTitle: true,
                title: const Text(
                  'Cài đặt sở thích',
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
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                    child: Text(
                      'Bạn thích tựa games nào?',
                      style: TextStyle(fontSize: 18),
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
                      onpress: () {
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

                        //print(checkDelete.toString() + " check delete");
                        // Future<bool?> createHobbiesFuture = HobbiesService()
                        //     .createHobbies(
                        //         listCreateHobbies, widget.tokenModel.message);
                        // createHobbiesFuture.then((value) => {
                        //       checkAdd = value!,
                        //     });
                        //print(checkAdd.toString() + " check add");
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
          checkUpdate = true;
          if (cbState.value) {
            listGamesChoosen.remove(cbState.title);
            cbState.value = value!;
            print(listGamesChoosen);
          } else {
            listGamesChoosen.add(cbState.title);
            cbState.value = value!;
            print(listGamesChoosen);
          }
        },
      ),
      title: Text(
        cbState.title,
        style: const TextStyle(fontSize: 15),
      ),
    );
  }
}
