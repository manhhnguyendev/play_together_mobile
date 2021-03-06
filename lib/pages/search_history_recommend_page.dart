import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/game_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/search_history_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/search_page.dart';
import 'package:play_together_mobile/services/game_service.dart';
import 'package:play_together_mobile/services/search_history_service.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchHistoryAndRecommendPage extends StatefulWidget {
  final TokenModel tokenModel;
  final UserModel userModel;

  const SearchHistoryAndRecommendPage(
      {Key? key, required this.tokenModel, required this.userModel})
      : super(key: key);

  @override
  State<SearchHistoryAndRecommendPage> createState() =>
      _SearchHistoryAndRecommendPageState();
}

class _SearchHistoryAndRecommendPageState
    extends State<SearchHistoryAndRecommendPage> {
  final _controller = TextEditingController();

  List<SearchHistoryModel> listSearchHistory = [];
  List<SearchHistoryModel> listHotSearch = [];
  List<GamesModel> listMostFavoriteGame = [];
  String searchValue = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _controller.text = "";
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: TextButton(
            style: TextButton.styleFrom(primary: Colors.black),
            child: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
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
              searchValue = _controller.text;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchPage(
                      tokenModel: widget.tokenModel,
                      userModel: widget.userModel,
                      searchValue: searchValue,
                    ),
                  ));
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintStyle: GoogleFonts.montserrat(),
              hintText: "T??m ki???m",
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  _controller.clear();
                },
                icon: const Icon(
                  Icons.clear,
                  color: Color(0xff8980FF),
                ),
              ),
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: SizedBox(
                height: 40.0,
                width: 40.0,
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromRGBO(137, 128, 255, 1))),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'T??m ki???m g???n ????y',
                      style: GoogleFonts.montserrat(
                          color: Colors.grey, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: FutureBuilder(
                      future: loadListSearchHistory(),
                      builder: (context, snapshot) {
                        return Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: List.generate(
                                listSearchHistory.length,
                                (index) => buildSearchHistory(
                                    listSearchHistory[index].searchString)),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Top t??m ki???m',
                      style: GoogleFonts.montserrat(
                          color: Colors.grey, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: FutureBuilder(
                      future: loadListHotSearch(),
                      builder: (context, snapshot) {
                        return Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: List.generate(
                                listHotSearch.length,
                                (index) => buildSearchHistory(
                                    listHotSearch[index].searchString)),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'C??c t???a game hot',
                      style: GoogleFonts.montserrat(
                          color: Colors.grey, fontSize: 18),
                    ),
                  ),
                  FutureBuilder(
                    future: loadListMostFavoriteGame(),
                    builder: (context, snapshot) {
                      return GridView.count(
                        shrinkWrap: true,
                        childAspectRatio: (130 / 50),
                        crossAxisCount: 2,
                        children: List.generate(
                            listMostFavoriteGame.length,
                            (index) => buildTopGameTag(
                                listMostFavoriteGame[index].name)),
                      );
                    },
                  ),
                ],
              ),
            )),
    );
  }

  Widget buildSearchHistory(String searchHistory) {
    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchPage(
                  tokenModel: widget.tokenModel,
                  userModel: widget.userModel,
                  searchValue: searchHistory,
                ),
              ));
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Container(
          alignment: Alignment.topLeft,
          child: Column(
            children: [
              Text(
                searchHistory,
                style: GoogleFonts.montserrat(
                    fontSize: 15, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTopGameTag(String gameType) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(
                    tokenModel: widget.tokenModel,
                    userModel: widget.userModel,
                    searchValue: gameType,
                  ),
                ));
          });
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xff8980FF),
            ),
            color: const Color(0xff8980FF).withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            gameType,
            style: GoogleFonts.montserrat(
                fontSize: 15, fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }

  Future loadListSearchHistory() {
    Future<ResponseListModel<SearchHistoryModel>?> listSearchHistoryFuture =
        SearchHistoryService().getSearchHistories(widget.tokenModel.message);
    listSearchHistoryFuture.then((_listSearchHistory) {
      if (_listSearchHistory != null) {
        listSearchHistory = _listSearchHistory.content;
      }
    });
    return listSearchHistoryFuture;
  }

  Future loadListHotSearch() {
    Future<ResponseListModel<SearchHistoryModel>?> listHotSearchFuture =
        SearchHistoryService().getHotSearch(widget.tokenModel.message);
    listHotSearchFuture.then((_listHotSearch) {
      if (_listHotSearch != null) {
        listHotSearch = _listHotSearch.content;
      }
    });
    return listHotSearchFuture;
  }

  Future loadListMostFavoriteGame() {
    Future<ResponseListModel<GamesModel>?> listMostFavoriteGameFuture =
        GameService().getMostFavoriteGames(widget.tokenModel.message);
    listMostFavoriteGameFuture.then((_listMostFavoriteGame) {
      if (_listMostFavoriteGame != null) {
        listMostFavoriteGame = _listMostFavoriteGame.content;
      }
    });
    return listMostFavoriteGameFuture;
  }
}
