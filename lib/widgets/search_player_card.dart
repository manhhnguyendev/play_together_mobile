import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:play_together_mobile/models/game_of_user_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/player_profile_page.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPlayerCard extends StatefulWidget {
  final GetAllUserModel playerModel;
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
  List<GameOfUserModel> listGameAndRank = [];

  Future getGameOfUser() {
    Future<ResponseListModel<GameOfUserModel>?> gameOfUserFuture = UserService()
        .getGameOfUser(widget.playerModel.id, widget.tokenModel.message);
    gameOfUserFuture.then((value) {
      if (value != null) {
        listGameAndRank = value.content;
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
              Future<ResponseModel<PlayerModel>?> getPlayerByIdFuture =
                  UserService().getPlayerById(
                      widget.playerModel.id, widget.tokenModel.message);
              getPlayerByIdFuture.then((playerDetail) {
                if (playerDetail != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlayerProfilePage(
                              userModel: widget.userModel,
                              playerModel: playerDetail.content,
                              tokenModel: widget.tokenModel,
                            )),
                  );
                }
              });
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
                              style: GoogleFonts.montserrat(
                                  fontSize: 20, color: Colors.black),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: buildGamesString(listGameAndRank),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 0,
                                  child: Text(
                                    widget.playerModel.pricePerHour
                                            .toStringAsFixed(0)
                                            .toVND() +
                                        '/h',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        color: const Color(0xff320444)),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      const Icon(
                                        FontAwesomeIcons.solidStar,
                                        color: Colors.amber,
                                        size: 15,
                                      ),
                                      Text(
                                        ' ' +
                                            (widget.playerModel.rate)
                                                .toStringAsFixed(1),
                                        style: GoogleFonts.montserrat(
                                            fontSize: 15),
                                      ),
                                      Text(
                                        "(" +
                                            widget.playerModel.numOfRate
                                                .toString() +
                                            ")",
                                        style: GoogleFonts.montserrat(
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

  Widget buildGamesString(List<GameOfUserModel> gamesOfUserModel) {
    String games = "";
    if (gamesOfUserModel == null) {
      return Text('', style: GoogleFonts.montserrat(fontSize: 15));
    } else {
      for (var i = 0; i < gamesOfUserModel.length; i++) {
        if (i < gamesOfUserModel.length - 1) {
          games = games + gamesOfUserModel[i].game.name + ", ";
        } else {
          games = games + gamesOfUserModel[i].game.name;
        }
      }
      return Text(games, style: GoogleFonts.montserrat(fontSize: 15));
    }
  }

  Widget createStatus(String status) {
    if (status == 'Hiring') {
      return Text(
        'Đang được thuê',
        style: GoogleFonts.montserrat(fontSize: 18, color: Colors.red),
      );
    }

    if (status == 'Processing') {
      return Text(
        'Đang thương lượng',
        style: GoogleFonts.montserrat(fontSize: 18, color: Colors.amber),
      );
    }

    if (status == 'Offline') {
      return Text(
        'Đang offline',
        style: GoogleFonts.montserrat(fontSize: 18, color: Colors.grey),
      );
    }

    if (status == 'Online') {
      return Text(
        'Đang online',
        style: GoogleFonts.montserrat(fontSize: 18, color: Colors.green),
      );
    }

    return Text(
      status,
      style: GoogleFonts.montserrat(fontSize: 18, color: Colors.black),
    );
  }
}
