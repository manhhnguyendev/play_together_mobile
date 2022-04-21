import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/end_order_page.dart';
import 'package:play_together_mobile/services/order_service.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;
import 'package:play_together_mobile/services/user_service.dart';
import 'package:play_together_mobile/widgets/second_main_button.dart';
import 'package:google_fonts/google_fonts.dart';

class EndOrderEarlyPage extends StatefulWidget {
  final OrderModel? orderModel;
  final UserModel? userModel;
  final PlayerModel? playerModel;
  final TokenModel tokenModel;

  const EndOrderEarlyPage(
      {Key? key,
      this.orderModel,
      this.userModel,
      this.playerModel,
      required this.tokenModel})
      : super(key: key);

  @override
  State<EndOrderEarlyPage> createState() => _EndOrderEarlyPageState();
}

class _EndOrderEarlyPageState extends State<EndOrderEarlyPage> {
  final _controller = TextEditingController();
  UserModel? lateUser;
  OrderModel? lateOrder;
  bool checkReason = true;
  String reason = "";

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
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkStatus(),
      builder: (context, snapshot) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: FlatButton(
                child: const Icon(
                  Icons.arrow_back_ios,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            title: Text(
              'Kết thúc thuê sớm',
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
                            widget.orderModel!.user!.id == widget.userModel!.id
                                ? widget.orderModel!.toUser!.name
                                : widget.orderModel!.user!.name,
                            style: GoogleFonts.montserrat(fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Radio<String>(
                        activeColor: const Color(0xff320444),
                        value: "Có việc bận đột xuất",
                        groupValue: reason,
                        onChanged: (value) {
                          setState(() {
                            reason = value!;
                            checkReason = false;
                          });
                        }),
                    Text(
                      "Có việc bận đột xuất",
                      style: GoogleFonts.montserrat(fontSize: 15),
                    )
                  ],
                ),
                Row(
                  children: [
                    Radio<String>(
                        activeColor: const Color(0xff320444),
                        value: "Thông tin không chính xác",
                        groupValue: reason,
                        onChanged: (value) {
                          setState(() {
                            reason = value!;
                            checkReason = false;
                          });
                        }),
                    Text(
                      "Thông tin không chính xác",
                      style: GoogleFonts.montserrat(fontSize: 15),
                    )
                  ],
                ),
                Row(
                  children: [
                    Radio<String>(
                        activeColor: const Color(0xff320444),
                        value: "Ngôn ngữ lăng mạ",
                        groupValue: reason,
                        onChanged: (value) {
                          setState(() {
                            reason = value!;
                            checkReason = false;
                          });
                        }),
                    Text(
                      "Ngôn ngữ lăng mạ",
                      style: GoogleFonts.montserrat(fontSize: 15),
                    )
                  ],
                ),
                Row(
                  children: [
                    Radio<String>(
                        activeColor: const Color(0xff320444),
                        value: "Cố tình AFK",
                        groupValue: reason,
                        onChanged: (value) {
                          setState(() {
                            reason = value!;
                            checkReason = false;
                          });
                        }),
                    Text(
                      "Cố tình AFK",
                      style: GoogleFonts.montserrat(fontSize: 15),
                    )
                  ],
                ),
                Row(
                  children: [
                    Radio<String>(
                        activeColor: const Color(0xff320444),
                        value: _controller.text,
                        groupValue: reason,
                        onChanged: (value) {
                          setState(() {
                            reason = value!;
                            checkReason = true;
                          });
                        }),
                    Text(
                      "Lý do khác",
                      style: GoogleFonts.montserrat(fontSize: 15),
                    )
                  ],
                ),
                Visibility(
                  visible: checkReason,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                    child: TextField(
                      controller: _controller,
                      onChanged: (value) {
                        setState(() {
                          reason = _controller.text;
                          checkReason = true;
                        });
                      },
                      style: GoogleFonts.montserrat(fontSize: 15),
                    ),
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBar(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: SecondMainButton(
                    text: 'Kết thúc',
                    onPress: () {
                      FinishSoonOrderModel finishSoonModel =
                          FinishSoonOrderModel(reason: reason);
                      Future<bool?> finishFuture = OrderService()
                          .finishSoonOrder(widget.orderModel!.id,
                              widget.tokenModel.message, finishSoonModel);
                      finishFuture.then((finish) {
                        if (finish == true) {
                          Future<ResponseModel<OrderModel>?> checkStatusOrder =
                              OrderService().getOrderById(widget.orderModel!.id,
                                  widget.tokenModel.message);
                          checkStatusOrder.then((order) {
                            if (order != null) {
                              setState(() {
                                lateOrder = order.content;
                                helper.pushInto(
                                    context,
                                    EndOrderPage(
                                      tokenModel: widget.tokenModel,
                                      userModel: lateUser ?? widget.userModel,
                                      orderModel:
                                          lateOrder ?? widget.orderModel,
                                    ),
                                    true);
                              });
                            }
                          });
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                "Bạn chỉ có thể kết thúc sau khi hoàn thành 1/10 thời gian thuê"),
                          ));
                        }
                      });
                    },
                    height: 50,
                    width: 200),
              )),
        );
      },
    );
  }
}
