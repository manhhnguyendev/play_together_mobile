import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/charity_model.dart';
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/hiring_negotiating_page.dart';
import 'package:play_together_mobile/pages/hiring_stage_page.dart';
import 'package:play_together_mobile/pages/receive_request_page.dart';
import 'package:play_together_mobile/services/charity_service.dart';
import 'package:play_together_mobile/services/order_service.dart';
import 'package:play_together_mobile/services/search_service.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:play_together_mobile/widgets/bottom_bar.dart';
import 'package:play_together_mobile/widgets/charity_card.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;
import 'package:google_fonts/google_fonts.dart';

class CharityPage extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;

  const CharityPage({
    Key? key,
    required this.userModel,
    required this.tokenModel,
  }) : super(key: key);

  @override
  State<CharityPage> createState() => _CharityPageState();
}

class _CharityPageState extends State<CharityPage> {
  UserModel? lateUser;
  List<OrderModel> _listOrder = [];
  late String search;
  final _controller = TextEditingController();
  List<CharityModel> _listCharity = [];
  bool checkFirstTime = true;
  bool checkSearchFirstTime = true;

  Future loadListCharity() {
    Future<ResponseListModel<CharityModel>?> listCharityModelFuture =
        CharityService().getAllCharities(widget.tokenModel.message);
    listCharityModelFuture.then((_charityList) {
      if (checkFirstTime) {
        _listCharity = _charityList!.content;
        if (_listCharity.isEmpty) {
          for (var item in _listCharity) {
            Future<ResponseModel<CharityModel>?> charityFuture =
                CharityService()
                    .getCharityById(item.id, widget.tokenModel.message);
            charityFuture.then((value) {
              if (value != null) {
                _listCharity.add(value.content);
              }
            });
          }
        }
        checkFirstTime = false;
      }
    });
    return listCharityModelFuture;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (checkSearchFirstTime) {
      _controller.text = "";
      checkSearchFirstTime = false;
    }
    return FutureBuilder(
        future: checkStatus(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              elevation: 1,
              backgroundColor: Colors.white,
              bottomOpacity: 0,
              toolbarOpacity: 1,
              toolbarHeight: 65,
              title: Container(
                margin: const EdgeInsets.only(top: 10, left: 10),
                child: Row(children: [
                  const CircleAvatar(
                    radius: 27,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage(
                        "assets/images/play_together_logo_no_text.png"),
                  ),
                  SizedBox(
                    width: size.width / 25,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: size.width * 0.7,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        style: GoogleFonts.montserrat(),
                        controller: _controller,
                        onSubmitted: (value) {
                          _controller.text = value;
                          Future<ResponseListModel<CharityModel>?>
                          getListSearchUser = SearchService()
                              .searchCharityByName(value, widget.tokenModel.message);
                          getListSearchUser.then((_userList) {
                            setState(() {
                              _listCharity = _userList!.content;
                            });
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintStyle: GoogleFonts.montserrat(),
                          hintText: "Tìm kiếm hội từ thiện",
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  )
                ]),
              ),
            ),
            body: SingleChildScrollView(
                child: FutureBuilder(
                    future: loadListCharity(),
                    builder: (context, snapshot) {
                      return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Column(
                              children: List.generate(
                                  _listCharity.length,
                                  (index) =>
                                      buildListSearch(_listCharity[index]))));
                    })),
            bottomNavigationBar: BottomBar(
              userModel: widget.userModel,
              tokenModel: widget.tokenModel,
              bottomBarIndex: 2,
            ),
          );
        });
  }

  Widget buildListSearch(CharityModel _charityModel) {
    return CharityCard(
        charityModel: _charityModel,
        tokenModel: widget.tokenModel,
        userModel: widget.userModel);
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
              }));
            } else {
              _listOrder = orderUser.content;
              if (_listOrder[0].userId == widget.userModel.id) {
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
            } else {
              _listOrder = orderUser.content;
              if (_listOrder[0].userId == widget.userModel.id) {
                lateUser = value.content;
                Future<ResponseModel<PlayerModel>?> getPlayerModel =
                    UserService().getPlayerById(
                        _listOrder[0].toUserId, widget.tokenModel.message);
                getPlayerModel.then((playerModel) {
                  if (playerModel != null) {
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
          }));
        }
      }
    });
    return getStatusUser;
  }
}
