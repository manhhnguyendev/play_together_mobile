import 'package:flutter/material.dart';
import 'package:play_together_mobile/helpers/my_color.dart' as my_colors;
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/filter_page.dart';
import 'package:play_together_mobile/services/search_service.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:play_together_mobile/widgets/search_player_card.dart';

class SearchPage extends StatefulWidget {
  final TokenModel tokenModel;
  final UserModel userModel;
  final String searchValue;

  SearchPage({
    Key? key,
    required this.tokenModel,
    required this.userModel,
    required this.searchValue,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<UserModel>? listPlayerSearch;
  List<PlayerModel> _listPlayerSearch = [];
  List<PlayerModel> listPlayerFilter = [];
  final _controller = TextEditingController();
  bool checkFirstTime = true;
  bool checkListFilter = true;
  bool checkListSearch = true;

  Future loadPlayerList() {
    Future<ResponseListModel<UserModel>?> getListSearchUser = SearchService()
        .searchUser(widget.searchValue.toString(), widget.tokenModel.message);
    getListSearchUser.then((_userList) {
      if (checkFirstTime) {
        setState(() {
          listPlayerSearch = _userList!.content;
          if (_listPlayerSearch.isEmpty) {
            for (var item in listPlayerSearch!) {
              Future<ResponseModel<PlayerModel>?> playerFuture = UserService()
                  .getPlayerById(item.id, widget.tokenModel.message);
              playerFuture.then((value) {
                if (value != null) {
                  _listPlayerSearch.add(value.content);
                  print(_listPlayerSearch.length);
                }
              });
            }
          }
        });
        checkFirstTime = false;
      }
    });
    return getListSearchUser;
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.searchValue.toString();
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
        future: loadPlayerList(),
        builder: (context, snapshot) {
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
                    // if (_controller.text.isEmpty) {
                    //   Navigator.pop(context);
                    // }
                  },
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
              actions: <Widget>[
                IconButton(
                  iconSize: 30,
                  icon: const Icon(Icons.filter_alt_outlined),
                  color: Color(0xff8980FF),
                  onPressed: (() async {
                    checkListFilter = true;
                    checkListSearch = false;
                    final list = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FilterPage(
                            tokenModel: widget.tokenModel,
                            userModel: widget.userModel,
                            searchValue: _controller.text,
                          ),
                        ));
                    listPlayerFilter = list;
                    print(listPlayerFilter.length.toString() + ' filter');
                    setState(() {});
                  }),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Visibility(
                    visible: checkListSearch,
                    child: SingleChildScrollView(
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Column(
                                children: List.generate(
                                    _listPlayerSearch.length,
                                    (index) => buildListSearch(
                                        _listPlayerSearch[index]))))),
                  ),
                  Visibility(
                    visible: checkListFilter,
                    child: SingleChildScrollView(
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Column(
                                children: List.generate(
                                    listPlayerFilter.length,
                                    (index) => buildListSearch(
                                        listPlayerFilter[index]))))),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget buildListSearch(PlayerModel _playerModel) => SearchPlayerCard(
        playerModel: _playerModel,
        tokenModel: widget.tokenModel,
        userModel: widget.userModel,
      );
}
