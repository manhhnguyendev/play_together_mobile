import 'package:flutter/material.dart';
import 'package:play_together_mobile/constants/my_color.dart' as my_colors;
import 'package:play_together_mobile/models/game_model.dart';
import 'package:play_together_mobile/models/search_history_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/search_page.dart';
import 'package:play_together_mobile/services/game_service.dart';
import 'package:play_together_mobile/services/search_history_service.dart';
import 'package:play_together_mobile/services/search_service.dart';
import 'package:play_together_mobile/services/user_service.dart';

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
  List<UserModel>? listPlayerSearch;
  List<PlayerModel>? _listPlayerSearch = [];
  String searchValue = "";
  List<SearchHistoryModel> listSearchHistory = [];
  List<SearchHistoryModel> listHotSearch = [];
  List<GamesModel> listMostFavoriteGame = [];

  Future loadListSearchHistory() {
    Future<List<SearchHistoryModel>?> listSearchHistoryFuture =
        SearchHistoryService().getSearchHistories(widget.tokenModel.message);
    listSearchHistoryFuture.then((_listSearchHistory) {
      if (_listSearchHistory != null) {
        listSearchHistory = _listSearchHistory;
      }
    });
    return listSearchHistoryFuture;
  }

  Future loadListHotSearch() {
    Future<List<SearchHistoryModel>?> listHotSearchFuture =
        SearchHistoryService().getHotSearch(widget.tokenModel.message);
    listHotSearchFuture.then((_listHotSearch) {
      if (_listHotSearch != null) {
        listHotSearch = _listHotSearch;
      }
    });
    return listHotSearchFuture;
  }

  Future loadListMostFavoriteGame() {
    Future<List<GamesModel>?> listMostFavoriteGameFuture =
        GameService().getMostFavoriteGames(widget.tokenModel.message);
    listMostFavoriteGameFuture.then((_listMostFavoriteGame) {
      if (_listMostFavoriteGame != null) {
        listMostFavoriteGame = _listMostFavoriteGame;
        print(listMostFavoriteGame);
      }
    });
    return listMostFavoriteGameFuture;
  }

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
          child: FlatButton(
            child: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Container(
          width: size.width,
          decoration: BoxDecoration(
            color: my_colors.secondary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: _controller,
            onSubmitted: (value) {
              if (_controller.text.isNotEmpty) {
                searchValue = _controller.text;
                _listPlayerSearch = [];
                Future<List<UserModel>?> listPlayerSearchModelFuture =
                    SearchService().searchUserByName(
                        _controller.text, widget.tokenModel.message);
                listPlayerSearchModelFuture.then((_playerSearchList) {
                  listPlayerSearch = _playerSearchList;
                  if (_listPlayerSearch!.isEmpty) {
                    for (var item in listPlayerSearch!) {
                      Future<PlayerModel?> playerFuture = UserService()
                          .getPlayerById(item.id, widget.tokenModel.message);
                      playerFuture.then((value) {
                        if (value != null) {
                          _listPlayerSearch!.add(value);
                        }
                      });
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchPage(
                            tokenModel: widget.tokenModel,
                            userModel: widget.userModel,
                            listSearch: _listPlayerSearch,
                            searchValue: searchValue,
                          ),
                        ));
                  }
                });
              }
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
            icon: const Icon(Icons.filter_alt_rounded),
            color: Colors.black,
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: const Text(
                'Tìm kiếm gần đây',
                style: TextStyle(color: Colors.grey, fontSize: 17),
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
              child: const Text(
                'Top tìm kiếm',
                style: TextStyle(color: Colors.grey, fontSize: 17),
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
              child: const Text(
                'Các tựa game hot',
                style: TextStyle(color: Colors.grey, fontSize: 17),
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
                      (index) =>
                          buildTopGameTag(listMostFavoriteGame[index].name)),
                );
              },
            ),
          ],
        ),
      )),
    );
  }

  Widget buildSearchHistory(String searchHistory) => GestureDetector(
        onTap: () {
          print(searchHistory);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Text(
                  searchHistory,
                  style: const TextStyle(
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
                color: const Color(0xff8980FF),
              ),
              color: const Color(0xff8980FF).withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              gameType,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ),
      );
}
