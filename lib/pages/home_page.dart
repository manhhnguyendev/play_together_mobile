import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/models/recommend_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/categories_list_page.dart';
import 'package:play_together_mobile/pages/end_order_page.dart';
import 'package:play_together_mobile/pages/hiring_negotiating_page.dart';
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
  List<GetAllUserModel> listPlayerRecommend = [];
  List<GetAllUserModel> listPlayerIsSkillSameHobbies = [];
  List<GetAllUserModel> listPlayerIsOrderByRating = [];
  List<GetAllUserModel> listPlayerIsRecentOrder = [];
  List<GetAllUserModel> listPlayerIsNewAccount = [];
  List<ResultRecommendModel> listResultRecommend = [];
  List<ResultRecommendModel> listGetResultRecommend = [];
  List<RecommendModel> listRecommend = [];
  List<OrderModel> _listOrder = [];
  List listPlayerToRecommend = [];
  UserModel? lateUser;
  bool checkRecentOrder = false;
  bool checkFirstOrderByRating = true;
  bool checkFirstIsNewAccount = true;
  bool checkFirstIsSkillSameHobbies = true;
  bool checkFirstIsRecentOrder = true;
  bool checkFirstPlayerRecommend = true;
  bool checkFirstTime = true;
  bool checkFirstTimeRecommend = true;
  bool checkRecommend = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkStatus(),
        builder: (context, snapshot) {
          if (listPlayerIsRecentOrder.isNotEmpty) {
            checkRecentOrder = true;
          }
          if (listPlayerRecommend.isNotEmpty) {
            checkRecommend = true;
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
                    Visibility(
                      visible: checkRecommend,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoriesListPage(
                                    title: 'Đề xuất cho bạn',
                                    playerList: listPlayerRecommend,
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
                    ),
                    Visibility(
                      visible: checkRecommend,
                      child: const SizedBox(
                        height: 10,
                      ),
                    ),
                    Visibility(
                      visible: checkRecommend,
                      child: SingleChildScrollView(
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
                                              listPlayerRecommend.isNotEmpty
                                                  ? listPlayerRecommend.length
                                                  : 0,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            if (lateUser != null) {
                                              return PlayerCard(
                                                playerModel:
                                                    listPlayerRecommend[index],
                                                tokenModel: widget.tokenModel,
                                                userModel: lateUser!,
                                              );
                                            }
                                            return const SizedBox(
                                              height: 10,
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoriesListPage(
                                  title: 'Các người chơi mới',
                                  playerList: listPlayerIsNewAccount,
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
                                            listPlayerIsNewAccount.isNotEmpty
                                                ? listPlayerIsNewAccount.length
                                                : 0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          if (lateUser != null) {
                                            return PlayerCard(
                                              playerModel:
                                                  listPlayerIsNewAccount[index],
                                              tokenModel: widget.tokenModel,
                                              userModel: lateUser!,
                                            );
                                          }
                                          return const SizedBox(
                                            height: 10,
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
                                  playerList: listPlayerIsOrderByRating,
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
                                        itemCount: listPlayerIsOrderByRating
                                                .isNotEmpty
                                            ? listPlayerIsOrderByRating.length
                                            : 0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          if (lateUser != null) {
                                            return PlayerCard(
                                              playerModel:
                                                  listPlayerIsOrderByRating[
                                                      index],
                                              tokenModel: widget.tokenModel,
                                              userModel: lateUser!,
                                            );
                                          }
                                          return const SizedBox(
                                            height: 10,
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
                                  playerList: listPlayerIsSkillSameHobbies,
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
                                        itemCount: listPlayerIsSkillSameHobbies
                                                .isNotEmpty
                                            ? listPlayerIsSkillSameHobbies
                                                .length
                                            : 0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          if (lateUser != null) {
                                            return PlayerCard(
                                              playerModel:
                                                  listPlayerIsSkillSameHobbies[
                                                      index],
                                              tokenModel: widget.tokenModel,
                                              userModel: lateUser!,
                                            );
                                          }
                                          return const SizedBox(
                                            height: 10,
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
                                    playerList: listPlayerIsRecentOrder,
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
                                          itemCount: listPlayerIsRecentOrder
                                                  .isNotEmpty
                                              ? listPlayerIsRecentOrder.length
                                              : 0,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            if (lateUser != null) {
                                              return PlayerCard(
                                                playerModel:
                                                    listPlayerIsRecentOrder[
                                                        index],
                                                tokenModel: widget.tokenModel,
                                                userModel: lateUser!,
                                              );
                                            }
                                            return const SizedBox(
                                              height: 10,
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
    if (checkFirstTime && listPlayerIsOrderByRating.length == 4) {
      for (var playerId in listPlayerIsOrderByRating) {
        listPlayerToRecommend.add(playerId.id);
      }
      checkFirstTime = false;
    }
  }

  void getListRecommend() {
    if (checkFirstTimeRecommend && listPlayerToRecommend.length == 4) {
      for (var playerId in listPlayerToRecommend) {
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
      if (checkFirstPlayerRecommend && listRecommend.length == 4) {
        listResultRecommend = _playerList!;
        for (var result in listResultRecommend) {
          score = double.parse(result.score);
          if (score > 3.5) {
            Future<ResponseModel<GetAllUserModel>?> getPlayerByIdFuture =
                UserService().getPlayerRecommendById(
                    result.playerId, widget.tokenModel.message);
            getPlayerByIdFuture.then((value) {
              listPlayerRecommend.add(value!.content);
            });
          }
        }
        checkFirstPlayerRecommend = false;
      }
    });
    return listPlayerRecommendFuture;
  }

  Future loadListPlayerIsOrderByRating() {
    Future<ResponseListModel<GetAllUserModel>?>
        listPlayerIsOrderByRatingFuture =
        UserService().getAllUsersIsOrderByRating(widget.tokenModel.message);
    listPlayerIsOrderByRatingFuture.then((_playerList) {
      if (checkFirstOrderByRating) {
        listPlayerIsOrderByRating = _playerList!.content;
        checkFirstOrderByRating = false;
      }
    });
    return listPlayerIsOrderByRatingFuture;
  }

  Future loadListPlayerIsNewAccount() {
    Future<ResponseListModel<GetAllUserModel>?> listPlayerIsNewAccountFuture =
        UserService().getAllUsersIsNewAccount(widget.tokenModel.message);
    listPlayerIsNewAccountFuture.then((_playerList) {
      if (checkFirstIsNewAccount) {
        listPlayerIsNewAccount = _playerList!.content;
        checkFirstIsNewAccount = false;
      }
    });
    return listPlayerIsNewAccountFuture;
  }

  Future loadListPlayerIsSkillSameHobbies() {
    Future<ResponseListModel<GetAllUserModel>?>
        listPlayerIsSkillSameHobbiesFuture =
        UserService().getAllUsersIsSkillSameHobbies(widget.tokenModel.message);
    listPlayerIsSkillSameHobbiesFuture.then((_playerList) {
      if (checkFirstIsSkillSameHobbies) {
        listPlayerIsSkillSameHobbies = _playerList!.content;
        checkFirstIsSkillSameHobbies = false;
      }
    });
    return listPlayerIsSkillSameHobbiesFuture;
  }

  Future loadListPlayerIsRecentOrder() {
    Future<ResponseListModel<GetAllUserModel>?> listPlayerIsRecentOrderFuture =
        UserService().getAllUsersIsRecentOrder(widget.tokenModel.message);
    listPlayerIsRecentOrderFuture.then((_playerList) {
      if (checkFirstIsRecentOrder) {
        listPlayerIsRecentOrder = _playerList!.content;
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
          Future<ResponseListModel<OrderModel>?> checkOrderUser = OrderService()
              .getOrderOfUser(widget.tokenModel.message, 'Starting');
          checkOrderUser.then(((orderUser) {
            if (orderUser!.content.isEmpty) {
              Future<ResponseListModel<OrderModel>?> checkOrderPlayer =
                  OrderService()
                      .getOrderOfPlayer(widget.tokenModel.message, 'Starting');
              checkOrderPlayer.then(((orderPlayer) {
                _listOrder = orderPlayer!.content;
                if (_listOrder[0].toUserId == widget.userModel.id) {
                  if (helper.getDayElapsed(
                          DateTime.now().toString(),
                          DateTime.parse(orderPlayer.content[0].timeStart)
                              .add(Duration(
                                  hours: orderPlayer.content[0].totalTimes))
                              .toString()) <=
                      0) {
                    Future<bool?> finishOrderFuture = OrderService()
                        .finishOrder(orderPlayer.content[0].id,
                            widget.tokenModel.message);
                    finishOrderFuture.then((check) {
                      if (check == true) {
                        setState(() {
                          helper.pushInto(
                              context,
                              EndOrderPage(
                                tokenModel: widget.tokenModel,
                                userModel: widget.userModel,
                                orderModel: _listOrder[0],
                              ),
                              true);
                        });
                      }
                    });
                  } else if ((helper.getDayElapsed(
                          DateTime.now().toString(),
                          DateTime.parse(orderPlayer.content[0].timeStart)
                              .add(Duration(
                                  hours: orderPlayer.content[0].totalTimes))
                              .toString()) >
                      1)) {
                    lateUser = value.content;
                    setState(() {
                      helper.pushInto(
                          context,
                          HiringPage(
                              orderModel: _listOrder[0],
                              tokenModel: widget.tokenModel,
                              userModel: lateUser!),
                          true);
                    });
                  }
                }
              }));
            } else {
              _listOrder = orderUser.content;
              if (_listOrder[0].userId == widget.userModel.id) {
                if (helper.getDayElapsed(
                        DateTime.now().toString(),
                        DateTime.parse(orderUser.content[0].timeStart)
                            .add(Duration(
                                hours: orderUser.content[0].totalTimes))
                            .toString()) <=
                    0) {
                  Future<bool?> finishOrderFuture = OrderService().finishOrder(
                      orderUser.content[0].id, widget.tokenModel.message);
                  finishOrderFuture.then((check) {
                    if (check == true) {
                      setState(() {
                        helper.pushInto(
                            context,
                            EndOrderPage(
                              tokenModel: widget.tokenModel,
                              userModel: widget.userModel,
                              orderModel: _listOrder[0],
                            ),
                            true);
                      });
                    }
                  });
                } else if (helper.getDayElapsed(
                        DateTime.now().toString(),
                        DateTime.parse(orderUser.content[0].timeStart)
                            .add(Duration(
                                hours: orderUser.content[0].totalTimes))
                            .toString()) >
                    1) {
                  lateUser = value.content;
                  setState(() {
                    helper.pushInto(
                        context,
                        HiringPage(
                            orderModel: _listOrder[0],
                            tokenModel: widget.tokenModel,
                            userModel: lateUser!),
                        true);
                  });
                }
              }
            }
          }));
        } else if (value.content.status.contains('Processing')) {
          Future<ResponseListModel<OrderModel>?> checkOrderUser = OrderService()
              .getOrderOfUser(widget.tokenModel.message, 'Processing');
          checkOrderUser.then(((orderUser) {
            if (orderUser!.content.isEmpty) {
              Future<ResponseListModel<OrderModel>?> checkOrderPlayer =
                  OrderService().getOrderOfPlayer(
                      widget.tokenModel.message, 'Processing');
              checkOrderPlayer.then(((orderPlayer) {
                _listOrder = orderPlayer!.content;
                if (_listOrder[0].toUserId == widget.userModel.id) {
                  if (helper.getDayElapsed(DateTime.now().toString(),
                          orderPlayer.content[0].processExpired) <
                      0) {
                    RejectOrderModel rejectOrder = RejectOrderModel(
                        isAccept: false, reason: 'Quá thời gian chấp thuận');
                    Future<bool?> rejectFuture = OrderService()
                        .rejectOrderRequest(orderPlayer.content[0].id,
                            widget.tokenModel.message, rejectOrder);
                    rejectFuture.then((check) {
                      if (check == true) {
                        setState(() {
                          helper.pushInto(
                              context,
                              HomePage(
                                tokenModel: widget.tokenModel,
                                userModel: widget.userModel,
                              ),
                              true);
                        });
                      }
                    });
                  } else if (helper.getDayElapsed(DateTime.now().toString(),
                          orderPlayer.content[0].processExpired) >
                      1) {
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
                }
              }));
            } else {
              _listOrder = orderUser.content;
              if (_listOrder[0].userId == widget.userModel.id) {
                if (helper.getDayElapsed(DateTime.now().toString(),
                        orderUser.content[0].processExpired) <=
                    0) {
                  CancelOrderModel cancelOrder =
                      CancelOrderModel(reason: 'Quá thời gian gửi yêu cầu');
                  Future<bool?> cancelFuture = OrderService()
                      .cancelOrderRequest(orderUser.content[0].id,
                          widget.tokenModel.message, cancelOrder);
                  cancelFuture.then((check) {
                    if (check == true) {
                      setState(() {
                        helper.pushInto(
                            context,
                            HomePage(
                              tokenModel: widget.tokenModel,
                              userModel: widget.userModel,
                            ),
                            true);
                      });
                    }
                  });
                } else if (helper.getDayElapsed(DateTime.now().toString(),
                        orderUser.content[0].processExpired) >
                    1) {
                  lateUser = value.content;
                  Future<ResponseModel<PlayerModel>?> getPlayerModel =
                      UserService().getPlayerById(
                          _listOrder[0].toUserId, widget.tokenModel.message);
                  getPlayerModel.then((playerModel) {
                    if (playerModel != null) {
                      if (!mounted) return;
                      setState(() {
                        helper.pushInto(
                            context,
                            HiringNegotiatingPage(
                                orderModel: _listOrder[0],
                                tokenModel: widget.tokenModel,
                                userModel: lateUser!,
                                playerModel: playerModel.content),
                            true);
                      });
                    }
                  });
                }
              }
            }
          }));
        }
      }
    });
    return getStatusUser;
  }
}
