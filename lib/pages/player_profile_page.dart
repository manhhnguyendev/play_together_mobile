import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/home_page.dart';
import 'package:play_together_mobile/pages/send_hiring_request_page.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:play_together_mobile/widgets/second_main_button.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

class PlayerProfilePage extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;
  final PlayerModel playerModel;
  //final List<GameOfUserModel>? listGameAndRank;
  //final UserServiceModel? userServiceModel;

  const PlayerProfilePage({
    Key? key,
    required this.userModel,
    required this.playerModel,
    required this.tokenModel,
    // required this.listGameAndRank,
    // required this.userServiceModel
  }) : super(key: key);

  @override
  State<PlayerProfilePage> createState() => _PlayerProfilePageState();
}

class _PlayerProfilePageState extends State<PlayerProfilePage> {
  List listPlayerImage = []; //gan list images tu model vao

  List listTopHirer = [
    'Vu Quoc Hung',
    'Son Tung',
    'Bich Phuong',
  ];

  List<GameOfUserModel>? listGameAndRank;
  Future getGameOfUser() {
    listGameAndRank ??= [];
    Future<List<GameOfUserModel>?> gameOfUserFuture = UserService()
        .getGameOfUser(widget.playerModel.id, widget.tokenModel.message);
    gameOfUserFuture.then((value) {
      if (value != null) {
        setState(() {
          listGameAndRank = value;
        });
      }
    });
    return gameOfUserFuture;
  }
  // Future getUserServiceById() {
  //   Future<UserServiceModel?> userServiceModelFuture = UserService()
  //       .getUserServiceById(widget.playerModel.id, widget.tokenModel.message);
  //   userServiceModelFuture.then((userService) {
  //     if (userService != null) {
  //       setState(() {
  //         userServiceModel = userService;
  //       });
  //     }
  //   });
  //   return userServiceModelFuture;
  // }
  // PlayerModel? _playerModel;
  // Future getPlayer() {
  //   Future<PlayerModel?> playerFuture = UserService()
  //       .getPlayerById(widget.playerModel.id, widget.tokenModel.message);
  //   playerFuture.then((value) {
  //     if (value != null) {
  //       _playerModel = value;
  //     }
  //   });

  //   return playerFuture;
  // }

  // @override
  // void initState() {
  //   super.initState();

  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getGameOfUser(),
        builder: (context, snapshot) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: FlatButton(
                    child: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(widget.playerModel.avatar),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.playerModel.name,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          widget.playerModel.status,
                          style: const TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                    child: Row(
                      children: const [
                        Text(
                          'Hình ảnh',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.image,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(
                            widget.playerModel != null
                                ? widget.playerModel.images.length
                                : 0,
                            (index) => buildImageItem(
                                widget.playerModel.images[index].imageLink))),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 1,
                    decoration: const BoxDecoration(
                        border: Border(
                      top: BorderSide(
                        color: Colors.grey,
                        width: 0.1,
                      ),
                    )),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 0, 15),
                      child: Row(
                        children: [
                          Row(
                            children: const [
                              Text(
                                'Đánh giá',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Text(
                                '4.5',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Row(
                              children: const [
                                Text(
                                  'Xem chi tiết',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    decoration: const BoxDecoration(
                        border: Border(
                      top: BorderSide(
                        color: Colors.grey,
                        width: 0.1,
                      ),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        'Thông tin',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        'Description ở đây',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    decoration: const BoxDecoration(
                        border: Border(
                      top: BorderSide(
                        //                   <--- left side
                        color: Colors.grey,
                        width: 0.1,
                      ),
                    )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        'Kỹ năng',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: List.generate(
                            listGameAndRank != null
                                ? listGameAndRank!.length
                                : 0,
                            (index) => buildGameAndRankPlayer(
                                listGameAndRank![index])),
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    decoration: const BoxDecoration(
                        border: Border(
                      top: BorderSide(
                        //                   <--- left side
                        color: Colors.grey,
                        width: 0.1,
                      ),
                    )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Row(
                  children: [
                    Text(
                      widget.playerModel != null
                          ? widget.playerModel.pricePerHour
                                  .toStringAsFixed(0)
                                  .toVND() +
                              '/h'
                          : '0 đ/h',
                      style: TextStyle(fontSize: 22, color: Color(0xff320444)),
                    ),
                    const Spacer(),
                    SecondMainButton(
                        text: 'Thuê',
                        onpress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SendHiringRequestPage(
                                      userModel: widget.userModel,
                                      listGameAndRank: listGameAndRank,
                                      playerModel: widget.playerModel,
                                      tokenModel: widget.tokenModel,
                                    )),
                          );
                        },
                        height: 50,
                        width: 150),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget buildImageItem(String imageLink) => Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: NetworkImage(imageLink),
                  fit: BoxFit.cover)), //sua asset image thanh network
        ),
      );

  Widget buildGameAndRankPlayer(GameOfUserModel gameOfUser) => Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
          alignment: Alignment.topLeft,
          child: Column(
            children: [
              Text(
                gameOfUser.game.name + ":" + " rank",
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              )
            ],
          ),
        ),
      );

  // Widget buildTopHirers(String hirerName, int count) => Padding(
  //       padding: const EdgeInsets.only(left: 10),
  //       child: Container(
  //         alignment: Alignment.topLeft,
  //         child: Column(
  //           children: [
  //             Text(
  //               '#' + count.toString() + '. ' + hirerName,
  //               style: const TextStyle(
  //                   fontSize: 15, fontWeight: FontWeight.normal),
  //             ),
  //             const SizedBox(
  //               height: 5,
  //             )
  //           ],
  //         ),
  //       ),
  //     );

  Widget createStatus(String status) {
    if (status == 'Processing') {
      return Text(
        'Đang thuê',
        style: TextStyle(fontSize: 15, color: Colors.yellow),
      );
    }

    if (status == 'Ngu') {
      return Text(
        'ngu vc',
        style: TextStyle(fontSize: 15, color: Colors.red),
      );
    }

    if (status == 'Complete') {
      return Text(
        'Hoàn thành',
        style: TextStyle(fontSize: 15, color: Colors.green),
      );
    }

    if (status == 'Cancel') {
      return Text(
        'Bị từ chối',
        style: TextStyle(fontSize: 15, color: Colors.grey),
      );
    }

    return Text(
      status,
      style: TextStyle(fontSize: 15, color: Colors.black),
    );
  }
}
