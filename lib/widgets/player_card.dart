import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/player_model.dart';
import 'package:play_together_mobile/constants/my_color.dart' as my_colors;
import 'package:play_together_mobile/pages/player_profile_page.dart';

class PlayerCard extends StatefulWidget {
  final double width, aspectRetio;
  final PlayerModel playerModel;
  const PlayerCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.playerModel,
  }) : super(key: key);

  @override
  _PlayerCardState createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
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
                      builder: (context) =>
                          PlayerProfilePage(playerModel: widget.playerModel)),
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
                        widget.playerModel.firstname +
                            ' ' +
                            widget.playerModel.lastname,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}
