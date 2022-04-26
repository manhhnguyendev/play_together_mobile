import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/player_profile_page.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_together_mobile/services/user_service.dart';

class PlayerCard extends StatefulWidget {
  final double width, aspectRatio;
  final UserModel userModel;
  final TokenModel tokenModel;
  final GetAllUserModel playerModel;

  const PlayerCard({
    Key? key,
    this.width = 140,
    this.aspectRatio = 1,
    required this.userModel,
    required this.tokenModel,
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
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 15),
        child: SizedBox(
          width: widget.width / 365 * size.width,
          child: GestureDetector(
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
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    padding: EdgeInsets.all(1 / 1000 * size.width),
                    child: ClipRRect(
                      child: Image.network(widget.playerModel.avatar),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      widget.playerModel.name,
                      style: GoogleFonts.montserrat(fontSize: 15),
                    ),
                    const Spacer(),
                    createStatus(widget.playerModel.status),
                  ],
                ),
                const SizedBox(height: 5),
                Row(children: [
                  Text(
                    widget.playerModel.pricePerHour.toStringAsFixed(0).toVND() +
                        "/h ・ ",
                    style: GoogleFonts.montserrat(fontSize: 13),
                  ),
                  const Icon(
                    FontAwesomeIcons.solidStar,
                    color: Colors.amber,
                    size: 12,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    (widget.playerModel.rate.toStringAsFixed(1)),
                    style: GoogleFonts.montserrat(fontSize: 12),
                  ),
                ]),
              ],
            ),
          ),
        ));
  }

  Widget createStatus(String status) {
    if (widget.playerModel.status == 'Hiring') {
      return Text(
        '●',
        style: GoogleFonts.montserrat(
            fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),
      );
    }

    if (widget.playerModel.status == 'Processing') {
      return Text(
        '●',
        style: GoogleFonts.montserrat(
            fontSize: 15, color: Colors.amber, fontWeight: FontWeight.bold),
      );
    }

    if (widget.playerModel.status == 'Offline') {
      return Text(
        '●',
        style: GoogleFonts.montserrat(
            fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold),
      );
    }

    if (widget.playerModel.status == 'Online') {
      return Text(
        '●',
        style: GoogleFonts.montserrat(
            fontSize: 15, color: Colors.green, fontWeight: FontWeight.bold),
      );
    }

    return Text(
      widget.playerModel.status,
      style: GoogleFonts.montserrat(
          fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
    );
  }
}
