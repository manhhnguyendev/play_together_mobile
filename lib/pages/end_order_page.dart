import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/game_of_orders_model.dart';
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/history_page.dart';
import 'package:play_together_mobile/pages/rating_comment_player_page.dart';
import 'package:play_together_mobile/pages/report_page.dart';
import 'package:play_together_mobile/widgets/second_main_button.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:intl/intl.dart';

class EndOrderPage extends StatefulWidget {
  final UserModel? userModel;
  final OrderModel? orderModel;
  final TokenModel tokenModel;

  const EndOrderPage(
      {Key? key, this.userModel, this.orderModel, required this.tokenModel})
      : super(key: key);

  @override
  State<EndOrderPage> createState() => _EndOrderPageState();
}

class _EndOrderPageState extends State<EndOrderPage> {
  late bool checkEndEarly;

  @override
  Widget build(BuildContext context) {
    bool checkExpired =
        widget.orderModel?.processExpired != "0001-01-01T00:00:00";
    String dateStart = DateFormat('dd/MM/yyyy')
        .format(DateTime.parse(widget.orderModel!.timeStart));
    String timeStart = DateFormat('hh:mm a')
        .format(DateTime.parse(widget.orderModel!.timeStart));
    String dateFinish = DateFormat('dd/MM/yyyy')
        .format(DateTime.parse(widget.orderModel!.timeFinish));
    String timeFinish = DateFormat('hh:mm a')
        .format(DateTime.parse(widget.orderModel!.timeFinish));
    String dateExpired = DateFormat('dd/MM/yyyy')
        .format(DateTime.parse(widget.orderModel!.processExpired));
    String timeExpired = DateFormat('hh:mm a')
        .format(DateTime.parse(widget.orderModel!.processExpired));
    checkEndEarly = true;
    var _reasonController = TextEditingController();
    _reasonController.text =
        widget.orderModel!.reason != null ? widget.orderModel!.reason! : "";
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReportPage(
                              orderModel: widget.orderModel,
                              tokenModel: widget.tokenModel,
                              userModel: widget.userModel!)),
                    );
                  },
                  icon: const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.black,
                  )),
            ),
          ],
          centerTitle: true,
          title: const Text(
            'Chi tiết thuê',
            style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(),
            child: Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    child: createStatus("Complete")),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
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
                                        : widget.orderModel!.toUser!.avatar)),
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
                                        : widget.orderModel!.user!.avatar)),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 25, 10),
                  child: Row(
                    children: [
                      const Text(
                        'Thời lượng thuê ',
                        style: TextStyle(fontSize: 15),
                      ),
                      const Spacer(),
                      Text(
                        widget.orderModel!.totalTimes.toString(),
                        style: const TextStyle(fontSize: 15),
                      ),
                      const Text(
                        ' giờ',
                        style: TextStyle(fontSize: 15),
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
                        style: TextStyle(fontSize: 15),
                      ),
                      const Spacer(),
                      Text(
                        (widget.orderModel!.totalPrices
                            .toStringAsFixed(0)
                            .toVND()),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(15, 15, 25, 10),
                  child: const Text(
                    'Tựa game đã chọn: ',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 25, 10),
                  child: Column(
                    children: List.generate(
                        widget.orderModel!.gameOfOrders != null
                            ? widget.orderModel!.gameOfOrders.length
                            : 0,
                        (index) => buildGamesChoosenField(
                            widget.orderModel!.gameOfOrders[index])),
                  ),
                ),
                Visibility(
                  visible: !checkExpired,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 25, 10),
                    child: Row(
                      children: [
                        const Text(
                          'Thời gian bắt đầu',
                          style: TextStyle(fontSize: 15),
                        ),
                        const Spacer(),
                        Text(
                          dateStart + ", " + timeStart,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: !checkExpired,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 25, 10),
                    child: Row(
                      children: [
                        const Text(
                          'Thời gian kết thúc',
                          style: TextStyle(fontSize: 15),
                        ),
                        const Spacer(),
                        Text(
                          dateFinish + ", " + timeFinish,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: checkExpired,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 25, 10),
                    child: Row(
                      children: [
                        const Text(
                          'Thời gian: ',
                          style: TextStyle(fontSize: 15),
                        ),
                        const Spacer(),
                        Text(
                          dateExpired + ", " + timeExpired,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: checkEndEarly,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(15, 10, 25, 10),
                    child: const Text(
                      'Lý do kết thúc sớm:',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Visibility(
                  visible: checkEndEarly,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 25, 10),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: TextField(
                        controller: _reasonController,
                        enabled: false,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10.0),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SecondMainButton(
                    text: 'Kết thúc',
                    onpress: () {
                      if (widget.userModel!.id == widget.orderModel!.userId) {
                        setState(() {
                          helper.pushInto(
                              context,
                              RatingAndCommentPage(
                                orderModel: widget.orderModel,
                                tokenModel: widget.tokenModel,
                                userModel: widget.userModel!,
                              ),
                              true);
                        });
                      } else if (widget.userModel!.id ==
                          widget.orderModel!.toUserId) {
                        setState(() {
                          helper.pushInto(
                              context,
                              HistoryPage(
                                tokenModel: widget.tokenModel,
                                userModel: widget.userModel!,
                              ),
                              true);
                        });
                      }
                    },
                    height: 50,
                    width: 200),
              ],
            ),
          ),
        ));
  }

  Widget createStatus(String status) {
    if (status == 'Processing') {
      return const Text(
        'Đang thuê',
        style: TextStyle(fontSize: 15, color: Colors.red),
      );
    }

    if (status == 'Starting') {
      return const Text(
        'Đang thương lượng',
        style: TextStyle(fontSize: 15, color: Colors.yellow),
      );
    }

    if (status == 'Finish') {
      return const Text(
        'Hoàn thành',
        style: TextStyle(fontSize: 15, color: Colors.green),
      );
    }

    if (status == 'Cancel') {
      return const Text(
        'Hủy yêu cầu',
        style: TextStyle(fontSize: 15, color: Colors.grey),
      );
    }

    if (status == 'Hirer Finish Soon') {
      return const Text(
        'Kết thúc sớm',
        style: TextStyle(fontSize: 15, color: Colors.green),
      );
    }

    if (status == 'Player Finish Soon') {
      return const Text(
        'Kết thúc sớm',
        style: TextStyle(fontSize: 15, color: Colors.green),
      );
    }

    if (status == 'OverTime') {
      return const Text(
        'Quá giờ chấp nhận',
        style: TextStyle(fontSize: 15, color: Colors.grey),
      );
    }

    if (status == 'Reject') {
      return const Text(
        'Bị từ chối',
        style: TextStyle(fontSize: 15, color: Colors.grey),
      );
    }

    if (status == 'Interrupt') {
      return const Text(
        'Người dùng bị khóa',
        style: TextStyle(fontSize: 15, color: Colors.grey),
      );
    }

    return Text(
      status,
      style: const TextStyle(fontSize: 15, color: Colors.black),
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
