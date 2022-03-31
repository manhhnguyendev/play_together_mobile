import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/game_of_orders_model.dart';
import 'package:play_together_mobile/pages/report_page.dart';
import 'package:intl/intl.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

class EndOrderPage extends StatefulWidget {
  const EndOrderPage({Key? key}) : super(key: key);

  @override
  State<EndOrderPage> createState() => _EndOrderPageState();
}

class _EndOrderPageState extends State<EndOrderPage> {
  // String date = DateFormat('dd/MM/yyyy')
  //       .format(DateTime.parse(widget.orderModel!.timeStart));
  //   String startTime = DateFormat('hh:mm a')
  //       .format(DateTime.parse(widget.orderModel!.timeStart));
  //   String endDate = DateFormat('dd/MM/yyyy')
  //       .format(DateTime.parse(widget.orderModel!.timeFinish));
  //   String endTime = DateFormat('hh:mm a')
  //       .format(DateTime.parse(widget.orderModel!.timeFinish));
  late bool checkEndEarly;
  @override
  Widget build(BuildContext context) {
    checkEndEarly = true;
    var _controller = TextEditingController();
    // _controller.text = widget.orderModel!.message;
    _controller.text = "aaaaa";
    var _reasonController = TextEditingController();
    // _controller.text = widget.orderModel!.message;
    _reasonController.text = "Tôi bận";
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
                          builder: (context) => const ReportPage()),
                    );
                  },
                  icon: const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.black,
                  )),
            ),
          ],
          centerTitle: true,
          title: Text(
            'Chi tiết thuê',
            style: TextStyle(
                fontSize: 18, color: Colors.red, fontWeight: FontWeight.normal),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
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
                                backgroundImage: AssetImage(
                                    "assets/images/defaultprofile.png")
                                // NetworkImage(widget.orderModel!.user!.avatar),
                                ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "USER NAME",
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
                                    "assets/images/defaultprofile.png")
                                //NetworkImage(widget.orderModel!.toUser!.avatar),
                                ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            // widget.orderModel!.toUser!.name,
                            "TO USERNAME",
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
                        // widget.orderModel!.totalTimes.toString(),
                        "2",
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
                        // '${formatCurrency.format(widget.orderModel!.totalPrices)}',
                        '100000'.toVND(),
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(15, 15, 25, 0),
                  child: Text(
                    'Tựa game đã chọn: ',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(15, 10, 25, 10),
                //   child: Column(
                //     children: List.generate(
                //         widget.orderModel!.gameOfOrderModel != null
                //             ? widget.orderModel!.gameOfOrderModel.length
                //             : 0,
                //         (index) => buildGamesChoosenField(
                //             widget.orderModel!.gameOfOrderModel[index])),
                //   ),
                // ),
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
                        "12/12/2022, 00:00:00",
                        //date + ", " + startTime,
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
                        "13/12/2022, 02:00:00",
                        //endDate + ", " + endTime,
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
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
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
        ));
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

  Widget buildGamesChoosenField(GameOfOrdersModel game) => Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.fromLTRB(15, 5, 25, 5),
        child: Text(
          "- " + game.game.name,
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      );
}
