import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:play_together_mobile/models/rating_comment_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/services/rating_service.dart';
import 'package:play_together_mobile/widgets/rating_comment_card.dart';
import 'package:google_fonts/google_fonts.dart';

class RatingCommentPage extends StatefulWidget {
  final UserModel? userModel;
  final TokenModel tokenModel;
  final PlayerModel? playerModel;

  const RatingCommentPage(
      {Key? key, this.userModel, required this.tokenModel, this.playerModel})
      : super(key: key);

  @override
  State<RatingCommentPage> createState() => _RatingCommentPageState();
}

class _RatingCommentPageState extends State<RatingCommentPage> {
  bool check5star = false;
  bool check4star = false;
  bool check3star = false;
  bool check2star = false;
  bool check1star = false;
  bool checkAll = true;
  List<RatingModel> listAllRating = [];
  double vote = 0;
  bool checkExist = false;

  Future loadListRating() {
    Future<ResponseListModel<RatingModel>?> listAllRatingModelFuture =
        RatingService().getAllRating(
            widget.playerModel!.id, vote, widget.tokenModel.message);
    listAllRatingModelFuture.then((_ratingList) {
      listAllRating = _ratingList!.content;
    });
    return listAllRatingModelFuture;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: FlatButton(
              child: const Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          centerTitle: true,
          title: Text(
            'Chi tiết đánh giá',
            style: GoogleFonts.montserrat(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 20, 2, 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff8980FF),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: SizedBox(
                          width: width * 0.3,
                          height: height * 0.05,
                          child: FlatButton(
                            onPressed: () {
                              setState(() {
                                if (!checkAll) {
                                  check5star = false;
                                  check4star = false;
                                  check3star = false;
                                  check2star = false;
                                  check1star = false;
                                  checkAll = true;
                                  vote = 0;
                                }
                              });
                            },
                            child: Text(
                              'Tất cả',
                              style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                            color: checkAll
                                ? const Color(0xff8980FF).withOpacity(1)
                                : const Color(0xff8980FF).withOpacity(0.1),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff8980FF),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: SizedBox(
                          width: width * 0.31,
                          height: height * 0.05,
                          child: FlatButton(
                            onPressed: () {
                              setState(() {
                                if (!check5star) {
                                  check5star = true;
                                  check4star = false;
                                  check3star = false;
                                  check2star = false;
                                  check1star = false;
                                  checkAll = false;
                                  vote = 5;
                                } else {
                                  check5star = false;
                                  check4star = false;
                                  check3star = false;
                                  check2star = false;
                                  check1star = false;
                                  checkAll = true;
                                  vote = 0;
                                }
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
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
                              ],
                            ),
                            color: check5star
                                ? const Color(0xff8980FF).withOpacity(1)
                                : const Color(0xff8980FF).withOpacity(0.1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        //4 sao
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff8980FF),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: SizedBox(
                          width: width * 0.26,
                          height: height * 0.05,
                          child: FlatButton(
                            onPressed: () {
                              setState(() {
                                if (!check4star) {
                                  check4star = true;
                                  check5star = false;
                                  check3star = false;
                                  check2star = false;
                                  check1star = false;
                                  checkAll = false;
                                  vote = 4;
                                } else {
                                  check5star = false;
                                  check4star = false;
                                  check3star = false;
                                  check2star = false;
                                  check1star = false;
                                  checkAll = true;
                                  vote = 0;
                                }
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
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
                              ],
                            ),
                            color: check4star
                                ? const Color(0xff8980FF).withOpacity(1)
                                : const Color(0xff8980FF).withOpacity(0.1),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        //3 sao
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff8980FF),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: SizedBox(
                          width: width * 0.22,
                          height: height * 0.05,
                          child: FlatButton(
                            onPressed: () {
                              setState(() {
                                if (!check3star) {
                                  check3star = true;
                                  check4star = false;
                                  check5star = false;
                                  check2star = false;
                                  check1star = false;
                                  checkAll = false;
                                  vote = 3;
                                } else {
                                  check5star = false;
                                  check4star = false;
                                  check3star = false;
                                  check2star = false;
                                  check1star = false;
                                  checkAll = true;
                                  vote = 0;
                                }
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
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
                              ],
                            ),
                            color: check3star
                                ? const Color(0xff8980FF).withOpacity(1)
                                : const Color(0xff8980FF).withOpacity(0.1),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        // 2 sao
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff8980FF),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: SizedBox(
                          width: width * 0.19,
                          height: height * 0.05,
                          child: FlatButton(
                            onPressed: () {
                              setState(() {
                                if (!check2star) {
                                  check2star = true;
                                  check4star = false;
                                  check3star = false;
                                  check5star = false;
                                  check1star = false;
                                  checkAll = false;
                                  vote = 2;
                                } else {
                                  vote = 0;
                                  check5star = false;
                                  check4star = false;
                                  check3star = false;
                                  check2star = false;
                                  check1star = false;
                                  checkAll = true;
                                }
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
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
                              ],
                            ),
                            color: check2star
                                ? const Color(0xff8980FF).withOpacity(1)
                                : const Color(0xff8980FF).withOpacity(0.1),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        // 1 sao
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff8980FF),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: SizedBox(
                          width: width * 0.15,
                          height: height * 0.05,
                          child: FlatButton(
                            onPressed: () {
                              setState(() {
                                if (!check1star) {
                                  check1star = true;
                                  check4star = false;
                                  check3star = false;
                                  check2star = false;
                                  check5star = false;
                                  checkAll = false;
                                  vote = 1;
                                } else {
                                  vote = 0;
                                  check5star = false;
                                  check4star = false;
                                  check3star = false;
                                  check2star = false;
                                  check1star = false;
                                  checkAll = true;
                                }
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  FontAwesomeIcons.solidStar,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                              ],
                            ),
                            color: check1star
                                ? const Color(0xff8980FF).withOpacity(1)
                                : const Color(0xff8980FF).withOpacity(0.1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 0.5,
              indent: 18,
              endIndent: 18,
            ),
            FutureBuilder(
                future: loadListRating(),
                builder: (context, snapshot) {
                  if (listAllRating.isEmpty) {
                    checkExist = true;
                  } else {
                    checkExist = false;
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Column(
                          children: List.generate(
                              listAllRating == null ? 0 : listAllRating.length,
                              (index) => buildRatingList(listAllRating[index])),
                        ),
                        Visibility(
                            visible: checkExist,
                            child: const Text('Không có dữ liệu'))
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  Widget buildRatingList(RatingModel _ratingModel) => RatingCard(
        ratingModel: _ratingModel,
        tokenModel: widget.tokenModel,
        playerModel: widget.playerModel,
      );
}
