import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/rating_comment_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/services/rating_service.dart';
import 'package:play_together_mobile/widgets/rating_comment_card.dart';

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
  List<RatingModel>? listAllRating;
  double vote = 0;
  bool checkExist = false;

  Future loadListRating() {
    listAllRating ??= [];
    Future<List<RatingModel>?> listAllRatingModelFuture = RatingService()
        .getAllRating(widget.playerModel!.id, vote, widget.tokenModel.message);
    listAllRatingModelFuture.then((_ratingList) {
      listAllRating = _ratingList;
    });
    return listAllRatingModelFuture;
  }

  @override
  Widget build(BuildContext context) {
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
          title: const Text(
            'Chi tiết đánh giá',
            style: TextStyle(
                fontSize: 18,
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
              child: GridView.count(
                crossAxisSpacing: 3,
                childAspectRatio: (120 / 70),
                shrinkWrap: true,
                crossAxisCount: 5,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xff8980FF),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          if (!check5star) {
                            check5star = true;
                            check4star = false;
                            check3star = false;
                            check2star = false;
                            check1star = false;
                            vote = 5;
                          } else {
                            check5star = false;
                            check4star = false;
                            check3star = false;
                            check2star = false;
                            check1star = false;
                            vote = 0;
                          }
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 8,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 8,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 8,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 8,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 8,
                              ),
                            ],
                          ),
                        ],
                      ),
                      color: check5star
                          ? const Color(0xff8980FF).withOpacity(1)
                          : const Color(0xff8980FF).withOpacity(0.1),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xff8980FF),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          if (!check4star) {
                            check4star = true;
                            check5star = false;
                            check3star = false;
                            check2star = false;
                            check1star = false;
                            vote = 4;
                          } else {
                            check5star = false;
                            check4star = false;
                            check3star = false;
                            check2star = false;
                            check1star = false;
                            vote = 0;
                          }
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 8,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 8,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 8,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 8,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      color: check4star
                          ? const Color(0xff8980FF).withOpacity(1)
                          : const Color(0xff8980FF).withOpacity(0.1),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xff8980FF),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          if (!check3star) {
                            check3star = true;
                            check4star = false;
                            check5star = false;
                            check2star = false;
                            check1star = false;
                            vote = 3;
                          } else {
                            check5star = false;
                            check4star = false;
                            check3star = false;
                            check2star = false;
                            check1star = false;
                            vote = 0;
                          }
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 8,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 8,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 8,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      color: check3star
                          ? const Color(0xff8980FF).withOpacity(1)
                          : const Color(0xff8980FF).withOpacity(0.1),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xff8980FF),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          if (!check2star) {
                            check2star = true;
                            check4star = false;
                            check3star = false;
                            check5star = false;
                            check1star = false;
                            vote = 2;
                          } else {
                            vote = 0;
                            check5star = false;
                            check4star = false;
                            check3star = false;
                            check2star = false;
                            check1star = false;
                          }
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 8,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 8,
                              ),
                            ],
                          ),
                        ],
                      ),
                      color: check2star
                          ? const Color(0xff8980FF).withOpacity(1)
                          : const Color(0xff8980FF).withOpacity(0.1),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xff8980FF),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          if (!check1star) {
                            check1star = true;
                            check4star = false;
                            check3star = false;
                            check2star = false;
                            check5star = false;
                            vote = 1;
                          } else {
                            vote = 0;
                            check5star = false;
                            check4star = false;
                            check3star = false;
                            check2star = false;
                            check1star = false;
                          }
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 8,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      color: check1star
                          ? const Color(0xff8980FF).withOpacity(1)
                          : const Color(0xff8980FF).withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 0.5,
              indent: 15,
              endIndent: 15,
            ),
            FutureBuilder(
                future: loadListRating(),
                builder: (context, snapshot) {
                  if (listAllRating!.isEmpty) {
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
                              listAllRating == null ? 0 : listAllRating!.length,
                              (index) =>
                                  buildRatingList(listAllRating![index])),
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
      );
}
