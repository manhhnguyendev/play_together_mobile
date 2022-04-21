import 'package:flutter/material.dart';
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
  bool checkListFilter = false;
  bool checkListSearch = true;
  bool sortByRating = false;
  bool sortByAlphabet = false;
  bool sortByPrice = false;
  bool sortByRecommend = false;
  bool checkFilter = true;
  int sortOrder = 0;
  String status = "";
  int statusOrder = 0;
  bool isMale = true;
  bool isFemale = true;
  double startPrice = 10000;
  double endPrice = 5000000;
  String defaultGameId = "";

  bool newSortByRating = false;
  bool newSortByAlphabet = false;
  bool newSortByPrice = false;
  bool newSortByRecommend = false;
  int newSortOrder = 0;
  String newStatus = "";
  int newStatusOrder = 0;
  bool newIsMale = false;
  bool newIsFemale = false;
  double newStartPrice = 10000;
  double newEndPrice = 5000000;
  String newDefaultGameId = "";

  Future loadPlayerList() {
    Future<ResponseListModel<UserModel>?> getListSearchUser = SearchService()
        .searchUser(widget.searchValue.toString(), widget.tokenModel.message);
    getListSearchUser.then((_userList) {
      if (checkFirstTime) {
        checkListSearch = true;
        setState(() {
          listPlayerSearch = _userList!.content;
          if (_listPlayerSearch.isEmpty) {
            for (var item in listPlayerSearch!) {
              Future<ResponseModel<PlayerModel>?> playerFuture = UserService()
                  .getPlayerById(item.id, widget.tokenModel.message);
              playerFuture.then((value) {
                if (value != null) {
                  _listPlayerSearch.add(value.content);
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
                  color: Colors.grey.withOpacity(0.1),
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
                      color: Colors.grey,
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
                    checkFilter = true;
                    final Map<String, Object> list = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FilterPage(
                            tokenModel: widget.tokenModel,
                            userModel: widget.userModel,
                            searchValue: _controller.text,
                            sortByRecommend: checkListSearch
                                ? sortByRecommend
                                : newSortByRecommend,
                            defaultGameId: checkListSearch
                                ? defaultGameId
                                : newDefaultGameId,
                            endPrice: checkListSearch ? endPrice : newEndPrice,
                            isMale: checkListSearch ? isMale : newIsMale,
                            isFemale: checkListSearch ? isFemale : newIsFemale,
                            sortByPrice:
                                checkListSearch ? sortByPrice : newSortByPrice,
                            sortByRating: checkListSearch
                                ? sortByRating
                                : newSortByRating,
                            sortOrder:
                                checkListSearch ? sortOrder : newSortOrder,
                            sortByAlphabet: checkListSearch
                                ? sortByAlphabet
                                : newSortByAlphabet,
                            startPrice:
                                checkListSearch ? startPrice : newStartPrice,
                            status: checkListSearch ? status : newStatus,
                          ),
                        ));
                    //listPlayerFilter = list;
                    newSortByAlphabet = list["sortByAlphabet"] as bool;
                    newSortByRecommend = list["sortByRecommend"] as bool;
                    newSortByPrice = list["sortByPrice"] as bool;
                    newSortByRating = list["sortByRating"] as bool;
                    newIsMale = list["isMale"] as bool;
                    newIsFemale = list["isFemale"] as bool;
                    newDefaultGameId = list["defaultGameId"] as String;
                    newStatus = list["status"] as String;
                    newStartPrice = list["sPrice"] as double;
                    newEndPrice = list["ePrice"] as double;
                    newSortOrder = list["sortOrd"] as int;
                    newStatusOrder = list["sttOrder"] as int;
                    //_controller.text = list["searchValue"] as String;
                    // print(newSortByAlphabet.toString() + " abc");
                    // print(newSortByRecommend.toString() + " recommend");
                    // print(newSortByPrice.toString() + " price");
                    // print(newSortByRating.toString() + " rating");
                    // print(newIsMale.toString() + " male");
                    // print(newIsFemale.toString() + " female");
                    // print(newDefaultGameId.toString() + " game id");
                    // print(newStatus + " status");
                    // print(newStartPrice.toString() + " start price");
                    // print(newEndPrice.toString() + " end price");
                    // print(newSortOrder.toString() + " sort ord");
                    // print(newStatusOrder.toString() + " status order");
                    setState(() {
                      checkListFilter = true;
                      checkListSearch = false;
                      Future<ResponseListModel<PlayerModel>?>
                          getPlayerByFilter = SearchService()
                              .searchUserByFilter(
                                  _controller.text,
                                  newIsMale,
                                  newIsFemale,
                                  newDefaultGameId,
                                  newStatus,
                                  newSortByAlphabet,
                                  newSortByRating,
                                  newSortByRecommend,
                                  newSortByPrice,
                                  newStartPrice,
                                  newEndPrice,
                                  widget.tokenModel.message);
                      getPlayerByFilter.then((value) {
                        if (value != null) {
                          if (checkFilter) {
                            setState(() {
                              listPlayerFilter = value.content;
                            });
                            checkFilter = false;
                          }
                        }
                      });
                    });
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
