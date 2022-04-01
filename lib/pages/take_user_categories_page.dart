import 'package:flutter/material.dart';
import 'package:play_together_mobile/widgets/checkbox_state.dart';
import 'package:play_together_mobile/widgets/main_button.dart';
import 'package:play_together_mobile/widgets/main_go_back_button.dart';

class UserCategoriesPage extends StatefulWidget {
  const UserCategoriesPage({Key? key}) : super(key: key);

  @override
  _UserCategoriesPageState createState() => _UserCategoriesPageState();
}

class _UserCategoriesPageState extends State<UserCategoriesPage> {
  final _formKey = GlobalKey<FormState>();
  List listGames = [
    'Liên Minh Huyền Thoại',
    'CS:GO',
    'PUBG',
    'Among us',
    'FIFA ONLINE 4',
    'Chess'
  ];
  List listGamesCheckBox = [];
  List listGamesChoosen = [];
  bool firstTimeInit = false;
  void createAListCheckBox() {
    if (!firstTimeInit) {
      for (var i = 0; i < listGames.length; i++) {
        listGamesCheckBox.add(CheckBoxState(title: listGames[i]));
      }
      firstTimeInit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    createAListCheckBox();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        'Bạn thích tựa game nào (Chọn ít nhất 1 tựa game):',
                        style: TextStyle(fontSize: 17),
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

                      //GoBackButton(text: "QUAY LẠI", onpress: () {})
                    ],
                  )),
            ),
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
              text: "TIẾP TỤC",
              onpress: () {
                if (listGamesChoosen.length == 0) {
                  print("ko đc");
                } else {
                  print("YES");
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSingleCheckBox(CheckBoxState cbState) => CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Colors.black,
        value: cbState.value,
        onChanged: (value) => setState(
          () {
            if (cbState.value) {
              listGamesChoosen.remove(cbState.title);
              cbState.value = value!;
              print((listGamesChoosen));
            } else {
              listGamesChoosen.add(cbState.title);
              cbState.value = value!;
              print((listGamesChoosen));
            }
          },
        ),
        title: Text(
          cbState.title,
          style: TextStyle(fontSize: 18),
        ),
      );
}
