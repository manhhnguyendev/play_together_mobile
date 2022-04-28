import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/charity_model.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/charity_detail_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_together_mobile/services/charity_service.dart';

class CharityCard extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;
  final CharityModel charityModel;

  const CharityCard(
      {Key? key,
      required this.charityModel,
      required this.userModel,
      required this.tokenModel})
      : super(key: key);

  @override
  State<CharityCard> createState() => _CharityCardState();
}

class _CharityCardState extends State<CharityCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Future<ResponseModel<CharityModel>?> charityFuture = CharityService()
            .getCharityById(widget.charityModel.id, widget.tokenModel.message);
        charityFuture.then((value) {
          if (value != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CharityDetailPage(
                        charityModel: widget.charityModel,
                        userModel: widget.userModel,
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
                  image: NetworkImage(widget.charityModel.avatar),
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
                        widget.charityModel.organizationName,
                        style: GoogleFonts.montserrat(
                            fontSize: 17, color: Colors.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.charityModel.address,
                        style: GoogleFonts.montserrat(
                            fontSize: 15, color: Colors.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.charityModel.phone,
                        style: GoogleFonts.montserrat(
                            fontSize: 15, color: Colors.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
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
  }
}
