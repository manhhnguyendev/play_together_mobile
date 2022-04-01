import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/hiring_negotiating_page.dart';
import 'package:play_together_mobile/services/order_service.dart';
import 'package:play_together_mobile/widgets/checkbox_state.dart';
import 'package:play_together_mobile/widgets/second_main_button.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

class SendHiringRequestPage extends StatefulWidget {
  final UserModel userModel;
  final PlayerModel? playerModel;
  final List<GameOfUserModel>? listGameAndRank;
  final TokenModel tokenModel;

  const SendHiringRequestPage({
    Key? key,
    required this.userModel,
    required this.playerModel,
    required this.tokenModel,
    this.listGameAndRank,
  }) : super(key: key);

  @override
  _SendHiringRequestPageState createState() => _SendHiringRequestPageState();
}

class _SendHiringRequestPageState extends State<SendHiringRequestPage> {
  OrderModel? orderModel;
  bool checkFirstTime = true;
  int chooseTime = 1;
  int maxHour = 5;
  String beginMessage = '';
  List<int> listHour = [];
  List listGames = [];
  List listGamesCheckBox = [];
  List listGameId = [];
  List listGamesChoosen = [];
  List<GameOrderModel> games = [];
  late double totalTimes;

  void createAListCheckBox() {
    if (widget.listGameAndRank == null) {
      for (var i = 0; i < listGames.length; i++) {
        listGamesCheckBox.add(CheckBoxState(title: listGames[i]));
      }
    } else {
      for (var i = 0; i < widget.listGameAndRank!.length; i++) {
        listGamesCheckBox
            .add(CheckBoxState(title: widget.listGameAndRank![i].game.name));
      }
    }
  }

  void createHourList() {
    for (var i = 1; i <= widget.playerModel!.maxHourHire; i++) {
      listHour.add(i);
    }
    chooseTime = listHour[0];
  }

  @override
  Widget build(BuildContext context) {
    if (checkFirstTime) {
      createHourList();
      createAListCheckBox();
      checkFirstTime = false;
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
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
        child: Column(children: [
          const SizedBox(
            height: 60,
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.playerModel!.avatar),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.playerModel!.name,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 2,
                ),
                createStatus(widget.playerModel!.status),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 25, 10),
            child: Row(
              children: [
                const Text(
                  'Thời lượng thuê: ',
                  style: TextStyle(fontSize: 18),
                ),
                const Spacer(),
                SizedBox(
                  width: 80,
                  child: DropdownButton(
                    isExpanded: true,
                    value: chooseTime,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: listHour.map((item) {
                      return DropdownMenuItem(
                          child: Text(item.toString()), value: item);
                    }).toList(),
                    onChanged: (value) {
                      chooseTime = int.parse(value.toString());
                      setState(() {
                        chooseTime = int.parse(value.toString());
                      });
                    },
                  ),
                ),
                const Text(
                  ' giờ',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 25, 10),
            child: Row(
              children: [
                const Text(
                  'Chi phí tổng ',
                  style: TextStyle(fontSize: 18),
                ),
                const Spacer(),
                Text(
                  (widget.playerModel!.pricePerHour * chooseTime)
                      .toStringAsFixed(0)
                      .toVND(),
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 25, 10),
            child: Row(
              children: [
                const Text(
                  'Số dư hiện tại ',
                  style: TextStyle(fontSize: 18),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add_circle_outline)),
                Text(
                  widget.userModel.userBalance.balance
                      .toStringAsFixed(0)
                      .toVND(),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
            child: const Text(
              'Tựa game bạn chọn ',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 25, 10),
            child: Column(
              children: List.generate(
                  widget.listGameAndRank != null ? listGamesCheckBox.length : 0,
                  (index) => buildSingleCheckBox(listGamesCheckBox[index])),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
            child: Container(
              height: 250,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: TextFormField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                maxLength: 1000,
                onChanged: (newValue) => beginMessage = newValue,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                  counterText: "",
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: "Nhập lời nhắn...",
                  hintText: "Nhập vào lời nhắn của bạn",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ]),
      ),
      bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: SecondMainButton(
                text: 'Gửi yêu cầu',
                onpress: (widget.playerModel!.pricePerHour * chooseTime) <=
                        widget.userModel.userBalance.balance
                    ? () {
                        setState(() {
                          for (var item in listGamesChoosen) {
                            for (var game in widget.listGameAndRank!) {
                              if (game.game.name.contains(item)) {
                                GameOrderModel gameOfOrder =
                                    GameOrderModel(gameId: game.gameId);
                                games.add(gameOfOrder);
                              }
                            }
                          }
                          CreateOrderModel createOrderModel = CreateOrderModel(
                              totalTimes: chooseTime,
                              message: beginMessage,
                              games: games);
                          Future<OrderModel?> orderModelFuture = OrderService()
                              .createOrderRequest(widget.playerModel!.id,
                                  createOrderModel, widget.tokenModel.message);
                          orderModelFuture.then((order) {
                            if (order != null) {
                              setState(() {
                                orderModel = order;
                                print('OrderId: ' + orderModel!.id);
                                helper.pushInto(
                                    context,
                                    HiringNegotiatingPage(
                                        tokenModel: widget.tokenModel,
                                        userModel: widget.userModel,
                                        orderModel: orderModel,
                                        playerModel: widget.playerModel),
                                    true);
                              });
                            }
                          });
                        });
                      }
                    : () {},
                height: 50,
                width: 150),
          )),
    );
  }

  Widget buildSingleCheckBox(CheckBoxState cbState) => CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: const Color(0xff8980FF),
        value: cbState.value,
        onChanged: (value) => setState(() {
          if (value == true) {
            cbState.value = value!;
            listGamesChoosen.add(cbState.title);
          } else {
            cbState.value = value!;
            listGamesChoosen.remove(cbState.title);
          }
        }),
        title: Text(
          cbState.title,
          style: const TextStyle(fontSize: 15),
        ),
      );

  Widget createStatus(String status) {
    if (status == 'Online') {
      return const Text(
        'Có thể thuê',
        style: TextStyle(fontSize: 15, color: Colors.green),
      );
    }

    return Text(
      status,
      style: const TextStyle(fontSize: 15, color: Colors.black),
    );
  }
}
