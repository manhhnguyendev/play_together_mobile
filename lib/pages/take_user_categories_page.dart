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
  List listCategories = ['Ca hát', 'Chơi game', 'Trò chuyện'];
  List listCategoriesCheckBox = [];
  List listCategoriesChoosen = [];
  bool firstTimeInit = false;
  void createAListCheckBox() {
    if (!firstTimeInit) {
      for (var i = 0; i < listCategories.length; i++) {
        listCategoriesCheckBox.add(CheckBoxState(title: listCategories[i]));
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
                        'Bạn thích hoạt động nào (Chọn 2 trên 3):',
                        style: TextStyle(fontSize: 17),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Column(
                          children: List.generate(
                              listCategoriesCheckBox.length,
                              (index) => buildSingleCheckBox(
                                  listCategoriesCheckBox[index])),
                        ),
                      ),
                      MainButton(
                        text: "TIẾP TỤC",
                        onpress: () {
                          if (_formKey.currentState == null) {
                            print("_formKey.currentState is null!");
                          } else if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                          }
                        },
                      ),
                      GoBackButton(text: "QUAY LẠI", onpress: () {})
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSingleCheckBox(CheckBoxState cbState) => CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Colors.black,
        value: cbState.value,
        onChanged: (value) => setState(
          () => cbState.value = value!,
        ),
        title: Text(
          cbState.title,
          style: TextStyle(fontSize: 18),
        ),
      );
}
