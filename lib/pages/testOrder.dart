import 'package:flutter/material.dart';
import 'package:play_together_mobile/constants/my_color.dart' as my_colors;
import 'package:play_together_mobile/models/search_player_model.dart';
import 'package:play_together_mobile/widgets/search_player_card.dart';

import '../models/token_model.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';
import 'home_page.dart';

class TestOrderPage extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;

  const TestOrderPage(
      {Key? key, required this.userModel, required this.tokenModel})
      : super(key: key);

  @override
  _TestOrderPageState createState() => _TestOrderPageState();
}

class _TestOrderPageState extends State<TestOrderPage> {
  void check() {
    Future<UserModel?> checkStatus =
        UserService().getUserProfile(widget.tokenModel.message);
    checkStatus.then((value) {
      if (value != null) {
        print('check status nè ');
        if (value.status.contains('Online'))
          setState(() {
            value = widget.userModel;
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (BuildContext context) => HomePage(
                    tokenModel: widget.tokenModel, userModel: widget.userModel),
              ),
              (route) => false,
            );
          });
        else
          setState(() {
            value = widget.userModel;
          });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    check();
    return Scaffold(
      backgroundColor: Colors.white,
      //appBar: SearchBar(height: 70, onPressedSearch: () {}),
      appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          bottomOpacity: 0,
          toolbarOpacity: 1,
          toolbarHeight: 65,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: FlatButton(
              child: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: Text("test")),

      body: SingleChildScrollView(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Dang thue",
              style: TextStyle(
                fontSize: 20,
                color: my_colors.primary,
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget buildSearchHistory(String search) => GestureDetector(
        onTap: () {
          print(search);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Text(
                  search,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      );

  Widget buildTopGameTag(String gameType) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            print(gameType);
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xff8980FF),
              ),
              color: Color(0xff8980FF).withOpacity(0.1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Text(
              gameType,
              style: TextStyle(fontSize: 15),
            ),
          ),
        ),
      );

  Widget buildListSearch(SearchPlayerModel model) =>
      SearchPlayerCard(searchPlayerModel: model);
}
