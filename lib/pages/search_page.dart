import 'package:flutter/material.dart';
import 'package:play_together_mobile/constants/my_color.dart' as my_colors;
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/services/search_service.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:play_together_mobile/widgets/search_player_card.dart';

class SearchPage extends StatefulWidget {
  final TokenModel tokenModel;
  final UserModel userModel;
  final List<PlayerModel>? listSearch;
  final String? searchValue;
  const SearchPage(
      {Key? key,
      required this.tokenModel,
      required this.userModel,
      this.listSearch,
      this.searchValue})
      : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<UserModel>? listPlayerSearch;
  List<PlayerModel>? _listPlayerSearch = [];

  final _controller = TextEditingController();

  Future loadPlayerList() {
    _listPlayerSearch ??= [];
    Future<List<UserModel>?> listOrderFromCreateUserModelFuture =
        SearchService().searchUser(
            widget.searchValue.toString(), widget.tokenModel.message);
    listOrderFromCreateUserModelFuture.then((_userList) {
      setState(() {
        listPlayerSearch = _userList;
        if (_listPlayerSearch!.isEmpty) {
          for (var item in listPlayerSearch!) {
            Future<PlayerModel?> playerFuture =
                UserService().getPlayerById(item.id, widget.tokenModel.message);
            playerFuture.then((value) {
              if (value != null) {
                _listPlayerSearch!.add(value);
              }
            });
          }
        }
      });
    });
    return listOrderFromCreateUserModelFuture;
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.searchValue.toString();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: FlatButton(
          child: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: Container(
          width: size.width,
          decoration: BoxDecoration(
            color: my_colors.secondary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: _controller,
            onChanged: (value) {
              if (_controller.text.length == 0) {
                Navigator.pop(context);
              }
            },
            // onSubmitted: (value) {
            //   // setState(() {
            //   //   if (_controller.text.isNotEmpty) {
            //   //     _listPlayerSearch = [];
            //   //     Future<List<UserModel>?> listPlayerSearchModelFuture =
            //   //         SearchService().searchUser(
            //   //             _controller.text, widget.tokenModel.message);
            //   //     listPlayerSearchModelFuture.then((_playerList) {
            //   //       listPlayerSearch = _playerList;
            //   //       if (_listPlayerSearch!.isEmpty) {
            //   //         for (var item in listPlayerSearch!) {
            //   //           Future<PlayerModel?> playerFuture = UserService()
            //   //               .getPlayerById(item.id, widget.tokenModel.message);
            //   //           playerFuture.then((value) {
            //   //             if (value != null) {
            //   //               _listPlayerSearch!.add(value);
            //   //             }
            //   //           });
            //   //         }
            //   //       }
            //   //     });
            //   //     // showListSearchArea = true;
            //   //     // showHistoryAndRecommendArea = false;
            //   //   }
            //   // });
            // },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 40 / 375 * size.width,
                  vertical: 9 / 512 * size.height),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: "Tìm kiếm",
              prefixIcon: const Icon(
                Icons.search,
                color: my_colors.secondary,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  _controller.clear();
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.clear,
                  color: Color(0xff8980FF),
                ),
              ),
            ),
          ),
        ),
        // actions: <Widget>[
        //   IconButton(
        //     iconSize: 30,
        //     icon: const Icon(Icons.filter_alt_rounded),
        //     color: Colors.black,
        //     onPressed: () {},
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
          child: FutureBuilder(
              future: loadPlayerList(),
              builder: (context, snapshot) {
                return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Column(
                        children: List.generate(
                            widget.listSearch!.length,
                            (index) =>
                                buildListSearch(widget.listSearch![index]))
                        // List.generate(_listPlayerSearch!.length,
                        //     (index) => buildListSearch(_listPlayerSearch![index]))

                        ));
              })),
    );
  }

  Widget buildListSearch(PlayerModel playerModel) => SearchPlayerCard(
        playerModel: playerModel,
        tokenModel: widget.tokenModel,
        userModel: widget.userModel,
      );
}
