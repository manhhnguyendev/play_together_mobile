import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/models/recommend_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/categories_list_page.dart';
import 'package:play_together_mobile/pages/hiring_stage_page.dart';
import 'package:play_together_mobile/pages/receive_request_page.dart';
import 'package:play_together_mobile/pages/search_history_recommend_page.dart';
import 'package:play_together_mobile/services/order_service.dart';
import 'package:play_together_mobile/services/recommend_service.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:play_together_mobile/widgets/app_bar_home.dart';
import 'package:play_together_mobile/widgets/bottom_bar.dart';
import 'package:play_together_mobile/widgets/player_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;

class HomePage extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;

  const HomePage({
    Key? key,
    required this.userModel,
    required this.tokenModel,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<PlayerModel> _listPlayerIsSkillSameHobbies = [];
  final List<PlayerModel> _listPlayerIsOrderByRating = [];
  final List<PlayerModel> _listPlayerIsRecentOrder = [];
  final List<PlayerModel> _listPlayerIsNewAccount = [];
  final List<PlayerModel> _listPlayerRecommend = [];
  List<UserModel> listPlayerIsSkillSameHobbies = [];
  List<UserModel> listPlayerIsOrderByRating = [];
  List<UserModel> listPlayerIsRecentOrder = [];
  List<UserModel> listPlayerIsNewAccount = [];
  List<ResultRecommendModel> listResultRecommend = [];
  List<ResultRecommendModel> listGetResultRecommend = [];
  List<RecommendModel> listRecommend = [];
  List<OrderModel> _listOrder = [];
  List listPlayerIdIsSkillSameHobbies = [];
  UserModel? lateUser;
  bool checkRecentOrder = false;
  bool checkFirstOrderByRating = true;
  bool checkFirstIsNewAccount = true;
  bool checkFirstIsSkillSameHobbies = true;
  bool checkFirstIsRecentOrder = true;
  bool checkFirstPlayerRecommend = true;
  bool checkFirstTime = true;
  bool checkFirstTimeRecommend = true;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkStatus(),
        builder: (context, snapshot) {
          if (listPlayerIsRecentOrder.isNotEmpty) {
            checkRecentOrder = true;
          }
          getListPlayerId();
          return Scaffold(
            appBar: Appbar(
              height: 70,
              titles: "Home",
              onPressedSearch: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchHistoryAndRecommendPage(
                        tokenModel: widget.tokenModel,
                        userModel: widget.userModel,
                      ),
                    ));
              },
              userModel: widget.userModel,
              tokenModel: widget.tokenModel,
            ),
            body: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoriesListPage(
                                  title: 'Đề xuất cho bạn',
                                  playerList: _listPlayerRecommend,
                                  tokenModel: widget.tokenModel,
                                  userModel: widget.userModel,
                                ),
                              ));
                        },
                        child: Row(children: [
                          Text(
                            "Đề xuất cho bạn",
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            FontAwesomeIcons.arrowAltCircleRight,
                            size: 18,
                          ),
                        ]),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: SizedBox(
                                height: 230.0,
                                child: FutureBuilder(
                                    future: loadListPlayerRecommend(),
                                    builder: (context, snapshot) {
                                      return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            _listPlayerRecommend.isNotEmpty
                                                ? _listPlayerRecommend.length
                                                : 0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return PlayerCard(
                                            playerModel:
                                                _listPlayerRecommend[index],
                                            tokenModel: widget.tokenModel,
                                            userModel: lateUser!,
                                          );
                                        },
                                      );
                                    })),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoriesListPage(
                                  title: 'Top người chơi ưa thích',
                                  playerList: _listPlayerIsOrderByRating,
                                  tokenModel: widget.tokenModel,
                                  userModel: widget.userModel,
                                ),
                              ));
                        },
                        child: Row(children: [
                          Text(
                            "Top người chơi ưa thích",
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            FontAwesomeIcons.arrowAltCircleRight,
                            size: 18,
                          ),
                        ]),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: SizedBox(
                                height: 230.0,
                                child: FutureBuilder(
                                    future: loadListPlayerIsOrderByRating(),
                                    builder: (context, snapshot) {
                                      return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _listPlayerIsOrderByRating
                                                .isNotEmpty
                                            ? _listPlayerIsOrderByRating.length
                                            : 0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return PlayerCard(
                                            playerModel:
                                                _listPlayerIsOrderByRating[
                                                    index],
                                            tokenModel: widget.tokenModel,
                                            userModel: lateUser!,
                                          );
                                        },
                                      );
                                    })),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoriesListPage(
                                  title: 'Các người chơi mới',
                                  playerList: _listPlayerIsNewAccount,
                                  tokenModel: widget.tokenModel,
                                  userModel: widget.userModel,
                                ),
                              ));
                        },
                        child: Row(children: [
                          Text(
                            "Các người chơi mới",
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            FontAwesomeIcons.arrowAltCircleRight,
                            size: 18,
                          ),
                        ]),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: SizedBox(
                                height: 230.0,
                                child: FutureBuilder(
                                    future: loadListPlayerIsNewAccount(),
                                    builder: (context, snapshot) {
                                      return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            _listPlayerIsNewAccount.isNotEmpty
                                                ? _listPlayerIsNewAccount.length
                                                : 0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return PlayerCard(
                                            playerModel:
                                                _listPlayerIsNewAccount[index],
                                            tokenModel: widget.tokenModel,
                                            userModel: lateUser!,
                                          );
                                        },
                                      );
                                    })),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoriesListPage(
                                  title: 'Có thể bạn sẽ thích',
                                  playerList: _listPlayerIsSkillSameHobbies,
                                  tokenModel: widget.tokenModel,
                                  userModel: widget.userModel,
                                ),
                              ));
                        },
                        child: Row(children: [
                          Text(
                            "Có thể bạn sẽ thích",
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            FontAwesomeIcons.arrowAltCircleRight,
                            size: 18,
                          ),
                        ]),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: SizedBox(
                                height: 230.0,
                                child: FutureBuilder(
                                    future: loadListPlayerIsSkillSameHobbies(),
                                    builder: (context, snapshot) {
                                      return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _listPlayerIsSkillSameHobbies
                                                .isNotEmpty
                                            ? _listPlayerIsSkillSameHobbies
                                                .length
                                            : 0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return PlayerCard(
                                            playerModel:
                                                _listPlayerIsSkillSameHobbies[
                                                    index],
                                            tokenModel: widget.tokenModel,
                                            userModel: lateUser!,
                                          );
                                        },
                                      );
                                    })),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    ),
                    Visibility(
                      visible: checkRecentOrder,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoriesListPage(
                                    title: 'Thuê lại',
                                    playerList: _listPlayerIsRecentOrder,
                                    tokenModel: widget.tokenModel,
                                    userModel: widget.userModel,
                                  ),
                                ));
                          },
                          child: Row(children: [
                            Text(
                              "Thuê lại",
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              FontAwesomeIcons.arrowAltCircleRight,
                              size: 18,
                            ),
                          ]),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: checkRecentOrder,
                      child: const SizedBox(
                        height: 10,
                      ),
                    ),
                    Visibility(
                      visible: checkRecentOrder,
                      child: SingleChildScrollView(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: SizedBox(
                                  height: 230.0,
                                  child: FutureBuilder(
                                      future: loadListPlayerIsRecentOrder(),
                                      builder: (context, snapshot) {
                                        return ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: _listPlayerIsRecentOrder
                                                  .isNotEmpty
                                              ? _listPlayerIsRecentOrder.length
                                              : 0,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return PlayerCard(
                                              playerModel:
                                                  _listPlayerIsRecentOrder[
                                                      index],
                                              tokenModel: widget.tokenModel,
                                              userModel: lateUser!,
                                            );
                                          },
                                        );
                                      })),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                      ),
                    ),
                  ]),
            ),
            bottomNavigationBar: BottomBar(
              userModel: widget.userModel,
              tokenModel: widget.tokenModel,
              bottomBarIndex: 0,
            ),
          );
        });
  }

  void getListPlayerId() {
    if (checkFirstTime && listPlayerIsSkillSameHobbies.length == 5) {
      for (var playerId in listPlayerIsSkillSameHobbies) {
        listPlayerIdIsSkillSameHobbies.add(playerId.id);
      }
      checkFirstTime = false;
    }
  }

  void getListRecommend() {
    if (checkFirstTimeRecommend && listPlayerIdIsSkillSameHobbies.length == 5) {
      for (var playerId in listPlayerIdIsSkillSameHobbies) {
        RecommendModel recommendModel =
            RecommendModel(userId: widget.userModel.id, playerId: playerId);
        listRecommend.add(recommendModel);
      }
      checkFirstTimeRecommend = false;
    }
  }

  Future loadListPlayerRecommend() {
    double score;
    getListRecommend();
    Future<List<ResultRecommendModel>?> listPlayerRecommendFuture =
        RecommendService().predict(listRecommend, widget.tokenModel.message);
    listPlayerRecommendFuture.then((_playerList) {
      if (checkFirstPlayerRecommend && listRecommend.length == 5) {
        listResultRecommend = _playerList!;

        for (var result in listResultRecommend) {
          score = double.parse(result.score);
          if (score > 3.5) {
            listGetResultRecommend.add(result);
          }
        }
        if (listGetResultRecommend.isNotEmpty) {
          for (var item in listGetResultRecommend) {
            Future<ResponseModel<PlayerModel>?> getPlayerByIdFuture =
                UserService()
                    .getPlayerById(item.playerId, widget.tokenModel.message);
            getPlayerByIdFuture.then((value) {
              if (value != null) {
                _listPlayerRecommend.add(value.content);
              }
            });
          }
        }
        checkFirstPlayerRecommend = false;
      }
    });
    return listPlayerRecommendFuture;
  }

  Future loadListPlayerIsOrderByRating() {
    Future<ResponseListModel<UserModel>?> listPlayerIsOrderByRatingFuture =
        UserService().getAllUsersIsOrderByRating(widget.tokenModel.message);
    listPlayerIsOrderByRatingFuture.then((_playerList) {
      if (checkFirstOrderByRating) {
        listPlayerIsOrderByRating = _playerList!.content;
        if (_listPlayerIsOrderByRating.isEmpty) {
          for (var item in listPlayerIsOrderByRating) {
            Future<ResponseModel<PlayerModel>?> getPlayerByIdFuture =
                UserService().getPlayerById(item.id, widget.tokenModel.message);
            getPlayerByIdFuture.then((value) {
              if (value != null) {
                _listPlayerIsOrderByRating.add(value.content);
              }
            });
          }
        }
        checkFirstOrderByRating = false;
      }
    });
    return listPlayerIsOrderByRatingFuture;
  }

  Future loadListPlayerIsNewAccount() {
    Future<ResponseListModel<UserModel>?> listPlayerIsNewAccountFuture =
        UserService().getAllUsersIsNewAccount(widget.tokenModel.message);
    listPlayerIsNewAccountFuture.then((_playerList) {
      if (checkFirstIsNewAccount) {
        listPlayerIsNewAccount = _playerList!.content;
        if (_listPlayerIsNewAccount.isEmpty) {
          for (var item in listPlayerIsNewAccount) {
            Future<ResponseModel<PlayerModel>?> getPlayerByIdFuture =
                UserService().getPlayerById(item.id, widget.tokenModel.message);
            getPlayerByIdFuture.then((value) {
              if (value != null) {
                _listPlayerIsNewAccount.add(value.content);
              }
            });
          }
        }
        checkFirstIsNewAccount = false;
      }
    });
    return listPlayerIsNewAccountFuture;
  }

  Future loadListPlayerIsSkillSameHobbies() {
    Future<ResponseListModel<UserModel>?> listPlayerIsSkillSameHobbiesFuture =
        UserService().getAllUsersIsSameHobbies(widget.tokenModel.message);
    listPlayerIsSkillSameHobbiesFuture.then((_playerList) {
      if (checkFirstIsSkillSameHobbies) {
        listPlayerIsSkillSameHobbies = _playerList!.content;

        if (_listPlayerIsSkillSameHobbies.isEmpty) {
          for (var item in listPlayerIsSkillSameHobbies) {
            Future<ResponseModel<PlayerModel>?> getPlayerByIdFuture =
                UserService().getPlayerById(item.id, widget.tokenModel.message);
            getPlayerByIdFuture.then((value) {
              if (value != null) {
                _listPlayerIsSkillSameHobbies.add(value.content);
              }
            });
          }
        }
        checkFirstIsSkillSameHobbies = false;
      }
    });
    return listPlayerIsSkillSameHobbiesFuture;
  }

  Future loadListPlayerIsRecentOrder() {
    Future<ResponseListModel<UserModel>?> listPlayerIsRecentOrderFuture =
        UserService().getAllUsersIsRecentOrder(widget.tokenModel.message);
    listPlayerIsRecentOrderFuture.then((_playerList) {
      if (checkFirstIsRecentOrder) {
        listPlayerIsRecentOrder = _playerList!.content;
        if (_listPlayerIsRecentOrder.isEmpty) {
          for (var item in listPlayerIsRecentOrder) {
            Future<ResponseModel<PlayerModel>?> getPlayerByIdFuture =
                UserService().getPlayerById(item.id, widget.tokenModel.message);
            getPlayerByIdFuture.then((value) {
              if (value != null) {
                _listPlayerIsRecentOrder.add(value.content);
              }
            });
          }
        }
        checkFirstIsRecentOrder = false;
      }
    });
    return listPlayerIsRecentOrderFuture;
  }

  Future checkStatus() {
    Future<ResponseModel<UserModel>?> getStatusUser =
        UserService().getUserProfile(widget.tokenModel.message);
    getStatusUser.then((value) {
      if (value != null) {
        if (value.content.status.contains('Online')) {
          if (!mounted) return;
          setState(() {
            lateUser = value.content;
          });
        } else if (value.content.status.contains('Hiring')) {
          Future<ResponseListModel<OrderModel>?> checkOrderUser =
              OrderService().getOrderOfPlayer(widget.tokenModel.message);
          checkOrderUser.then(((order) {
            _listOrder = order!.content;
            if (_listOrder[0].toUserId == widget.userModel.id) {
              lateUser = value.content;
              setState(() {
                helper.pushInto(
                    context,
                    HiringPage(
                      tokenModel: widget.tokenModel,
                      userModel: lateUser,
                      orderModel: _listOrder[0],
                    ),
                    true);
              });
            }
          }));
        } else {
          Future<ResponseListModel<OrderModel>?> checkOrderUser =
              OrderService().getOrderOfPlayer(widget.tokenModel.message);
          checkOrderUser.then(((order) {
            _listOrder = order!.content;
            if (_listOrder[0].toUserId == widget.userModel.id) {
              lateUser = value.content;
              setState(() {
                helper.pushInto(
                    context,
                    ReceiveRequestPage(
                        orderModel: _listOrder[0],
                        tokenModel: widget.tokenModel,
                        userModel: lateUser!),
                    true);
              });
            }
          }));
        }
      }
    });
    return getStatusUser;
  }
}
