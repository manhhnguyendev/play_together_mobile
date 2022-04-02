import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:play_together_mobile/models/detail_hiring_model.dart';
import 'package:play_together_mobile/models/hiring_model.dart';
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/pages/history_hiring_detail_page.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

class HistoryHiringCard extends StatefulWidget {
  final TokenModel tokenModel;
  final OrderModel orderModel;
  const HistoryHiringCard(
      {Key? key, required this.orderModel, required this.tokenModel})
      : super(key: key);

  @override
  _HistoryHiringCardState createState() => _HistoryHiringCardState();
}

class _HistoryHiringCardState extends State<HistoryHiringCard> {
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi');
  bool checkReorder = false;
  @override
  Widget build(BuildContext context) {
    String date = DateFormat('dd/MM/yyyy')
        .format(DateTime.parse(widget.orderModel.timeStart));
    String startTime = DateFormat('hh:mm a')
        .format(DateTime.parse(widget.orderModel.timeStart));
    return Container(
      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HistoryHiringDetail(
                      orderModel: widget.orderModel,
                      tokenModel: widget.tokenModel,
                    )),
          );
        },
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.orderModel.toUser!.name,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    SizedBox(height: 5),
                    Text(
                      date + ', ' + startTime,
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    )
                  ],
                ),
                Spacer(),
                Text(
                  widget.orderModel.totalPrices.toStringAsFixed(0).toVND(),
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Visibility(
                  visible: true,
                  child: Container(
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text(
                            'Đặt lại ',
                            style: TextStyle(
                                fontSize: 15, color: Color(0xff8980FF)),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 20,
                            color: Color(0xff8980FF),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(),
                createStatus(widget.orderModel.status),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all(width: 0.1)),
            ),
          ],
        ),
      ),
    );
  }

  Widget createStatus(String status) {
    if (status == 'Processing') {
      checkReorder = false;
      return Text(
        'Đang thuê',
        style: TextStyle(fontSize: 15, color: Colors.red),
      );
    }

    if (status == 'Starting') {
      checkReorder = false;
      return Text(
        'Đang thương lượng',
        style: TextStyle(fontSize: 15, color: Colors.yellow),
      );
    }

    if (status == 'Finish') {
      checkReorder = false;
      return Text(
        'Hoàn thành',
        style: TextStyle(fontSize: 15, color: Colors.green),
      );
    }

    if (status == 'Cancel') {
      checkReorder = true;
      return Text(
        'Hủy yêu cầu',
        style: TextStyle(fontSize: 15, color: Colors.grey),
      );
    }

    if (status == 'Finish soon') {
      checkReorder = true;
      return Text(
        'Kết thúc sớm',
        style: TextStyle(fontSize: 15, color: Colors.green),
      );
    }

    if (status == 'OverTime') {
      checkReorder = true;
      return Text(
        'Quá giờ chấp nhận',
        style: TextStyle(fontSize: 15, color: Colors.grey),
      );
    }

    if (status == 'Reject') {
      checkReorder = true;
      return Text(
        'Bị từ chối',
        style: TextStyle(fontSize: 15, color: Colors.grey),
      );
    }

    if (status == 'Interrupt') {
      checkReorder = true;
      return Text(
        'Người dùng bị khóa',
        style: TextStyle(fontSize: 15, color: Colors.grey),
      );
    }

    return Text(
      status,
      style: TextStyle(fontSize: 15, color: Colors.black),
    );
  }
}
