import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/models/detail_hiring_model.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

class HistoryHiringDetail extends StatefulWidget {
  final DetailHiringModel detailHiringModel;

  const HistoryHiringDetail({Key? key, required this.detailHiringModel})
      : super(key: key);

  @override
  _HistoryHiringDetailState createState() => _HistoryHiringDetailState();
}

class _HistoryHiringDetailState extends State<HistoryHiringDetail> {
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi');
  late bool checkEndEarly;
  @override
  Widget build(BuildContext context) {
    // String date = DateFormat('dd/MM/yyyy')
    //     .format(DateTime.parse(widget.orderModel!.timeStart));
    // String startTime = DateFormat('hh:mm a')
    //     .format(DateTime.parse(widget.orderModel!.timeStart));
    // String endDate = DateFormat('dd/MM/yyyy')
    //     .format(DateTime.parse(widget.orderModel!.timeFinish));
    // String endTime = DateFormat('hh:mm a')
    //     .format(DateTime.parse(widget.orderModel!.timeFinish));
    checkEndEarly = true;
    var _controller = TextEditingController();
    // _controller.text = widget.orderModel!.message;
    _controller.text = "aaaaa"; //comment
    var _reasonController = TextEditingController();
    // _controller.text = widget.orderModel!.message;
    _reasonController.text = "Tôi bận";
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: FlatButton(
              child: Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          centerTitle: true,
          title: Text(
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
                  child: createStatus(widget.detailHiringModel.status)),
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
                            backgroundImage: AssetImage(
                                widget.detailHiringModel.hirerAvatar),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.detailHiringModel.hirerAvatar,
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
                            backgroundImage: AssetImage(
                                widget.detailHiringModel.playerAvatar),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.detailHiringModel.playerName,
                          style: TextStyle(fontSize: 18),
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
                      style: TextStyle(fontSize: 15),
                    ),
                    Spacer(),
                    Text(
                      widget.detailHiringModel.totalHour.toString(),
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
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
                    Text(
                      'Tổng chi phí ',
                      style: TextStyle(fontSize: 15),
                    ),
                    Spacer(),
                    Text(
                      widget.detailHiringModel.totalPrice.toString().toVND(),
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 25, 10),
                child: Row(
                  children: [
                    Text(
                      'Thời gian bắt đầu',
                      style: TextStyle(fontSize: 15),
                    ),
                    Spacer(),
                    Text(
                      // widget.orderModel!.timeFinish +
                      //     ", " +
                      //     widget.orderModel!.timeStart,
                      // date + ", " + startTime,
                      "1212121212",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 25, 10),
                child: Row(
                  children: [
                    Text(
                      'Thời gian kết thúc',
                      style: TextStyle(fontSize: 15),
                    ),
                    Spacer(),
                    Text(
                      // widget.orderModel!.timeFinish +
                      //     ", " +
                      //     widget.orderModel!.timeStart,
                      "121212121212",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: checkEndEarly,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(15, 15, 25, 0),
                  child: Text(
                    'Lý do kết thúc sớm:',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Visibility(
                visible: checkEndEarly,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: Container(
                    height: 250,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: TextField(
                      controller: _reasonController,
                      enabled: false,
                      decoration: const InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                thickness: 1,
                indent: 15,
                endIndent: 15,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 25, 10),
                child: Row(
                  children: [
                    Text(
                      'Đánh giá: ',
                      style: TextStyle(fontSize: 15),
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Text(
                      "5",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: Container(
                  height: 250,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: TextField(
                    controller: _controller,
                    enabled: false,
                    decoration: const InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 10.0),
                      border: InputBorder.none,
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
      return Text(
        'Đang thuê',
        style: TextStyle(fontSize: 15, color: Colors.yellow),
      );
    }

    if (status == 'Complete') {
      return Text(
        'Hoàn thành',
        style: TextStyle(fontSize: 15, color: Colors.green),
      );
    }

    if (status == 'Cancel') {
      return Text(
        'Bị từ chối',
        style: TextStyle(fontSize: 15, color: Colors.grey),
      );
    }

    return Text(
      status,
      style: TextStyle(fontSize: 15, color: Colors.black),
    );
  }
}
