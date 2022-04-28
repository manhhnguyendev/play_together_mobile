import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/game_of_orders_model.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/pages/hiring_stage_page.dart';
import 'package:play_together_mobile/pages/home_page.dart';
import 'package:play_together_mobile/widgets/decline_button.dart';
import 'package:play_together_mobile/widgets/second_main_button.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/services/order_service.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ReceiveRequestPage extends StatefulWidget {
  final OrderModel? orderModel;
  final UserModel userModel;
  final TokenModel tokenModel;

  const ReceiveRequestPage(
      {Key? key,
      this.orderModel,
      required this.userModel,
      required this.tokenModel})
      : super(key: key);

  @override
  State<ReceiveRequestPage> createState() => _ReceiveRequestPageState();
}

class _ReceiveRequestPageState extends State<ReceiveRequestPage>
    with TickerProviderStateMixin {
  List listGamesChoosen = [];
  late AnimationController controller;
  int time = 0;
  UserModel? lateUser;
  final today = DateTime.now();

  Future checkStatus() {
    Future<ResponseModel<UserModel>?> getUserStatus =
        UserService().getUserProfile(widget.tokenModel.message);
    getUserStatus.then((value) {
      if (value != null) {
        if (value.content.status.contains('Online')) {
          lateUser = value.content;
          if (!mounted) return;
          setState(() {
            helper.pushInto(
                context,
                HomePage(tokenModel: widget.tokenModel, userModel: lateUser!),
                false);
          });
        } else {
          if (!mounted) return;
          setState(() {
            lateUser = value.content;
          });
        }
      }
    });
    return getUserStatus;
  }

  @override
  void initState() {
    super.initState();
    time = helper.getDayElapsed(
        DateTime.now().add(const Duration(milliseconds: 400)).toString(),
        widget.orderModel!.processExpired);
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: time),
    );
    controller.reverse(from: controller.value == 0 ? 1.0 : controller.value);
    controller.addListener(() {
      if (controller.value == 0) {
        setState(() {
          RejectOrderModel rejectOrder = RejectOrderModel(
              isAccept: false, reason: 'Quá thời gian chấp thuận');
          Future<bool?> rejectFuture = OrderService().rejectOrderRequest(
              widget.orderModel!.id, widget.tokenModel.message, rejectOrder);
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
        });
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
        ? '${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: checkStatus(),
        builder: (context, snapshot) {
          final intend =
              today.add(Duration(hours: widget.orderModel!.totalTimes));
          String intendDate = DateFormat('dd/MM/yyyy')
              .format(DateTime.parse(intend.toString()));
          String intendTime =
              DateFormat('hh:mm a').format(DateTime.parse(intend.toString()));
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Bạn nhận được yêu cầu thuê',
                style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
              ),
            ),
            body: SingleChildScrollView(
                child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
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
                                      style:
                                          GoogleFonts.montserrat(fontSize: 20),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Thời lượng:',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 18),
                                      ),
                                      const Spacer(),
                                      Text(
                                        widget.orderModel!.totalTimes
                                                .toString() +
                                            ' giờ',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Chi phí:',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 18),
                                      ),
                                      const Spacer(),
                                      Text(
                                        widget.orderModel!.totalPrices
                                            .toStringAsFixed(0)
                                            .toVND(),
                                        style: GoogleFonts.montserrat(
                                            fontSize: 18),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Dự kiến kết thúc:',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 0, 0),
                                        child: Text(
                                          intendDate + ", " + intendTime,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ))
                      ],
                    )),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Text(
                    'Tựa game đã chọn:',
                    style: GoogleFonts.montserrat(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                  child: Column(
                    children: List.generate(
                        widget.orderModel!.gameOfOrders != null
                            ? widget.orderModel!.gameOfOrders.length
                            : 0,
                        (index) => buildGamesChoosenField(
                            widget.orderModel!.gameOfOrders[index])),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Lời nhắn:',
                          style: GoogleFonts.montserrat(fontSize: 18))),
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
                          style: GoogleFonts.montserrat(fontSize: 18),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Container(
                    height: 1,
                    decoration: const BoxDecoration(
                        border: Border(
                      top: BorderSide(
                        color: Colors.grey,
                        width: 0.15,
                      ),
                    )),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        'Yêu cầu sẽ bị hủy sau',
                        style: GoogleFonts.montserrat(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      AnimatedBuilder(
                        animation: controller,
                        builder: (context, child) => Text(
                          countText,
                          style: GoogleFonts.montserrat(
                            fontSize: 40,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
            bottomNavigationBar: BottomAppBar(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DeclineButton(
                        text: 'Từ chối',
                        onPress: () {
                          createAlertDialog(context);
                        },
                        height: 50,
                        width: width * 0.47),
                    SecondMainButton(
                        text: 'Chấp nhận',
                        onPress: () {
                          AcceptOrderModel isAccept =
                              AcceptOrderModel(isAccept: true);
                          Future<bool?> acceptFuture = OrderService()
                              .acceptOrderRequest(widget.orderModel!.id,
                                  widget.tokenModel.message, isAccept);
                          acceptFuture.then((accept) {
                            if (accept == true) {
                              Future<ResponseModel<OrderModel>?>
                                  getOrderByIdFuture = OrderService()
                                      .getOrderById(widget.orderModel!.id,
                                          widget.tokenModel.message);
                              getOrderByIdFuture.then((orderPlayer) {
                                if (orderPlayer != null) {
                                  setState(() {
                                    helper.pushInto(
                                        context,
                                        HiringPage(
                                          tokenModel: widget.tokenModel,
                                          userModel: widget.userModel,
                                          orderModel: orderPlayer.content,
                                        ),
                                        true);
                                  });
                                }
                              });
                            }
                          });
                        },
                        height: 50,
                        width: width * 0.47),
                  ],
                ),
              ),
            ),
          );
        });
  }

  createAlertDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return FutureBuilder(
              future: checkStatus(),
              builder: (context, snapshot) {
                return AlertDialog(
                    title: Text(
                      "Từ chối nhận đơn thuê này?",
                      style: GoogleFonts.montserrat(fontSize: 17),
                    ),
                    content: TextField(
                      style: GoogleFonts.montserrat(),
                      controller: customController,
                    ),
                    actions: <Widget>[
                      MaterialButton(
                        elevation: 5.0,
                        child: Text(
                          'Không',
                          style: GoogleFonts.montserrat(),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      MaterialButton(
                        elevation: 5.0,
                        child: Text(
                          'Có',
                          style: GoogleFonts.montserrat(),
                        ),
                        onPressed: () {
                          RejectOrderModel isReject = RejectOrderModel(
                              isAccept: false, reason: customController.text);
                          Future<bool?> rejectFuture = OrderService()
                              .rejectOrderRequest(widget.orderModel!.id,
                                  widget.tokenModel.message, isReject);
                          rejectFuture.then((accept) {
                            if (accept == true) {
                              setState(() {
                                Navigator.pop(
                                    context,
                                    HomePage(
                                      tokenModel: widget.tokenModel,
                                      userModel: widget.userModel,
                                    ));
                              });
                            }
                          });
                        },
                      )
                    ]);
              });
        });
  }

  Widget buildGamesChoosenField(GameOfOrdersModel game) => Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.fromLTRB(15, 5, 25, 5),
        child: Text(
          "• " + game.game.name,
          style: GoogleFonts.montserrat(color: Colors.black, fontSize: 15),
        ),
      );
}
