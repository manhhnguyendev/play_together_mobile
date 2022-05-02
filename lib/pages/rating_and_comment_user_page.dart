import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:play_together_mobile/models/rating_comment_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/services/rating_service.dart';
import 'package:play_together_mobile/widgets/rating_comment_card.dart';
import 'package:google_fonts/google_fonts.dart';

class RatingCommentUserPage extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;
  final bool checkCanReport;

  const RatingCommentUserPage({
    Key? key,
    required this.userModel,
    required this.tokenModel,
    required this.checkCanReport,
  }) : super(key: key);

  @override
  State<RatingCommentUserPage> createState() => _RatingCommentUserPageState();
}

class _RatingCommentUserPageState extends State<RatingCommentUserPage> {
  final ScrollController _scrollController = ScrollController();
  bool check5star = false;
  bool check4star = false;
  bool check3star = false;
  bool check2star = false;
  bool check1star = false;
  bool checkAll = true;
  List<RatingModel> listAllRating = [];
  double vote = 0;
  bool checkExist = false;
  int pageSize = 10;
  bool checkHasNext = false;
  bool checkGetData = false;
  bool checkFirstTime = true;

  Future loadListRating() {
    Future<ResponseListModel<RatingModel>?> listAllRatingModelFuture =
        RatingService().getAllRating(
            widget.userModel.id, vote, widget.tokenModel.message, pageSize);
    listAllRatingModelFuture.then((_ratingList) {
      if (_ratingList != null) {
        if (checkFirstTime ||
            checkGetData ||
            check1star ||
            check2star ||
            check3star ||
            check4star ||
            check5star ||
            checkAll) {
          listAllRating = _ratingList.content;
          if (_ratingList.hasNext == false) {
            checkHasNext = true;
          } else {
            checkHasNext = false;
          }
          checkFirstTime = false;
        }
      }
    });
    return listAllRatingModelFuture;
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        getMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void getMoreData() {
    setState(() {
      if (checkHasNext == false) {
        pageSize += 10;
        checkGetData = true;
      }
    });
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
            child: TextButton(
              style: TextButton.styleFrom(primary: Colors.black),
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
        controller: _scrollController,
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
                          color: checkAll
                              ? const Color(0xff8980FF).withOpacity(1)
                              : const Color(0xff8980FF).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: SizedBox(
                          width: width * 0.3,
                          height: height * 0.05,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                if (!checkAll) {
                                  pageSize = 10;
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
                            style: TextButton.styleFrom(primary: Colors.black),
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
                          color: check5star
                              ? const Color(0xff8980FF).withOpacity(1)
                              : const Color(0xff8980FF).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: SizedBox(
                          width: width * 0.31,
                          height: height * 0.05,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                if (!check5star) {
                                  pageSize = 10;
                                  check5star = true;
                                  check4star = false;
                                  check3star = false;
                                  check2star = false;
                                  check1star = false;
                                  checkAll = false;
                                  vote = 5;
                                } else {
                                  pageSize = 10;
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
                            style: TextButton.styleFrom(primary: Colors.black),
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
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff8980FF),
                          ),
                          color: check4star
                              ? const Color(0xff8980FF).withOpacity(1)
                              : const Color(0xff8980FF).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: SizedBox(
                          width: width * 0.26,
                          height: height * 0.05,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                if (!check4star) {
                                  pageSize = 10;
                                  check4star = true;
                                  check5star = false;
                                  check3star = false;
                                  check2star = false;
                                  check1star = false;
                                  checkAll = false;
                                  vote = 4;
                                } else {
                                  pageSize = 10;
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
                            style: TextButton.styleFrom(primary: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff8980FF),
                          ),
                          color: check3star
                              ? const Color(0xff8980FF).withOpacity(1)
                              : const Color(0xff8980FF).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: SizedBox(
                          width: width * 0.22,
                          height: height * 0.05,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                if (!check3star) {
                                  pageSize = 10;
                                  check3star = true;
                                  check4star = false;
                                  check5star = false;
                                  check2star = false;
                                  check1star = false;
                                  checkAll = false;
                                  vote = 3;
                                } else {
                                  pageSize = 10;
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
                            style: TextButton.styleFrom(primary: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff8980FF),
                          ),
                          color: check2star
                              ? const Color(0xff8980FF).withOpacity(1)
                              : const Color(0xff8980FF).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: SizedBox(
                          width: width * 0.19,
                          height: height * 0.05,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                if (!check2star) {
                                  pageSize = 10;
                                  check2star = true;
                                  check4star = false;
                                  check3star = false;
                                  check5star = false;
                                  check1star = false;
                                  checkAll = false;
                                  vote = 2;
                                } else {
                                  pageSize = 10;
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
                            style: TextButton.styleFrom(primary: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff8980FF),
                          ),
                          color: check1star
                              ? const Color(0xff8980FF).withOpacity(1)
                              : const Color(0xff8980FF).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: SizedBox(
                          width: width * 0.15,
                          height: height * 0.05,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                if (!check1star) {
                                  pageSize = 10;
                                  check1star = true;
                                  check4star = false;
                                  check3star = false;
                                  check2star = false;
                                  check5star = false;
                                  checkAll = false;
                                  vote = 1;
                                } else {
                                  pageSize = 10;
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
                            style: TextButton.styleFrom(primary: Colors.black),
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
                  if (listAllRating.isEmpty && checkHasNext != false) {
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
                              listAllRating.isNotEmpty
                                  ? listAllRating.length
                                  : 0,
                              (index) => buildRatingList(listAllRating[index])),
                        ),
                        Visibility(
                            visible: checkExist,
                            child: Text(
                              'Không có dữ liệu',
                              style: GoogleFonts.montserrat(),
                            )),
                        Visibility(
                          visible: !checkHasNext,
                          child: _buildProgressIndicator(),
                        ),
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: !checkHasNext ? 1.0 : 00,
          child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromRGBO(137, 128, 255, 1))),
        ),
      ),
    );
  }

  Widget buildRatingList(RatingModel _ratingModel) => RatingCard(
        ratingModel: _ratingModel,
        tokenModel: widget.tokenModel,
        checkCanReport: widget.checkCanReport,
      );
}
