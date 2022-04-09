import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/order_model.dart';
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
  List<UserModel>? playerListIsOrderByRating;
  List<UserModel>? playerListIsNewAccount;
  List<UserModel>? playerListIsSameHobbies;
  List<UserModel>? playerListIsRecentOrder;
  List<PlayerModel>? _listPlayerIsOrderByRating;
  List<PlayerModel>? _listPlayerIsNewAccount;
  List<PlayerModel>? _listPlayerIsSameHobbies;
  List<PlayerModel>? _listPlayerIsRecentOrder;
  List<OrderModel>? _listOrder;
  UserModel? lateUser;

  Future loadListUserByIsOrderByRating() {
    playerListIsOrderByRating ??= [];
    _listPlayerIsOrderByRating ??= [];
    Future<List<UserModel>?> listUserIsOrderByRatingModelFuture =
        UserService().getAllUsersIsOrderByRating(widget.tokenModel.message);
    listUserIsOrderByRatingModelFuture.then((_playerList) {
      playerListIsOrderByRating = _playerList;
      if (_listPlayerIsOrderByRating!.isEmpty) {
        for (var item in playerListIsOrderByRating!) {
          Future<PlayerModel?> playerFuture =
              UserService().getPlayerById(item.id, widget.tokenModel.message);
          playerFuture.then((value) {
            if (value != null) {
              _listPlayerIsOrderByRating!.add(value);
            }
          });
        }
      }
    });
    return listUserIsOrderByRatingModelFuture;
  }

  Future loadListUserByIsNewAccount() {
    playerListIsNewAccount ??= [];
    _listPlayerIsNewAccount ??= [];
    Future<List<UserModel>?> listUserIsNewAccountModelFuture =
        UserService().getAllUsersIsNewAccount(widget.tokenModel.message);
    listUserIsNewAccountModelFuture.then((_playerList) {
      playerListIsNewAccount = _playerList;
      if (_listPlayerIsNewAccount!.isEmpty) {
        for (var item in playerListIsNewAccount!) {
          Future<PlayerModel?> playerFuture =
              UserService().getPlayerById(item.id, widget.tokenModel.message);
          playerFuture.then((value) {
            if (value != null) {
              _listPlayerIsNewAccount!.add(value);
            }
          });
        }
      }
    });
    return listUserIsNewAccountModelFuture;
  }

  Future loadListUserByIsSameHobbies() {
    playerListIsSameHobbies ??= [];
    _listPlayerIsSameHobbies ??= [];
    Future<List<UserModel>?> listUserIsSameHobbiesModelFuture =
        UserService().getAllUsersIsSameHobbies(widget.tokenModel.message);
    listUserIsSameHobbiesModelFuture.then((_playerList) {
      playerListIsSameHobbies = _playerList;
      if (_listPlayerIsSameHobbies!.isEmpty) {
        for (var item in playerListIsSameHobbies!) {
          Future<PlayerModel?> playerFuture =
              UserService().getPlayerById(item.id, widget.tokenModel.message);
          playerFuture.then((value) {
            if (value != null) {
              _listPlayerIsSameHobbies!.add(value);
            }
          });
        }
      }
    });
    return listUserIsSameHobbiesModelFuture;
  }

  Future loadListUserByIsRecentOrder() {
    playerListIsRecentOrder ??= [];
    _listPlayerIsRecentOrder ??= [];
    Future<List<UserModel>?> listUserIsRecentOrderModelFuture =
        UserService().getAllUsersIsRecentOrder(widget.tokenModel.message);
    listUserIsRecentOrderModelFuture.then((_playerList) {
      playerListIsRecentOrder = _playerList;
      if (_listPlayerIsRecentOrder!.isEmpty) {
        for (var item in playerListIsRecentOrder!) {
          Future<PlayerModel?> playerFuture =
              UserService().getPlayerById(item.id, widget.tokenModel.message);
          playerFuture.then((value) {
            if (value != null) {
              _listPlayerIsRecentOrder!.add(value);
            }
          });
        }
      }
    });
    return listUserIsRecentOrderModelFuture;
  }

  Future checkStatus() {
    Future<UserModel?> getStatusUser =
        UserService().getUserProfile(widget.tokenModel.message);
    getStatusUser.then((value) {
      if (value != null) {
        if (value.status.contains('Online')) {
          setState(() {
            lateUser = value;
          });
        } else {
          Future<List<OrderModel>?> checkOrderUser =
              OrderService().getOrderOfPlayer(widget.tokenModel.message);
          checkOrderUser.then(((order) {
            _listOrder = order;
            if (_listOrder![0].toUserId == widget.userModel.id) {
              lateUser = value;
              setState(() {
                helper.pushInto(
                    context,
                    ReceiveRequestPage(
                        orderModel: _listOrder![0],
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
        future: checkStatus(),
        builder: (context, snapshot) {
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
              padding: const EdgeInsets.all(10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20 / 375 * size.width),
                      child: Row(children: [
                        Text(
                          "Top người chơi ưa thích",
                          style: TextStyle(
                            fontSize: 18 / 400 * size.width,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          child: const Icon(Icons.arrow_circle_down_outlined),
                        ),
                      ]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: SizedBox(
                                height: 220.0,
                                child: FutureBuilder(
                                    future: loadListUserByIsOrderByRating(),
                                    builder: (context, snapshot) {
                                      return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            _listPlayerIsOrderByRating == null
                                                ? 0
                                                : 4,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return PlayerCard(
                                            playerModel:
                                                _listPlayerIsOrderByRating![
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 20 / 375 * size.width),
                      child: Row(children: [
                        Text(
                          "Các người chơi mới",
                          style: TextStyle(
                            fontSize: 18 / 400 * size.width,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          child: const Icon(Icons.arrow_circle_down_outlined),
                        ),
                      ]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: SizedBox(
                                height: 220.0,
                                child: FutureBuilder(
                                    future: loadListUserByIsNewAccount(),
                                    builder: (context, snapshot) {
                                      return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            _listPlayerIsNewAccount == null
                                                ? 0
                                                : 4,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return PlayerCard(
                                            playerModel:
                                                _listPlayerIsNewAccount![index],
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 20 / 375 * size.width),
                      child: Row(children: [
                        Text(
                          "Có thể bạn thích",
                          style: TextStyle(
                            fontSize: 18 / 400 * size.width,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          child: const Icon(Icons.arrow_circle_down_outlined),
                        ),
                      ]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: SizedBox(
                                height: 220.0,
                                child: FutureBuilder(
                                    future: loadListUserByIsSameHobbies(),
                                    builder: (context, snapshot) {
                                      return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            _listPlayerIsSameHobbies == null
                                                ? 0
                                                : 4,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return PlayerCard(
                                            playerModel:
                                                _listPlayerIsSameHobbies![
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 20 / 375 * size.width),
                      child: Row(children: [
                        Text(
                          "Thuê lại",
                          style: TextStyle(
                            fontSize: 18 / 400 * size.width,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          child: const Icon(Icons.arrow_circle_down_outlined),
                        ),
                      ]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: SizedBox(
                                height: 220.0,
                                child: FutureBuilder(
                                    future: loadListUserByIsRecentOrder(),
                                    builder: (context, snapshot) {
                                      return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            _listPlayerIsRecentOrder == null
                                                ? 0
                                                : 4,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return PlayerCard(
                                            playerModel:
                                                _listPlayerIsRecentOrder![
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
}
