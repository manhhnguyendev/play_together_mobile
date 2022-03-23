import 'package:flutter/material.dart';
import 'package:play_together_mobile/constants/my_color.dart' as my_colors;
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/player_profile_page.dart';
import 'package:play_together_mobile/services/user_service.dart';

class PlayerCard extends StatefulWidget {
  final double width, aspectRatio;
  final UserModel userModel;
  final TokenModel tokenModel;
  final UserModel playerModel;
  const PlayerCard({
    Key? key,
    this.width = 140,
    this.aspectRatio = 1.02,
    required this.userModel,
    required this.tokenModel,
    required this.playerModel,
  }) : super(key: key);

  @override
  _PlayerCardState createState() => _PlayerCardState();
}

UserModel? playerModel;

class _PlayerCardState extends State<PlayerCard> {
  Future getPlayerById(String id) {
    Future<UserModel?> playerModelFuture =
        UserService().getUserById(id, widget.tokenModel.message);
    playerModelFuture.then((player) {
      if (player != null) {
        setState(() {
          playerModel = player;
        });
      }
    });
    return playerModelFuture;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.only(left: 20 / 375 * size.width),
        child: SizedBox(
            width: widget.width / 375 * size.width,
            child: GestureDetector(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 1.02,
                    child: Container(
                      padding: EdgeInsets.all(1 / 1000 * size.width),
                      decoration: BoxDecoration(
                        color: my_colors.secondary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        child: Image.network(widget.playerModel.avatar,
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        widget.playerModel.name,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}
