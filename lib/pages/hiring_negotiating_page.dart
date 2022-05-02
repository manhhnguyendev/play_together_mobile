import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/game_of_orders_model.dart';
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/hiring_stage_page.dart';
import 'package:play_together_mobile/pages/home_page.dart';
import 'package:play_together_mobile/widgets/decline_button.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;
import 'package:play_together_mobile/services/order_service.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HiringNegotiatingPage extends StatefulWidget {
  final OrderModel? orderModel;
  final UserModel userModel;
  final PlayerModel? playerModel;
  final TokenModel tokenModel;

  const HiringNegotiatingPage(
      {Key? key,
      this.orderModel,
      required this.tokenModel,
      required this.userModel,
      this.playerModel})
      : super(key: key);

  @override
  _HiringNegotiatingPageState createState() => _HiringNegotiatingPageState();
}

class _HiringNegotiatingPageState extends State<HiringNegotiatingPage>
    with TickerProviderStateMixin {
  late AnimationController controller;
  int time = 0;
  List listGamesChoosen = [];
  UserModel? lateUser;
  final today = DateTime.now();

  Future checkStatus() {
    Future<ResponseModel<UserModel>?> getUserStatus =
        UserService().getUserProfile(widget.tokenModel.message);
    getUserStatus.then((value) {
      if (value != null) {
        if (value.content.status.contains('Hiring')) {
          lateUser = value.content;
          Future<ResponseModel<OrderModel>?> getOrderByIdFuture = OrderService()
              .getOrderById(widget.orderModel!.id, widget.tokenModel.message);
          getOrderByIdFuture.then((orderUser) {
            if (orderUser != null) {
              setState(() {
                helper.pushInto(
                    context,
                    HiringPage(
                      tokenModel: widget.tokenModel,
                      userModel: lateUser,
                      orderModel: orderUser.content,
                    ),
                    true);
              });
            }
          });
        } else if (value.content.status.contains('Online')) {
          lateUser = value.content;
          if (!mounted) return;
          setState(() {
            helper.pushInto(
                context,
                HomePage(
                    tokenModel: widget.tokenModel, userModel: widget.userModel),
                true);
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
          CancelOrderModel cancelOrder =
              CancelOrderModel(reason: 'Quá thời gian gửi yêu cầu');
          Future<bool?> cancelFuture = OrderService().cancelOrderRequest(
              widget.orderModel!.id, widget.tokenModel.message, cancelOrder);
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
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  'Đang chờ chấp thuận...',
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
                      padding: const EdgeInsets.fromLTRB(15, 30, 15, 15),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 120,
                                width: 120,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      widget.orderModel!.user!.avatar),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.userModel.name,
                                style: GoogleFonts.montserrat(fontSize: 18),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Text(
                                ' •  •  ',
                                style: GoogleFonts.montserrat(
                                    fontSize: 15, color: Colors.grey),
                              ),
                              Container(
                                alignment: Alignment.topCenter,
                                width: 60,
                                height: 60,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/play_together_logo_no_text.png"),
                                        fit: BoxFit.cover)),
                              ),
                              Text(
                                ' •  • ',
                                style: GoogleFonts.montserrat(
                                    fontSize: 15, color: Colors.grey),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              SizedBox(
                                height: 120,
                                width: 120,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      widget.orderModel!.toUser!.avatar),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.playerModel!.name,
                                style: GoogleFonts.montserrat(fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        children: [
                          Text(
                            'Thời lượng thuê:',
                            style: GoogleFonts.montserrat(fontSize: 18),
                          ),
                          const Spacer(),
                          Text(
                            widget.orderModel!.totalTimes.toString(),
                            style: GoogleFonts.montserrat(fontSize: 18),
                          ),
                          Text(
                            ' giờ',
                            style: GoogleFonts.montserrat(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        children: [
                          Text(
                            'Tổng chi phí:',
                            style: GoogleFonts.montserrat(fontSize: 18),
                          ),
                          const Spacer(),
                          Text(
                            widget.orderModel!.totalPrices
                                .toStringAsFixed(0)
                                .toVND(),
                            style: GoogleFonts.montserrat(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        children: [
                          Text(
                            'Dự kiến kết thúc:',
                            style: GoogleFonts.montserrat(fontSize: 18),
                          ),
                          const Spacer(),
                          Text(
                            intendDate + ", " + intendTime,
                            style: GoogleFonts.montserrat(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                      child: Text(
                        'Tựa game đã chọn:',
                        style: GoogleFonts.montserrat(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Column(
                        children: List.generate(
                            widget.orderModel!.gameOfOrders.isNotEmpty
                                ? widget.orderModel!.gameOfOrders.length
                                : 0,
                            (index) => buildGamesChoosenField(
                                widget.orderModel!.gameOfOrders[index])),
                      ),
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
                            'Yêu cầu sẽ bị hủy sau:',
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
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DeclineButton(
                        text: 'Hủy yêu cầu',
                        onPress: () {
                          createAlertDialog(context);
                        },
                        height: 50,
                        width: 350),
                  ],
                ),
              )));
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
                      "Hủy yêu cầu thuê đơn này?",
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
                          CancelOrderModel cancelOrder =
                              CancelOrderModel(reason: customController.text);
                          Future<bool?> cancelFuture = OrderService()
                              .cancelOrderRequest(widget.orderModel!.id,
                                  widget.tokenModel.message, cancelOrder);
                          cancelFuture.then((cancel) {
                            if (cancel == true) {
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
          style: GoogleFonts.montserrat(fontSize: 15),
        ),
      );
}
