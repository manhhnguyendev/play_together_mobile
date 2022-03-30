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
  const SearchPage(
      {Key? key, required this.tokenModel, required this.userModel})
      : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<UserModel>? playerList;
  List<PlayerModel>? _list = [];
  bool showHistoryAndRecommendArea = true;
  bool showListSearchArea = false;
  late String search = '';
  final _controller = TextEditingController();
  List<String> listSearchHistory = ['Đàm', 'Hằng', 'Quoc Hung'];
  List<String> listTopGameType = [
    'MOBA',
    'FPS',
    'Sinh Tồn',
    'Thể thao',
    'Chiến thuật',
    'Battle',
    'Kinh dị'
  ];
  List<String> listTopGame = [
    'LOL',
    'CSGO',
    'Liên quân',
    'FIFA',
    'PUBG',
    'XXX'
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
        title: Container(
          width: size.width,
          decoration: BoxDecoration(
            color: my_colors.secondary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: _controller,
            onChanged: (value) {
              search = value;
              setState(() {
                Future<List<UserModel>?> playerModelFuture = SearchService()
                    .searchUser(search, widget.tokenModel.message);
                playerModelFuture.then((_playerList) {
                  setState(() {
                    playerList = _playerList;
                    if (_list!.length == 0) {
                      for (var item in playerList!) {
                        Future<PlayerModel?> playerFuture = UserService()
                            .getPlayerById(item.id, widget.tokenModel.message);
                        playerFuture.then((value) {
                          if (value != null) {
                            _list!.add(value);
                          }
                        });
                      }
                    }
                  });
                });
                if (search.length == 0) {
                  showHistoryAndRecommendArea = true;
                  showListSearchArea = false;
                }
              });
            },
            onSubmitted: (value) {
              if (search.length != 0 && value.length != 0) {
                setState(() {
                  showListSearchArea = true;
                  showHistoryAndRecommendArea = false;
                });
                print(search + ' summit');
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
              prefixIcon: Icon(
                Icons.search,
                color: my_colors.secondary,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  _controller.clear();
                  setState(() {
                    showHistoryAndRecommendArea = true;
                    showListSearchArea = false;
                  });
                },
                icon: Icon(
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
            icon: Icon(Icons.filter_alt_rounded),
            color: Colors.black,
            onPressed: () {},
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Column(
            children: [
              Visibility(
                  visible: showHistoryAndRecommendArea,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Tìm kiếm gần đây',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: List.generate(
                                listSearchHistory.length,
                                (index) => buildSearchHistory(
                                    listSearchHistory[index])),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Thể loại ưa thích',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                      GridView.count(
                        shrinkWrap: true,
                        childAspectRatio: (120 / 50),
                        crossAxisCount: 3,
                        children: List.generate(listTopGameType.length,
                            (index) => buildTopGameTag(listTopGameType[index])),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Các tựa game nổi tiếng',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                      GridView.count(
                        shrinkWrap: true,
                        childAspectRatio: (120 / 50),
                        crossAxisCount: 3,
                        children: List.generate(listTopGame.length,
                            (index) => buildTopGameTag(listTopGame[index])),
                      ),
                    ],
                  )),
              Visibility(
                  visible: showListSearchArea,
                  child: Column(
                      children: List.generate(_list!.length,
                          (index) => buildListSearch(_list![index]))))
            ],
          ),
        ),
      ),
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

  Widget buildListSearch(PlayerModel playerModel) => SearchPlayerCard(
        playerModel: playerModel,
        tokenModel: widget.tokenModel,
        userModel: widget.userModel,
      );
}
