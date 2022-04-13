import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:play_together_mobile/models/user_model.dart';

class HistoryHiringDetail extends StatefulWidget {
  final OrderDetailModel orderDetailModel;
  final UserModel userModel;
  final TokenModel tokenModel;

  const HistoryHiringDetail(
      {Key? key,
      required this.orderDetailModel,
      required this.tokenModel,
      required this.userModel})
      : super(key: key);

  @override
  _HistoryHiringDetailState createState() => _HistoryHiringDetailState();
}

class _HistoryHiringDetailState extends State<HistoryHiringDetail> {
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi');
  bool checkEndEarly = true;
  bool checkRating = true;
  bool checkFinalPrice = true;
  bool checkReason = true;
  int rate = 5;
  @override
  Widget build(BuildContext context) {
    bool checkExpired =
        widget.orderDetailModel.timeStart == "0001-01-01T00:00:00";
    String dateStart = DateFormat('dd/MM/yyyy')
        .format(DateTime.parse(widget.orderDetailModel.timeStart));
    String timeStart = DateFormat('hh:mm a')
        .format(DateTime.parse(widget.orderDetailModel.timeStart));
    String dateFinish = DateFormat('dd/MM/yyyy')
        .format(DateTime.parse(widget.orderDetailModel.timeFinish));
    String timeFinish = DateFormat('hh:mm a')
        .format(DateTime.parse(widget.orderDetailModel.timeFinish));
    String dateExpired = DateFormat('dd/MM/yyyy')
        .format(DateTime.parse(widget.orderDetailModel.processExpired));
    String timeExpired = DateFormat('hh:mm a')
        .format(DateTime.parse(widget.orderDetailModel.processExpired));

    if (widget.orderDetailModel.status == "Hirer Finish Soon") {
      checkEndEarly = true;
    } else if (widget.orderDetailModel.status == "Player Finish Soon") {
      checkEndEarly = true;
    } else if (widget.orderDetailModel.status == "Reject") {
      checkEndEarly = true;
    } else if (widget.orderDetailModel.status == "OverTime") {
      checkEndEarly = true;
    } else if (widget.orderDetailModel.status == "Cancel") {
      checkEndEarly = true;
    } else {
      checkEndEarly = false;
    }

    if (widget.orderDetailModel.status == "Reject") {
      checkFinalPrice = true;
    } else if (widget.orderDetailModel.status == "OverTime") {
      checkFinalPrice = true;
    } else if (widget.orderDetailModel.status == "Cancel") {
      checkFinalPrice = true;
    } else {
      checkFinalPrice = false;
    }

    if (widget.orderDetailModel.reason!.isNotEmpty) {
      checkReason = true;
    } else if (widget.orderDetailModel.reason! != null) {
      checkReason = true;
    } else if (widget.orderDetailModel.reason! != "") {
      checkReason = true;
    } else {
      checkReason = false;
    }

    if (widget.orderDetailModel.ratings!.isNotEmpty) {
      checkRating = true;
    } else {
      checkRating = false;
    }

    var _controller = TextEditingController();
    _controller.text = widget.orderDetailModel.ratings!.isNotEmpty
        ? widget.orderDetailModel.ratings![0].comment
        : "";

    var _reasonController = TextEditingController();
    _reasonController.text = widget.orderDetailModel.reason != null
        ? widget.orderDetailModel.reason!
        : "";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
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
          centerTitle: true,
          title: const Text(
            'Chi tiết lượt thuê',
            style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Container(
                  alignment: Alignment.center,
                  child: createStatus(widget.orderDetailModel.status)),
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
                              backgroundImage: NetworkImage(widget
                                          .orderDetailModel.user!.id ==
                                      widget.userModel.id
                                  ? widget.orderDetailModel.user!.avatar
                                  : widget.orderDetailModel.toUser!.avatar)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.orderDetailModel.user!.id ==
                                  widget.userModel.id
                              ? widget.orderDetailModel.user!.name
                              : widget.orderDetailModel.toUser!.name,
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
                                widget.orderDetailModel.user!.id ==
                                        widget.userModel.id
                                    ? widget.orderDetailModel.toUser!.avatar
                                    : widget.orderDetailModel.user!.avatar),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.orderDetailModel.user!.id ==
                                  widget.userModel.id
                              ? widget.orderDetailModel.toUser!.name
                              : widget.orderDetailModel.user!.name,
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
                      'Thời lượng thuê: ',
                      style: TextStyle(fontSize: 15),
                    ),
                    const Spacer(),
                    Text(
                      widget.orderDetailModel.totalTimes.toString(),
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
                      'Tổng chi phí: ',
                      style: TextStyle(fontSize: 15),
                    ),
                    const Spacer(),
                    Text(
                      widget.orderDetailModel.totalPrices
                          .toStringAsFixed(0)
                          .toVND(),
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: !checkFinalPrice,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 25, 10),
                  child: Row(
                    children: [
                      const Text(
                        'Tổng chi phí cuối cùng: ',
                        style: TextStyle(fontSize: 15),
                      ),
                      const Spacer(),
                      Text(
                        widget.orderDetailModel.finalPrices
                            .toStringAsFixed(0)
                            .toVND(),
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
                visible: checkReason,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(15, 15, 25, 0),
                  child: const Text(
                    'Lý do :',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
              Visibility(
                visible: checkReason,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: TextField(
                    controller: _reasonController,
                    enabled: false,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: checkRating,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 25, 10),
                  child: Row(
                    children: [
                      Text(
                        'Đánh giá: ',
                        style: TextStyle(fontSize: 15),
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      Text(
                        widget.orderDetailModel.ratings!.isNotEmpty
                            ? widget.orderDetailModel.ratings![0].rate
                                .toString()
                            : "",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: checkRating,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: Container(
                    height: 100,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: TextField(
                      controller: _controller,
                      enabled: false,
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

    if (status == 'Complete') {
      return const Text(
        'Hoàn thành',
        style: TextStyle(fontSize: 15, color: Colors.green),
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
}
