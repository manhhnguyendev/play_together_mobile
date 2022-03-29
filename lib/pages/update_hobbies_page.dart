import 'package:flutter/material.dart';
import 'package:play_together_mobile/widgets/checkbox_state.dart';
import 'package:play_together_mobile/widgets/profile_accept_button.dart';

class UpdateHobbiesPage extends StatefulWidget {
  const UpdateHobbiesPage({Key? key}) : super(key: key);

  @override
  State<UpdateHobbiesPage> createState() => _UpdateHobbiesPageState();
}

class _UpdateHobbiesPageState extends State<UpdateHobbiesPage> {
  bool checkUpdate = false;
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
  List listGamesChoosen = [
    'Liên Minh Huyền Thoại',
    'CS:GO',
  ];

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
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
            child: Text(
              'Bạn thích tựa games nào?',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: List.generate(listGamesCheckBox.length,
                (index) => buildSingleCheckBox(listGamesCheckBox[index])),
          ),
        ],
      )),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: AcceptProfileButton(
                text: 'Cập nhật',
                onpress: () {
                  checkUpdate = false;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Cập nhật thành công"),
                  ));
                })),
      ),
    );
  }

  Widget buildSingleCheckBox(CheckBoxState cbState) {
    for (var choosenGames in listGamesChoosen) {
      if (cbState.title == choosenGames) {
        cbState.value = true;
      }
    }
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Color(0xff8980FF),
      value: cbState.value,
      onChanged: (value) => setState(
        () {
          checkUpdate = true;
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
        style: TextStyle(fontSize: 15),
      ),
    );
  }
}
