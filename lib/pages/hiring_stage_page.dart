import 'package:flutter/material.dart';
import 'package:play_together_mobile/pages/rating_and_comment_page.dart';
import 'package:play_together_mobile/pages/rating_comment_player_page.dart';
import 'package:play_together_mobile/widgets/decline_button.dart';
import 'package:play_together_mobile/widgets/second_main_button.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

import '../models/game_of_orders_model.dart';
import '../models/order_model.dart';
import '../models/token_model.dart';
import '../models/user_model.dart';
import '../services/order_service.dart';
import '../services/user_service.dart';
import 'home_page.dart';

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
  String profileLink = "assets/images/defaultprofile.png";
  String profileLink2 = "assets/images/defaultprofile.png";
  List listGamesChoosen = ['Liên Minh', 'CSGO'];
  late AnimationController controller;
  int hour = 2;
  double progress = 1.0;
  createAlertDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Kết thúc sớm đơn thuê này ?"),
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
                    Navigator.pop(context);
                    FinishSoonOrderModel finishSoonModel =
                        FinishSoonOrderModel(message: "set message");
                    Future<bool?> finishFuture = OrderService().finishSoonOrder(
                        widget.orderModel!.id,
                        widget.tokenModel.message,
                        finishSoonModel);
                    finishFuture.then((finish) {
                      if (finish == true) {
                        if (widget.userModel!.id ==
                            widget.orderModel!.toUserId) {
                          setState(() {
                            print("a \n a \n a \n a \n a \n a \n a \n " +
                                "Kết thúc về home nè!!!!");

                            helper.pushInto(
                                context,
                                HomePage(
                                  tokenModel: widget.tokenModel,
                                  userModel: widget.userModel!,
                                ),
                                true);
                          });
                        } else if (widget.userModel!.id ==
                            widget.orderModel!.userId) {
                          print("a \n a \n a \n a \n a \n a \n a \n " +
                              "Đến màn Rating nè!!!!");
                          helper.pushInto(
                              context,
                              RatingAndCommentPage(
                                tokenModel: widget.tokenModel,
                                userModel: lateUser!,
                                orderModel: widget.orderModel,
                              ),
                              true);
                        }
                      }
                    });
                  },
                ) // MaterialButton
                // <Widget>[]
              ] // AlertDialog
              );
        });
  }

  UserModel? lateUser;
  void check() {
    Future<UserModel?> checkStatus =
        UserService().getUserProfile(widget.tokenModel.message);
    checkStatus.then((value) {
      if (value != null) {
        print('Màn hiring status' + value.status);
        if (value.status.contains('Online')) {
          //Nếu là user chuyển về màn rating
          if (widget.orderModel!.userId == widget.userModel!.id) {
            setState(() {
              lateUser = value;
              //sleep(Duration(milliseconds: 30));
              helper.pushInto(
                  context,
                  RatingAndCommentPage(
                    tokenModel: widget.tokenModel,
                    userModel: lateUser!,
                    orderModel: widget.orderModel,
                  ),
                  true);
            });
          }
          //nếu là player đưa về màn history detail page
          //tạm thời đang là về home
          else {
            setState(() {
              lateUser = value;
              helper.pushInto(
                  context,
                  HomePage(
                    tokenModel: widget.tokenModel,
                    userModel: widget.userModel!,
                  ),
                  true);
            });
          }
        } else
          setState(() {
            lateUser = value;
          });
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
          MaterialPageRoute(builder: (context) => RatingCommentPage()),
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
          actions: [],
          centerTitle: true,
          title: Text(
            'Đang thuê...',
            style: TextStyle(
                fontSize: 18, color: Colors.red, fontWeight: FontWeight.normal),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Container(
              //   alignment: Alignment.center,
              //   child: Text(
              //     'Đang thuê',
              //     style: TextStyle(fontSize: 20, color: Colors.red),
              //   ),
              // ),
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
                                NetworkImage(widget.userModel!.avatar),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.userModel!.name,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Spacer(),
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
                    Spacer(),
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
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.orderModel!.user!.id == widget.userModel!.id
                              ? widget.orderModel!.toUser!.name
                              : widget.orderModel!.user!.name,
                          style: TextStyle(fontSize: 18),
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
                  decoration: BoxDecoration(
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
                    Text(
                      'Thời lượng thuê ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Spacer(),
                    Text(
                      widget.orderModel!.totalTimes.toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
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
                    Text(
                      'Tổng chi phí ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Spacer(),
                    Text(
                      widget.orderModel!.totalPrices.toString().toVND(),
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(
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
                child: Text(
                  'Tựa game đã chọn: ',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 25, 10),
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
              SizedBox(
                height: 20,
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(
                    border: Border(
                  top: BorderSide(
                    color: Colors.grey,
                    width: 0.15,
                  ),
                )),
              ),
              SizedBox(
                height: 40,
              ),
              SecondMainButton(
                  text: 'Nhắn tin', onpress: () {}, height: 50, width: 250),
              SizedBox(
                height: 5,
              ),
              DeclineButton(
                  text: 'Kết thúc sớm',
                  onpress: () {
                    createAlertDialog(context);
                  },
                  height: 50,
                  width: 250),
            ],
          ),
        ));
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
