import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/game_of_orders_model.dart';
import 'package:play_together_mobile/pages/hiring_stage_page.dart';
import 'package:play_together_mobile/pages/history_page.dart';
import 'package:play_together_mobile/widgets/decline_button.dart';
import 'package:play_together_mobile/widgets/second_main_button.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;

import '../models/order_model.dart';
import '../models/token_model.dart';
import '../models/user_model.dart';
import '../services/order_service.dart';
import '../services/user_service.dart';
import 'home_page.dart';

class ReceiveRequestPage extends StatefulWidget {
  final OrderModel? orderModel;
  final UserModel userModel;
  final TokenModel tokenModel;

  const ReceiveRequestPage(
      {Key? key,
      this.orderModel,
      required this.userModel,
      //required this.fromUserModel,
      required this.tokenModel})
      : super(key: key);
  @override
  State<ReceiveRequestPage> createState() => _ReceiveRequestPageState();
}

class _ReceiveRequestPageState extends State<ReceiveRequestPage>
    with TickerProviderStateMixin {
  String firstMessage = 'Alo alo?';
  String profileLink = "assets/images/defaultprofile.png";
  List listGamesChoosen = ['Liên Minh', 'CSGO'];
  late AnimationController controller;
  int time = 5; //5 mins
  double progress = 1.0;
  bool isPlaying = false;
  void check() {
    Future<UserModel?> checkStatus =
        UserService().getUserProfile(widget.tokenModel.message);
    checkStatus.then((value) {
      if (value != null) {
        print('check status nè ');
        if (value.status.contains('Online'))
          setState(() {
            value = widget.userModel;
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (BuildContext context) => HomePage(
                    tokenModel: widget.tokenModel, userModel: widget.userModel),
              ),
              (route) => false,
            );
          });
        else
          setState(() {
            value = widget.userModel;
          });
      }
    });
  }

  createAlertDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();
    check();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Từ chối nhận đơn thuê này?"),
              content: TextField(
                controller: customController,
              ), // TextField
              actions: <Widget>[
                MaterialButton(
                  elevation: 5.0,
                  child: Text('Không'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                MaterialButton(
                  elevation: 5.0,
                  child: Text('Có'),
                  onPressed: () {
                    setState(() {
                      Future<bool?> cancelFuture = OrderService()
                          .cancelOrderRequest(
                              widget.orderModel!.id, widget.tokenModel.message);
                      cancelFuture.then((check) {
                        if (check == true) {
                          setState(() {
                            print("Cancel về Home nè");
                            helper.pushInto(
                                context,
                                HistoryPage(
                                  tokenModel: widget.tokenModel,
                                  userModel: widget.userModel,
                                ),
                                true);
                          });
                        }
                      });
                    });
                  },
                ) // MaterialButton
                // <Widget>[]
              ] // AlertDialog
              );
        });
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: time * 60),
    );
    controller.reverse(from: controller.value == 0 ? 1.0 : controller.value);
    controller.addListener(() {
      if (controller.value == 0) {
        // luu lai status order
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String get countText {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${controller.duration!.inHours}:${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [],
        centerTitle: true,
        title: Text(
          'Yêu cầu nhận được',
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.normal),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 120,
                      width: 120,
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(widget.orderModel!.user!.avatar),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 15, 0),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.orderModel!.user!.name,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Thời lượng: ',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Spacer(),
                                Text(
                                  widget.orderModel!.totalTimes.toString() +
                                      ' giờ',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Chi phí: ',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Spacer(),
                                Text(
                                  widget.orderModel!.totalPrices.toString() +
                                      'đ',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ],
                        ),
                      ))
                ],
              )),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(15, 15, 25, 0),
            child: Text(
              'Tựa game đã chọn: ',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 25, 15),
            child: Column(
              children: List.generate(
                  widget.orderModel!.gameOfOrderModel != null
                      ? widget.orderModel!.gameOfOrderModel.length
                      : 0,
                  (index) => buildGamesChoosenField(
                      widget.orderModel!.gameOfOrderModel[index])),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  'Thời gian còn lại:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) => Text(
                      countText,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
            child: Container(
                alignment: Alignment.centerLeft,
                child: Text('Lời nhắn:', style: TextStyle(fontSize: 18))),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
            child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(border: Border.all()),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    widget.orderModel!.message,
                    style: TextStyle(fontSize: 18),
                  ),
                )),
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Nhắn tin ',
                      style: TextStyle(
                          fontSize: 18, decoration: TextDecoration.underline)),
                  Icon(
                    Icons.message_outlined,
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
          Divider(
            thickness: 1,
            indent: 15,
            endIndent: 15,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Column(
              children: [
                SecondMainButton(
                    text: 'Chấp nhận',
                    onpress: () {
                      AcceptOrderModel isAccept =
                          AcceptOrderModel(isAccept: true);
                      Future<bool?> acceptFuture = OrderService()
                          .acceptOrderRequest(widget.orderModel!.id,
                              widget.tokenModel.message, isAccept);
                      acceptFuture.then((accept) {
                        if (accept == true) {
                          setState(() {
                            print("a \n a \n a \n a \n a \n a \n a \n " +
                                "Đồng ý rồi nè!!!!");
                            helper.pushInto(
                                context,
                                HiringPage(
                                  tokenModel: widget.tokenModel,
                                  userModel: widget.userModel,
                                  orderModel: widget.orderModel,
                                ),
                                true);
                          });
                        }
                      });
                    },
                    height: 50,
                    width: 300),
                DeclineButton(
                    text: 'Từ chối',
                    onpress: () {
                      createAlertDialog(context);
                    },
                    height: 50,
                    width: 300)
              ],
            ),
          )
        ],
      )),
    );
  }

  Widget buildGamesChoosenField(GameOfOrdersModel game) => Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.fromLTRB(15, 5, 25, 5),
        child: Text(
          "- " + game.game.name,
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      );
}
