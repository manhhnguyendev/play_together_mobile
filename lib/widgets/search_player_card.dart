import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/player_profile_page.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:play_together_mobile/services/user_service.dart';

class SearchPlayerCard extends StatefulWidget {
  final PlayerModel playerModel;
  final UserModel userModel;
  final TokenModel tokenModel;

  const SearchPlayerCard(
      {Key? key,
      required this.playerModel,
      required this.tokenModel,
      required this.userModel})
      : super(key: key);

  @override
  _SearchPlayerCardState createState() => _SearchPlayerCardState();
}

class _SearchPlayerCardState extends State<SearchPlayerCard> {
  List<GameOfUserModel>? listGameAndRank;

  Future getGameOfUser() {
    listGameAndRank ??= [];
    Future<List<GameOfUserModel>?> gameOfUserFuture = UserService()
        .getGameOfUser(widget.playerModel.id, widget.tokenModel.message);
    gameOfUserFuture.then((value) {
      if (value != null) {
        listGameAndRank = value;
      }
    });
    return gameOfUserFuture;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getGameOfUser(),
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PlayerProfilePage(
                          userModel: widget.userModel,
                          playerModel: widget.playerModel,
                          tokenModel: widget.tokenModel,
                        )),
              );
            },
            child: Column(
              children: [
                Row(children: [
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        image: NetworkImage(widget.playerModel.avatar),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.playerModel.name,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: buildGamesString(listGameAndRank!),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    widget.playerModel != null
                                        ? widget.playerModel.pricePerHour
                                                .toStringAsFixed(0)
                                                .toVND() +
                                            '/h'
                                        : '0 đ/h',
                                    style: const TextStyle(
                                        fontSize: 20, color: Color(0xff320444)),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      Text(
                                        (widget.playerModel.rate)
                                            .toStringAsFixed(1),
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        "(" +
                                            widget.playerModel.numOfRate
                                                .toString() +
                                            ")",
                                        style: const TextStyle(
                                            fontSize: 15, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            createStatus(widget.playerModel.status),
                          ],
                        ),
                      ))
                ]),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(width: 0.1)),
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget buildGameAndRankPlayer(GameOfUserModel gameOfUser) => Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
          alignment: Alignment.topLeft,
          child: Column(
            children: [
              Row(children: [
                Text(
                  gameOfUser.game.name,
                  style: const TextStyle(fontSize: 15),
                ),
              ]),
              const SizedBox(
                height: 5,
              )
            ],
          ),
        ),
      );

  Widget buildGamesString(List<GameOfUserModel> gamesOfUserModel) {
    String games = "";
    if (gamesOfUserModel == null) {
      return const Text('');
    } else {
      for (var i = 0; i < gamesOfUserModel.length; i++) {
        if (i < gamesOfUserModel.length - 1) {
          games = games + gamesOfUserModel[i].game.name + ", ";
        } else {
          games = games + gamesOfUserModel[i].game.name;
        }
      }
      return Text("Games: " + games);
    }
  }

  Widget createStatus(String status) {
    if (status == 'Hiring') {
      return const Text(
        'Đang được thuê',
        style: TextStyle(fontSize: 15, color: Colors.red),
      );
    }

    if (status == 'Processing') {
      return const Text(
        'Đang thương lượng',
        style: TextStyle(fontSize: 15, color: Colors.yellow),
      );
    }

    if (status == 'Offline') {
      return const Text(
        'Đang offline',
        style: TextStyle(fontSize: 15, color: Colors.grey),
      );
    }

    if (status == 'Online') {
      return const Text(
        'Có thể thuê',
        style: TextStyle(fontSize: 15, color: Colors.green),
      );
    }

    return Text(
      status,
      style: const TextStyle(fontSize: 15, color: Colors.black),
    );
  }
}
