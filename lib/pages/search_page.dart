import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/filter_page.dart';
import 'package:play_together_mobile/services/search_service.dart';
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
  final ScrollController _scrollControllerSearch = ScrollController();
  final _controller = TextEditingController();
  List<GetAllUserModel> listPlayerSearch = [];
  List<GetAllUserModel> listPlayerFilter = [];
  bool checkFirstTime = true;
  bool checkSearchFirstTime = true;
  bool checkFilter = true;
  bool checkOnSubmit = true;
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
  int pageSizeSearch = 10;
  bool checkHasNextSearch = false;
  bool checkGetDataSearch = false;
  int pageSizeFilter = 10;
  bool checkHasNextFilter = false;
  bool checkGetDataFilter = false;
  bool checkEmptySearch = false;
  bool checkEmptyFilter = false;

  @override
  void initState() {
    super.initState();
    _scrollControllerSearch.addListener(() {
      if (_scrollControllerSearch.position.maxScrollExtent ==
          _scrollControllerSearch.position.pixels) {
        getMoreDataSearch();
      }
    });
  }

  @override
  void dispose() {
    _scrollControllerSearch.dispose();
    super.dispose();
  }

  void getMoreDataSearch() {
    setState(() {
      if (checkHasNextSearch == false) {
        pageSizeSearch += 10;
        checkGetDataSearch = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (checkSearchFirstTime) {
      _controller.text = widget.searchValue.toString();
      checkSearchFirstTime = false;
    }
    _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length));
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: loadListSearchPlayer(),
        builder: (context, snapshot) {
          if (listPlayerSearch.isEmpty && checkHasNextSearch != false) {
            checkEmptySearch = true;
          } else {
            checkEmptySearch = false;
          }
          if (listPlayerFilter.isEmpty) {
            checkEmptyFilter = true;
          } else {
            checkEmptyFilter = false;
          }
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 1,
              backgroundColor: Colors.white,
              leading: TextButton(
                style: TextButton.styleFrom(primary: Colors.black),
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
                  style: GoogleFonts.montserrat(),
                  controller: _controller,
                  onSubmitted: (value) {
                    _controller.text = value;
                    Future<ResponseListModel<GetAllUserModel>?>
                        getListSearchUser = SearchService().searchUser(
                            value, widget.tokenModel.message, pageSizeSearch);
                    getListSearchUser.then((_userList) {
                      setState(() {
                        listPlayerSearch = _userList!.content;
                        if (_userList.hasNext == false) {
                          checkHasNextSearch = true;
                        }
                      });
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 9 / 512 * size.height),
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
                      Future<ResponseListModel<GetAllUserModel>?>
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
              controller: _scrollControllerSearch,
              child: Column(
                children: [
                  Visibility(
                    visible: checkListSearch,
                    child: SingleChildScrollView(
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Column(children: [
                              Column(
                                  children: List.generate(
                                      listPlayerSearch.length,
                                      (index) => buildListSearch(
                                          listPlayerSearch[index]))),
                              Visibility(
                                  visible: checkEmptySearch,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text('Không có dữ liệu',
                                        style: GoogleFonts.montserrat()),
                                  )),
                              Visibility(
                                visible: !checkHasNextSearch,
                                child: _buildProgressIndicatorSearch(),
                              ),
                            ]))),
                  ),
                  Visibility(
                    visible: checkListFilter,
                    child: SingleChildScrollView(
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Column(
                              children: [
                                Column(
                                    children: List.generate(
                                        listPlayerFilter.length,
                                        (index) => buildListSearch(
                                            listPlayerFilter[index]))),
                                Visibility(
                                    visible: checkEmptyFilter,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text('Không có dữ liệu',
                                          style: GoogleFonts.montserrat()),
                                    )),
                              ],
                            ))),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _buildProgressIndicatorSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: !checkHasNextSearch ? 1.0 : 00,
          child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromRGBO(137, 128, 255, 1))),
        ),
      ),
    );
  }

  Widget buildListSearch(GetAllUserModel _playerModel) => SearchPlayerCard(
        playerModel: _playerModel,
        tokenModel: widget.tokenModel,
        userModel: widget.userModel,
      );

  Future loadListSearchPlayer() {
    Future<ResponseListModel<GetAllUserModel>?> getListSearchUser =
        SearchService().searchUser(widget.searchValue.toString(),
            widget.tokenModel.message, pageSizeSearch);
    getListSearchUser.then((_userList) {
      if (_userList != null) {
        if (checkFirstTime || checkGetDataSearch) {
          checkListSearch = true;
          if (!mounted) return;
          setState(() {
            listPlayerSearch = _userList.content;
            if (_userList.hasNext == false) {
              checkHasNextSearch = true;
            } else {
              checkHasNextSearch = false;
            }
          });
          checkFirstTime = false;
        }
      }
    });
    return getListSearchUser;
  }
}
