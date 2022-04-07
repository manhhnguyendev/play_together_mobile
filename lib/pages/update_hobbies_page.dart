import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/game_model.dart';
import 'package:play_together_mobile/models/hobbies_model.dart';
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
  List<HobbiesModel> listHobbies = [];
  List<GamesModel> listAllGames = [];
  List<CheckBoxState> listGamesCheckBox = [];
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
            Future<List<HobbiesModel>?> hobbiesFuture = HobbiesService()
                .getHobbiesOfUser(
                    widget.userModel.id, widget.tokenModel.message);
            hobbiesFuture.then((listHobbiesValue) {
              if (listHobbiesValue != null) {
                for (var games in listAllGames) {
                  listGamesCheckBox
                      .add(CheckBoxState(title: games.name, value: false));
                }
                listHobbies = listHobbiesValue;
                for (var item in listGamesCheckBox) {
                  for (var hobby in listHobbies) {
                    if (item.title == hobby.game.name) {
                      item.value = true;
                    }
                  }
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

  @override
  Widget build(BuildContext context) {
    if (checkAddChoosen) {
      for (var hobby in listHobbies) {
        listGamesChoosen.add(hobby.game.name);
      }
      checkAddChoosen = false;
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
                        checkUpdate = false;
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Cập nhật thành công"),
                        ));
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
          } else {
            listGamesChoosen.add(cbState.title);
            cbState.value = value!;
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
