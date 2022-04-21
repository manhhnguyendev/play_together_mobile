import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:play_together_mobile/models/rating_comment_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_together_mobile/pages/report_comment_page.dart';

class RatingCard extends StatefulWidget {
  final RatingModel? ratingModel;
  final PlayerModel? playerModel;
  final TokenModel tokenModel;
  final bool checkCanReport;

  const RatingCard({
    Key? key,
    this.ratingModel,
    required this.tokenModel,
    this.playerModel,
    required this.checkCanReport,
  }) : super(key: key);

  @override
  State<RatingCard> createState() => _RatingCardState();
}

class _RatingCardState extends State<RatingCard> {
  @override
  Widget build(BuildContext context) {
    String date = DateFormat('dd/MM/yyyy')
        .format(DateTime.parse(widget.ratingModel!.createdDate));
    String startTime = DateFormat('hh:mm a')
        .format(DateTime.parse(widget.ratingModel!.createdDate));
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 60,
                  width: 50,
                  child: FittedBox(
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage(widget.ratingModel!.user!.avatar),
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.ratingModel!.user!.name,
                          style: GoogleFonts.montserrat(
                              fontSize: 15, color: Colors.black),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        buildRatingStar(widget.ratingModel!.rate),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          date + ', ' + startTime,
                          style: GoogleFonts.montserrat(
                              fontSize: 15, color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.ratingModel!.comment,
                          style: GoogleFonts.montserrat(
                              fontSize: 15, color: Colors.black),
                        )
                      ],
                    ),
                  )),
              Visibility(
                visible: widget.checkCanReport,
                child: Expanded(
                    flex: 1,
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReportCommentPage(
                                      ratingModel: widget.ratingModel!,
                                      tokenModel: widget.tokenModel,
                                    )),
                          );
                        },
                        icon: const Icon(
                          Icons.report_gmailerrorred_rounded,
                          color: Colors.black,
                        ))),
              ),
            ],
          ),
          const Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }

  Widget buildRatingStar(int rating) {
    switch (rating) {
      case 1:
        return Row(children: const [
          Icon(
            FontAwesomeIcons.solidStar,
            color: Colors.amber,
            size: 16,
          ),
        ]);

      case 2:
        return Row(children: const [
          Icon(
            FontAwesomeIcons.solidStar,
            color: Colors.amber,
            size: 16,
          ),
          SizedBox(
            width: 2,
          ),
          Icon(
            FontAwesomeIcons.solidStar,
            color: Colors.amber,
            size: 16,
          ),
        ]);

      case 3:
        return Row(children: const [
          Icon(
            FontAwesomeIcons.solidStar,
            color: Colors.amber,
            size: 16,
          ),
          SizedBox(
            width: 2,
          ),
          Icon(
            FontAwesomeIcons.solidStar,
            color: Colors.amber,
            size: 16,
          ),
          SizedBox(
            width: 2,
          ),
          Icon(
            FontAwesomeIcons.solidStar,
            color: Colors.amber,
            size: 16,
          ),
        ]);

      case 4:
        return Row(children: const [
          Icon(
            FontAwesomeIcons.solidStar,
            color: Colors.amber,
            size: 16,
          ),
          SizedBox(
            width: 2,
          ),
          Icon(
            FontAwesomeIcons.solidStar,
            color: Colors.amber,
            size: 16,
          ),
          SizedBox(
            width: 2,
          ),
          Icon(
            FontAwesomeIcons.solidStar,
            color: Colors.amber,
            size: 16,
          ),
          SizedBox(
            width: 2,
          ),
          Icon(
            FontAwesomeIcons.solidStar,
            color: Colors.amber,
            size: 16,
          ),
        ]);

      case 5:
        return Row(children: const [
          Icon(
            FontAwesomeIcons.solidStar,
            color: Colors.amber,
            size: 16,
          ),
          SizedBox(
            width: 2,
          ),
          Icon(
            FontAwesomeIcons.solidStar,
            color: Colors.amber,
            size: 16,
          ),
          SizedBox(
            width: 2,
          ),
          Icon(
            FontAwesomeIcons.solidStar,
            color: Colors.amber,
            size: 16,
          ),
          SizedBox(
            width: 2,
          ),
          Icon(
            FontAwesomeIcons.solidStar,
            color: Colors.amber,
            size: 16,
          ),
          SizedBox(
            width: 2,
          ),
          Icon(
            FontAwesomeIcons.solidStar,
            color: Colors.amber,
            size: 16,
          ),
        ]);

      default:
        return const Text('unknown');
    }
  }
}
