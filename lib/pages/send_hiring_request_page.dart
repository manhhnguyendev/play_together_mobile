import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/email_model.dart';
import 'package:play_together_mobile/models/game_of_user_model.dart';
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/hiring_negotiating_page.dart';
import 'package:play_together_mobile/services/email_service.dart';
import 'package:play_together_mobile/services/order_service.dart';
import 'package:play_together_mobile/widgets/checkbox_state.dart';
import 'package:play_together_mobile/widgets/second_main_button.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:google_fonts/google_fonts.dart';

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
  int chooseTime = 0;
  int maxHour = 0;
  String beginMessage = '';
  List<int> listHour = [];
  List listGames = [];
  List listGamesCheckBox = [];
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
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(
                  height: 160,
                  width: 160,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.playerModel!.avatar),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.playerModel!.name,
                  style: GoogleFonts.montserrat(fontSize: 22),
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
                Text(
                  'Thời lượng thuê ',
                  style: GoogleFonts.montserrat(fontSize: 18),
                ),
                const Spacer(),
                SizedBox(
                  width: 80,
                  child: DropdownButton(
                    style: GoogleFonts.montserrat(
                        fontSize: 15, color: Colors.black),
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
                Text(
                  ' giờ',
                  style: GoogleFonts.montserrat(fontSize: 18),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 25, 10),
            child: Row(
              children: [
                Text(
                  'Chi phí tổng ',
                  style: GoogleFonts.montserrat(fontSize: 18),
                ),
                const Spacer(),
                Text(
                  (widget.playerModel!.pricePerHour * chooseTime)
                      .toStringAsFixed(0)
                      .toVND(),
                  style: GoogleFonts.montserrat(fontSize: 18),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 25, 10),
            child: Row(
              children: [
                Text(
                  'Số dư hiện tại ',
                  style: GoogleFonts.montserrat(fontSize: 18),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add_circle_outline)),
                Text(
                  widget.userModel.userBalance.balance
                      .toStringAsFixed(0)
                      .toVND(),
                  style: GoogleFonts.montserrat(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
            child: Text(
              'Tựa game bạn chọn ',
              style: GoogleFonts.montserrat(fontSize: 18),
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
              height: 200,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: TextFormField(
                style: GoogleFonts.montserrat(),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                maxLength: 1000,
                onChanged: (newValue) => beginMessage = newValue,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                  counterText: "",
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: "Nhập lời nhắn...",
                  hintStyle: GoogleFonts.montserrat(),
                  labelStyle: GoogleFonts.montserrat(),
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
                onPress: (widget.playerModel!.pricePerHour * chooseTime) <=
                        widget.userModel.userBalance.balance
                    ? () {
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
                        if (games.isNotEmpty) {
                          if (beginMessage.isNotEmpty) {
                            Future<ResponseModel<OrderModel>?>
                                orderModelFuture = OrderService()
                                    .createOrderRequest(
                                        widget.playerModel!.id,
                                        createOrderModel,
                                        widget.tokenModel.message);
                            orderModelFuture.then((order) {
                              if (order != null) {
                                SendEmailModel sendEmailModel = SendEmailModel(
                                    toEmail: widget.playerModel!.email,
                                    subject: 'BẠN CÓ MỘT YÊU CẦU THUÊ',
                                    body: 'Bạn có một yêu cầu thuê từ ' +
                                        widget.userModel.name +
                                        ' yêu cầu sẽ hết hạn sau 5 phút');
                                Future<bool?> sendEmail = EmailService()
                                    .sendEmail(sendEmailModel,
                                        widget.tokenModel.message);
                                setState(() {
                                  orderModel = order.content;
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
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Vui lòng nhập lời nhắn"),
                            ));
                          }
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Vui lòng chọn tựa game"),
                          ));
                        }
                      }
                    : () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Số dư hiện tại không đủ"),
                        ));
                      },
                height: 50,
                width: 150),
          )),
    );
  }

  Widget buildSingleCheckBox(CheckBoxState cbState) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: const Color(0xff8980FF),
      value: cbState.value,
      onChanged: (value) => setState(() {
        if (cbState.value) {
          listGamesChoosen.remove(cbState.title);
          cbState.value = value!;
        } else {
          listGamesChoosen.add(cbState.title);
          cbState.value = value!;
        }
      }),
      title: Text(
        cbState.title,
        style: GoogleFonts.montserrat(fontSize: 15),
      ),
    );
  }

  Widget createStatus(String status) {
    if (status == 'Hiring') {
      return Text(
        'Đang được thuê',
        style: GoogleFonts.montserrat(fontSize: 18, color: Colors.red),
      );
    }

    if (status == 'Processing') {
      return Text(
        'Đang xử lý',
        style: GoogleFonts.montserrat(fontSize: 18, color: Colors.amber),
      );
    }

    if (status == 'Offline') {
      return Text(
        'Đang offline',
        style: GoogleFonts.montserrat(fontSize: 18, color: Colors.grey),
      );
    }

    if (status == 'Online') {
      return Text(
        'Đang online',
        style: GoogleFonts.montserrat(fontSize: 18, color: Colors.green),
      );
    }

    return Text(
      status,
      style: GoogleFonts.montserrat(fontSize: 18, color: Colors.black),
    );
  }
}
