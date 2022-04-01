import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/end_order_page.dart';
import 'package:play_together_mobile/pages/rating_comment_player_page.dart';
import 'package:play_together_mobile/services/order_service.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;
import 'package:play_together_mobile/widgets/second_main_button.dart';

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
  var reasonController = TextEditingController();
  UserModel? lateUser;
  bool checkReason = true;

  String reason = "";
  @override
  Widget build(BuildContext context) {
    reasonController.text = "";
    return Scaffold(
      extendBodyBehindAppBar: true,
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
        title: const Text(
          'Kết thúc thuê sớm',
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.normal),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                              NetworkImage(widget.orderModel!.toUser!.avatar),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.orderModel!.toUser!.name,
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
                const Text(
                  "Có việc bận đột xuất",
                  style: TextStyle(fontSize: 15),
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
                const Text(
                  "Thông tin không chính xác",
                  style: TextStyle(fontSize: 15),
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
                const Text(
                  "Ngôn ngữ lăng mạ",
                  style: TextStyle(fontSize: 15),
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
                const Text(
                  "Cố tình AFK",
                  style: TextStyle(fontSize: 15),
                )
              ],
            ),
            Row(
              children: [
                Radio<String>(
                    activeColor: const Color(0xff320444),
                    value: reasonController.text,
                    groupValue: reason,
                    onChanged: (value) {
                      setState(() {
                        reason = value!;
                        checkReason = true;
                      });
                    }),
                const Text(
                  "Lý do khác",
                  style: TextStyle(fontSize: 15),
                )
              ],
            ),
            Visibility(
              visible: checkReason,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                child: TextField(
                  controller: reasonController,
                  style: TextStyle(fontSize: 15),
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
                onpress: () {
                  FinishSoonOrderModel finishSoonModel =
                      FinishSoonOrderModel(message: "set message");
                  Future<bool?> finishFuture = OrderService().finishSoonOrder(
                      widget.orderModel!.id,
                      widget.tokenModel.message,
                      finishSoonModel);
                  finishFuture.then((finish) {
                    if (finish == true) {
                      if (widget.userModel!.id == widget.orderModel!.toUserId) {
                        setState(() {
                          helper.pushInto(
                              context,
                              EndOrderPage(
                                orderModel: widget.orderModel!,
                                tokenModel: widget.tokenModel,
                                userModel: widget.userModel!,
                              ),
                              true);
                        });
                      } else if (widget.userModel!.id ==
                          widget.orderModel!.userId) {
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
                height: 50,
                width: 200),
          )),
    );
  }
}
