import 'package:flutter/material.dart';
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
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

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

  void check() {
    Future<UserModel?> checkStatus =
        UserService().getUserProfile(widget.tokenModel.message);
    checkStatus.then((value) {
      if (value != null) {
        if (value.status.contains('Online')) {
          setState(() {
            lateUser = value;
            helper.pushInto(
                context,
                EndOrderPage(
                  tokenModel: widget.tokenModel,
                  userModel: widget.userModel!,
                  orderModel: widget.orderModel,
                ),
                true);
          });
        } else {
          setState(() {
            lateUser = value;
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
    check();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: const [],
        centerTitle: true,
        title: const Text(
          'Đang thuê...',
          style: TextStyle(
              fontSize: 18, color: Colors.red, fontWeight: FontWeight.normal),
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
                        widget.orderModel!.user!.id == widget.userModel!.id
                            ? widget.orderModel!.user!.name
                            : widget.orderModel!.toUser!.name,
                        style: const TextStyle(fontSize: 18),
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
                        widget.orderModel!.user!.id == widget.userModel!.id
                            ? widget.orderModel!.toUser!.name
                            : widget.orderModel!.user!.name,
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
            const SizedBox(
              height: 20,
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
                  text: 'Nhắn tin', onpress: () {}, height: 50, width: 183),
              DeclineButton(
                  text: 'Kết thúc',
                  onpress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EndOrderEarlyPage(
                                tokenModel: widget.tokenModel,
                                userModel: widget.userModel!,
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
  }

  Widget buildGamesChoosenField(GameOfOrdersModel game) => Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.fromLTRB(15, 5, 25, 5),
        child: Text(
          "- " + game.game.name,
          style: const TextStyle(color: Colors.black, fontSize: 15),
        ),
      );
}
