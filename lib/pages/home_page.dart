import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/categories_list_page.dart';
import 'package:play_together_mobile/pages/receive_request_page.dart';
import 'package:play_together_mobile/pages/search_history_recommend_page.dart';
import 'package:play_together_mobile/services/order_service.dart';
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
  final List<PlayerModel> _listPlayerIsOrderByRating = [];
  final List<PlayerModel> _listPlayerIsNewAccount = [];
  final List<PlayerModel> _listPlayerIsSameHobbies = [];
  final List<PlayerModel> _listPlayerIsRecentOrder = [];
  List<UserModel> playerListIsOrderByRating = [];
  List<UserModel> playerListIsNewAccount = [];
  List<UserModel> playerListIsSameHobbies = [];
  List<UserModel> playerListIsRecentOrder = [];
  List<OrderModel> _listOrder = [];
  UserModel? lateUser;
  bool checkRecentOrder = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkStatus(),
        builder: (context, snapshot) {
          if (playerListIsRecentOrder.isNotEmpty) {
            checkRecentOrder = true;
          }
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
                                    future: loadListUserByIsOrderByRating(),
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
                                    future: loadListUserByIsNewAccount(),
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
                                  title: 'Có thể bạn thích',
                                  playerList: _listPlayerIsSameHobbies,
                                  tokenModel: widget.tokenModel,
                                  userModel: widget.userModel,
                                ),
                              ));
                        },
                        child: Row(children: [
                          Text(
                            "Có thể bạn thích",
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
                                    future: loadListUserByIsSameHobbies(),
                                    builder: (context, snapshot) {
                                      return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _listPlayerIsSameHobbies
                                                .isNotEmpty
                                            ? _listPlayerIsSameHobbies.length
                                            : 0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return PlayerCard(
                                            playerModel:
                                                _listPlayerIsSameHobbies[index],
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
                                    future: loadListUserByIsRecentOrder(),
                                    builder: (context, snapshot) {
                                      return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _listPlayerIsRecentOrder
                                                .isNotEmpty
                                            ? _listPlayerIsRecentOrder.length
                                            : 0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return PlayerCard(
                                            playerModel:
                                                _listPlayerIsRecentOrder[index],
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

  Future loadListUserByIsOrderByRating() {
    Future<ResponseListModel<UserModel>?> listUserIsOrderByRatingModelFuture =
        UserService().getAllUsersIsOrderByRating(widget.tokenModel.message);
    listUserIsOrderByRatingModelFuture.then((_playerList) {
      playerListIsOrderByRating = _playerList!.content;
      if (_listPlayerIsOrderByRating.isEmpty) {
        for (var item in playerListIsOrderByRating) {
          Future<ResponseModel<PlayerModel>?> playerFuture =
              UserService().getPlayerById(item.id, widget.tokenModel.message);
          playerFuture.then((value) {
            if (value != null) {
              _listPlayerIsOrderByRating.add(value.content);
            }
          });
        }
      }
    });
    return listUserIsOrderByRatingModelFuture;
  }

  Future loadListUserByIsNewAccount() {
    Future<ResponseListModel<UserModel>?> listUserIsNewAccountModelFuture =
        UserService().getAllUsersIsNewAccount(widget.tokenModel.message);
    listUserIsNewAccountModelFuture.then((_playerList) {
      playerListIsNewAccount = _playerList!.content;
      if (_listPlayerIsNewAccount.isEmpty) {
        for (var item in playerListIsNewAccount) {
          Future<ResponseModel<PlayerModel>?> playerFuture =
              UserService().getPlayerById(item.id, widget.tokenModel.message);
          playerFuture.then((value) {
            if (value != null) {
              _listPlayerIsNewAccount.add(value.content);
            }
          });
        }
      }
    });
    return listUserIsNewAccountModelFuture;
  }

  Future loadListUserByIsSameHobbies() {
    Future<ResponseListModel<UserModel>?> listUserIsSameHobbiesModelFuture =
        UserService().getAllUsersIsSameHobbies(widget.tokenModel.message);
    listUserIsSameHobbiesModelFuture.then((_playerList) {
      playerListIsSameHobbies = _playerList!.content;
      if (_listPlayerIsSameHobbies.isEmpty) {
        for (var item in playerListIsSameHobbies) {
          Future<ResponseModel<PlayerModel>?> playerFuture =
              UserService().getPlayerById(item.id, widget.tokenModel.message);
          playerFuture.then((value) {
            if (value != null) {
              _listPlayerIsSameHobbies.add(value.content);
            }
          });
        }
      }
    });
    return listUserIsSameHobbiesModelFuture;
  }

  Future loadListUserByIsRecentOrder() {
    Future<ResponseListModel<UserModel>?> listUserIsRecentOrderModelFuture =
        UserService().getAllUsersIsRecentOrder(widget.tokenModel.message);
    listUserIsRecentOrderModelFuture.then((_playerList) {
      playerListIsRecentOrder = _playerList!.content;
      if (_listPlayerIsRecentOrder.isEmpty) {
        for (var item in playerListIsRecentOrder) {
          Future<ResponseModel<PlayerModel>?> playerFuture =
              UserService().getPlayerById(item.id, widget.tokenModel.message);
          playerFuture.then((value) {
            if (value != null) {
              _listPlayerIsRecentOrder.add(value.content);
            }
          });
        }
      }
    });
    return listUserIsRecentOrderModelFuture;
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
