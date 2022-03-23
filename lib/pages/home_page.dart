import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/search_page.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:play_together_mobile/widgets/app_bar_home.dart';
import 'package:play_together_mobile/widgets/bottom_bar.dart';
import 'package:play_together_mobile/widgets/player_card.dart';

class HomePage extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;

  const HomePage({
    Key? key,
    required this.userModel,
    required this.tokenModel,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserModel>? playerList;

  Future loadList() {
    playerList ??= [];
    Future<List<UserModel>?> listUserModelFuture =
        UserService().getAllUsers(widget.tokenModel.message);
    listUserModelFuture.then((_playerList) {
      if (mounted) {
        setState(() {
          playerList = _playerList;
        });
      }
    });
    return listUserModelFuture;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: Appbar(
          height: 70,
          titles: "Home",
          onPressedSearch: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(),
                ));
          }),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, left: 10),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 20 / 375 * size.width),
                child: Row(children: [
                  Text(
                    "Thuê lại lần nữa",
                    style: TextStyle(
                      fontSize: 18 / 400 * size.width,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    child: const Icon(Icons.arrow_circle_down_outlined),
                  ),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                          height: 200.0,
                          child: FutureBuilder(
                              future: loadList(),
                              builder: (context, snapshot) {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: playerList == null
                                      ? 0
                                      : playerList!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return PlayerCard(
                                      playerModel: playerList![index],
                                      tokenModel: widget.tokenModel,
                                      userModel: widget.userModel,
                                    );
                                  },
                                );
                              })),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 20 / 375 * size.width),
                child: Row(children: [
                  Text(
                    "Có thể bạn sẽ thích",
                    style: TextStyle(
                      fontSize: 18 / 400 * size.width,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    child: const Icon(Icons.arrow_circle_down_outlined),
                  ),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                          height: 200.0,
                          child: FutureBuilder(
                              future: loadList(),
                              builder: (context, snapshot) {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: playerList == null
                                      ? 0
                                      : playerList!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return PlayerCard(
                                      playerModel: playerList![index],
                                      tokenModel: widget.tokenModel,
                                      userModel: widget.userModel,
                                    );
                                  },
                                );
                              })),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 20 / 375 * size.width),
                child: Row(children: [
                  Text(
                    "Đề xuất cho bạn",
                    style: TextStyle(
                      fontSize: 18 / 400 * size.width,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    child: const Icon(Icons.arrow_circle_down_outlined),
                  ),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                          height: 200.0,
                          child: FutureBuilder(
                              future: loadList(),
                              builder: (context, snapshot) {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: playerList == null
                                      ? 0
                                      : playerList!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return PlayerCard(
                                      playerModel: playerList![index],
                                      tokenModel: widget.tokenModel,
                                      userModel: widget.userModel,
                                    );
                                  },
                                );
                              })),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 20 / 375 * size.width),
                child: Row(children: [
                  Text(
                    "Top ưa thích",
                    style: TextStyle(
                      fontSize: 18 / 400 * size.width,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    child: const Icon(Icons.arrow_circle_down_outlined),
                  ),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                          height: 200.0,
                          child: FutureBuilder(
                              future: loadList(),
                              builder: (context, snapshot) {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: playerList == null
                                      ? 0
                                      : playerList!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return PlayerCard(
                                      playerModel: playerList![index],
                                      tokenModel: widget.tokenModel,
                                      userModel: widget.userModel,
                                    );
                                  },
                                );
                              })),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ]),
      ),
      bottomNavigationBar: BottomBar(
        userModel: widget.userModel,
        tokenModel: widget.tokenModel,
        bottomBarIndex: 0,
      ),
    );
  }
}
