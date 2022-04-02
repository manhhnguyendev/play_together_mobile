import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/game_of_orders_model.dart';
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/hiring_stage_page.dart';
import 'package:play_together_mobile/pages/home_page.dart';
import 'package:play_together_mobile/widgets/decline_button.dart';
import 'package:play_together_mobile/widgets/second_main_button.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;
import 'package:play_together_mobile/services/order_service.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

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
  int time = 5;
  List listGamesChoosen = [];

  void check() {
    Future<UserModel?> checkStatus =
        UserService().getUserProfile(widget.tokenModel.message);
    checkStatus.then((value) {
      if (value != null) {
        if (value.status.contains('Hiring')) {
          setState(() {
            value = widget.userModel;
            helper.pushInto(
                context,
                HiringPage(
                  tokenModel: widget.tokenModel,
                  userModel: value,
                  orderModel: widget.orderModel,
                ),
                true);
          });
        } else if (value.status.contains('Online')) {
          setState(() {
            value = widget.userModel;
            helper.pushInto(
                context,
                HomePage(
                    tokenModel: widget.tokenModel, userModel: widget.userModel),
                false);
          });
        } else {
          setState(() {
            value = widget.userModel;
          });
        }
      }
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
    check();
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Đang chờ chấp thuận...',
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.normal),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
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
                        backgroundImage:
                            NetworkImage(widget.orderModel!.user!.avatar),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.userModel.name,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    const Text(
                      ' •  •  ',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
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
                    const Text(
                      ' •  • ',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
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
                        backgroundImage:
                            NetworkImage(widget.orderModel!.toUser!.avatar),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.playerModel!.name,
                      style: const TextStyle(fontSize: 18),
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
            padding: const EdgeInsets.fromLTRB(15, 15, 25, 10),
            child: Row(
              children: [
                const Text(
                  'Thời lượng thuê ',
                  style: TextStyle(fontSize: 18),
                ),
                const Spacer(),
                Text(
                  widget.orderModel!.totalTimes.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
                const Text(
                  ' giờ',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 25, 10),
            child: Row(
              children: [
                const Text(
                  'Tổng chi phí ',
                  style: TextStyle(fontSize: 18),
                ),
                const Spacer(),
                Text(
                  widget.orderModel!.totalPrices.toStringAsFixed(0).toVND(),
                  style: const TextStyle(fontSize: 18),
                ),
              ],
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
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(15, 15, 25, 0),
            child: const Text(
              'Tựa game đã chọn: ',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 25, 10),
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
            alignment: Alignment.center,
            child: Column(
              children: [
                const Text(
                  'Thời gian còn lại:',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) => Text(
                    countText,
                    style: const TextStyle(
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
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SecondMainButton(
                  text: 'Nhắn tin', onpress: () {}, height: 50, width: 180),
              DeclineButton(
                  text: 'Hủy thuê',
                  onpress: () {
                    setState(() {
                      Future<bool?> cancelFuture = OrderService()
                          .cancelOrderRequest(
                              widget.orderModel!.id, widget.tokenModel.message);
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
                  },
                  height: 50,
                  width: 180),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGamesChoosenField(GameOfOrdersModel game) => Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.fromLTRB(15, 5, 25, 5),
        child: Text(
          "• " + game.game.name,
          style: const TextStyle(color: Colors.black, fontSize: 15),
        ),
      );
}
