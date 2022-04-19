import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/pages/chat_page.dart';
import 'package:play_together_mobile/pages/end_order_early_page.dart';
import 'package:play_together_mobile/pages/end_order_page.dart';
import 'package:play_together_mobile/widgets/decline_button.dart';
import 'package:play_together_mobile/widgets/second_main_button.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;
import 'package:play_together_mobile/models/game_of_orders_model.dart';
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:play_together_mobile/services/order_service.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HiringPage extends StatefulWidget {
  final OrderModel? orderModel;
  final UserModel? userModel;
  final TokenModel tokenModel;

  const HiringPage(
      {Key? key,
      this.orderModel,
      required this.userModel,
      required this.tokenModel})
      : super(key: key);

  @override
  _HiringPageState createState() => _HiringPageState();
}

class _HiringPageState extends State<HiringPage> with TickerProviderStateMixin {
  List listGamesChoosen = [];
  late AnimationController controller;
  int hour = 2;
  double progress = 1.0;
  UserModel? lateUser;
  OrderModel? lateOrder;
  final today = DateTime.now();

  Future checkStatus() {
    Future<ResponseModel<UserModel>?> getUserStatus =
        UserService().getUserProfile(widget.tokenModel.message);
    getUserStatus.then((value) {
      if (value != null) {
        if (value.content.status.contains('Online')) {
          Future<ResponseModel<OrderModel>?> checkStatusOrder = OrderService()
              .getOrderById(widget.orderModel!.id, widget.tokenModel.message);
          checkStatusOrder.then((order) {
            if (order != null) {
              lateOrder = order.content;
              lateUser = value.content;
              setState(() {
                helper.pushInto(
                    context,
                    EndOrderPage(
                      tokenModel: widget.tokenModel,
                      userModel: lateUser ?? widget.userModel,
                      orderModel: lateOrder ?? widget.orderModel,
                    ),
                    true);
              });
            }
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
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.orderModel!.totalTimes * 60 * 60),
    );
    controller.reverse(from: controller.value == 0 ? 1.0 : controller.value);
    controller.addListener(() {
      if (controller.value == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EndOrderPage(
                    tokenModel: widget.tokenModel,
                    userModel: widget.userModel!,
                    orderModel: widget.orderModel,
                  )),
        );
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

  bool isPlaying = false;
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
                'Đang thuê...',
                style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: Colors.red,
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
                                    widget.orderModel!.user!.id ==
                                            widget.userModel!.id
                                        ? widget.orderModel!.user!.avatar
                                        : widget.orderModel!.toUser!.avatar),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.orderModel!.user!.id ==
                                      widget.userModel!.id
                                  ? widget.orderModel!.user!.name
                                  : widget.orderModel!.toUser!.name,
                              style: GoogleFonts.montserrat(fontSize: 18),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
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
                                    widget.orderModel!.user!.id ==
                                            widget.userModel!.id
                                        ? widget.orderModel!.toUser!.avatar
                                        : widget.orderModel!.user!.avatar),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.orderModel!.user!.id ==
                                      widget.userModel!.id
                                  ? widget.orderModel!.toUser!.name
                                  : widget.orderModel!.user!.name,
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
                          'Thời lượng thuê ',
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
                          'Tổng chi phí ',
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
                          'Dự kiến kết thúc',
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
                      'Tựa game đã chọn',
                      style: GoogleFonts.montserrat(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Column(
                      children: List.generate(
                          widget.orderModel!.gameOfOrders != null
                              ? widget.orderModel!.gameOfOrders.length
                              : 0,
                          (index) => buildGamesChoosenField(
                              widget.orderModel!.gameOfOrders[index])),
                    ),
                  ),
                  Container(
                    height: 1,
                    decoration: const BoxDecoration(
                        border: Border(
                      top: BorderSide(
                        color: Colors.grey,
                        width: 0.15,
                      ),
                    )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          'Thời gian còn lại',
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
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SecondMainButton(
                        text: 'Nhắn tin',
                        onpress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatPage(
                                  tokenModel: widget.tokenModel,
                                  userModel: widget.userModel!,
                                  orderModel: widget.orderModel!,
                                ),
                              ));
                        },
                        height: 50,
                        width: 183),
                    DeclineButton(
                        text: 'Kết thúc',
                        onpress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EndOrderEarlyPage(
                                      tokenModel: widget.tokenModel,
                                      userModel: lateUser!,
                                      orderModel: widget.orderModel,
                                    )),
                          );
                        },
                        height: 50,
                        width: 183),
                  ],
                ),
              ),
            ),
          );
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
