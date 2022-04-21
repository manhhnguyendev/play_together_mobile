import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/filter_page.dart';
import 'package:play_together_mobile/services/search_service.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:play_together_mobile/widgets/search_player_card.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  final TokenModel tokenModel;
  final UserModel userModel;
  final String searchValue;

  const SearchPage({
    Key? key,
    required this.tokenModel,
    required this.userModel,
    required this.searchValue,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<PlayerModel> _listPlayerSearch = [];
  final _controller = TextEditingController();
  List<UserModel>? listPlayerSearch;
  List<PlayerModel> listPlayerFilter = [];
  bool checkFirstTime = true;
  bool checkFilter = true;
  bool checkListSearch = true;
  bool checkListFilter = false;
  bool isMale = true;
  bool isFemale = true;
  bool newIsMale = false;
  bool newIsFemale = false;
  bool sortByRating = false;
  bool sortByAlphabet = false;
  bool sortByPrice = false;
  bool sortByHobby = false;
  bool newSortByRating = false;
  bool newSortByAlphabet = false;
  bool newSortByPrice = false;
  bool newSortByHobby = false;
  int sortOrder = 0;
  int newSortOrder = 0;
  int statusOrder = 0;
  int newStatusOrder = 0;
  String status = "";
  String newStatus = "";
  double startPrice = 10000;
  double newStartPrice = 10000;
  double endPrice = 5000000;
  double newEndPrice = 5000000;
  String defaultGameId = "";
  String newDefaultGameId = "";

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.searchValue.toString();
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: loadListSearchPlayer(),
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
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 40 / 375 * size.width,
                        vertical: 9 / 512 * size.height),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: "Tìm kiếm",
                    hintStyle: GoogleFonts.montserrat(),
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
                  color: const Color(0xff8980FF),
                  onPressed: (() async {
                    checkFilter = true;
                    final Map<String, Object> list = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FilterPage(
                            tokenModel: widget.tokenModel,
                            userModel: widget.userModel,
                            searchValue: _controller.text,
                            sortByHobby:
                                checkListSearch ? sortByHobby : newSortByHobby,
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
                            statusOrder:
                                checkListSearch ? statusOrder : newStatusOrder,
                            sortByAlphabet: checkListSearch
                                ? sortByAlphabet
                                : newSortByAlphabet,
                            startPrice:
                                checkListSearch ? startPrice : newStartPrice,
                            status: checkListSearch ? status : newStatus,
                          ),
                        ));
                    newSortByAlphabet = list["sortByAlphabet"] as bool;
                    newSortByHobby = list["sortByHobby"] as bool;
                    newSortByPrice = list["sortByPrice"] as bool;
                    newSortByRating = list["sortByRating"] as bool;
                    newIsMale = list["isMale"] as bool;
                    newIsFemale = list["isFemale"] as bool;
                    newDefaultGameId = list["defaultGameId"] as String;
                    newStatus = list["status"] as String;
                    newStartPrice = list["startPrice"] as double;
                    newEndPrice = list["endPrice"] as double;
                    newSortOrder = list["sortOrder"] as int;
                    newStatusOrder = list["statusOrder"] as int;
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
                                  newSortByHobby,
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

  Future loadListSearchPlayer() {
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
}
