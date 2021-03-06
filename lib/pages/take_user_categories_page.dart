import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/game_model.dart';
import 'package:play_together_mobile/models/hobbies_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/home_page.dart';
import 'package:play_together_mobile/services/game_service.dart';
import 'package:play_together_mobile/services/hobbies_service.dart';
import 'package:play_together_mobile/widgets/checkbox_state.dart';
import 'package:play_together_mobile/widgets/main_button.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;
import 'package:google_fonts/google_fonts.dart';

class UserCategoriesPage extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;

  const UserCategoriesPage(
      {Key? key, required this.userModel, required this.tokenModel})
      : super(key: key);

  @override
  _UserCategoriesPageState createState() => _UserCategoriesPageState();
}

class _UserCategoriesPageState extends State<UserCategoriesPage> {
  List<GamesModel> listGames = [];
  List<CreateHobbiesModel> listCreateHobbies = [];
  List<CheckBoxState> listGamesCheckBox = [];
  List listGamesChoosen = [];
  bool checkFirstTime = true;
  bool isLoading = false;

  Future getAllGames() {
    Future<ResponseListModel<GamesModel>?> gameFuture =
        GameService().getAllGames(widget.tokenModel.message);
    gameFuture.then((value) {
      if (value != null) {
        if (checkFirstTime) {
          setState(() {
            listGames = value.content;
            for (var games in listGames) {
              listGamesCheckBox
                  .add(CheckBoxState(title: games.name, value: false));
            }
          });
          checkFirstTime = false;
        }
      }
    });
    return gameFuture;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: getAllGames(),
        builder: (context, snapshot) {
          if (listGames.isEmpty) {
            isLoading = true;
          } else {
            isLoading = false;
          }
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
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
                      children: <Widget>[
                        Container(
                          width: size.width,
                          height: size.height * 0.45,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/play_together_logo_text.png"),
                                  fit: BoxFit.cover)),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Text(
                                  'B???n th??ch t???a game n??o (Ch???n ??t nh???t 1 t???a game):',
                                  style: GoogleFonts.montserrat(fontSize: 17),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Column(
                                    children: List.generate(
                                        listGamesCheckBox.length,
                                        (index) => buildSingleCheckBox(
                                            listGamesCheckBox[index])),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
            bottomNavigationBar: BottomAppBar(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: MainButton(
                    text: "HO??N T???T",
                    onPress: () {
                      if (listGamesChoosen.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Vui l??ng ch???n ??t nh???t 1 t???a game"),
                        ));
                      } else {
                        for (var gameChoose in listGamesChoosen) {
                          for (var game in listGames) {
                            if (game.name.contains(gameChoose)) {
                              CreateHobbiesModel createHobbies =
                                  CreateHobbiesModel(gameId: game.id);
                              listCreateHobbies.add(createHobbies);
                            }
                          }
                        }
                        Future<bool?> createHobbiesFuture = HobbiesService()
                            .createHobbies(
                                listCreateHobbies, widget.tokenModel.message);
                        createHobbiesFuture.then((_listCreateHobbies) {
                          if (_listCreateHobbies == true) {
                            setState(() {
                              helper.pushInto(
                                  context,
                                  HomePage(
                                    userModel: widget.userModel,
                                    tokenModel: widget.tokenModel,
                                  ),
                                  true);
                            });
                          }
                        });
                      }
                    },
                  ),
                ),
              ),
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
