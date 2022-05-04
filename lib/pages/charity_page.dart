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
  final ScrollController _scrollController = ScrollController();
  UserModel? lateUser;
  List<OrderModel> _listOrder = [];
  late String search;
  final _controller = TextEditingController();
  List<CharityModel> _listCharity = [];
  bool checkFirstTime = true;
  bool checkSearchFirstTime = true;
  bool checkEmptyCharity = false;
  int pageSize = 10;
  bool checkHasNext = false;
  bool checkGetData = false;

  Future loadListCharity() {
    Future<ResponseListModel<CharityModel>?> listCharityModelFuture =
        CharityService().getAllCharities(widget.tokenModel.message, pageSize);
    listCharityModelFuture.then((_charityList) {
      if (_charityList != null) {
        if (checkFirstTime || checkGetData) {
          _listCharity = _charityList.content;
          checkFirstTime = false;
          if (_charityList.hasNext == false) {
            checkHasNext = true;
          } else {
            checkHasNext = false;
          }
        }
      }
    });
    return listCharityModelFuture;
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
    if (checkHasNext == false) {
      pageSize += 10;
      checkGetData = true;
    }
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
                                  .searchCharityByName(
                                      value, widget.tokenModel.message);
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
                          hintText: "Tìm kiếm",
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
                controller: _scrollController,
                child: FutureBuilder(
                    future: loadListCharity(),
                    builder: (context, snapshot) {
                      if (_listCharity.isEmpty && checkHasNext != false) {
                        checkEmptyCharity = true;
                      } else {
                        checkEmptyCharity = false;
                      }
                      return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Column(
                            children: [
                              Column(
                                  children: List.generate(
                                      _listCharity.isNotEmpty
                                          ? _listCharity.length
                                          : 0,
                                      (index) => buildListSearch(
                                          _listCharity[index]))),
                              Visibility(
                                  visible: checkEmptyCharity,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text('Không có dữ liệu',
                                        style: GoogleFonts.montserrat()),
                                  )),
                              Visibility(
                                visible: !checkHasNext,
                                child: _buildProgressIndicator(),
                              )
                            ],
                          ));
                    })),
            bottomNavigationBar: BottomBar(
              userModel: widget.userModel,
              tokenModel: widget.tokenModel,
              bottomBarIndex: 2,
            ),
          );
        });
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
