import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/history_hiring_detail_page.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

class HistoryHiringCard extends StatefulWidget {
  final TokenModel tokenModel;
  final UserModel userModel;
  final OrderModel orderModel;

  const HistoryHiringCard(
      {Key? key,
      required this.orderModel,
      required this.tokenModel,
      required this.userModel})
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
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HistoryHiringDetail(
                      orderModel: widget.orderModel,
                      userModel: widget.userModel,
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
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      date + ', ' + startTime,
                      style: const TextStyle(fontSize: 15, color: Colors.grey),
                    )
                  ],
                ),
                const Spacer(),
                Text(
                  widget.orderModel.totalPrices.toStringAsFixed(0).toVND(),
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Visibility(
                  visible: true,
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: const [
                        Text(
                          'Đặt lại ',
                          style:
                              TextStyle(fontSize: 15, color: Color(0xff8980FF)),
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
                const Spacer(),
                createStatus(widget.orderModel.status),
              ],
            ),
            const SizedBox(
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
      return const Text(
        'Đang thuê',
        style: TextStyle(fontSize: 15, color: Colors.red),
      );
    }

    if (status == 'Starting') {
      checkReorder = false;
      return const Text(
        'Đang thương lượng',
        style: TextStyle(fontSize: 15, color: Colors.yellow),
      );
    }

    if (status == 'Finish') {
      checkReorder = false;
      return const Text(
        'Hoàn thành',
        style: TextStyle(fontSize: 15, color: Colors.green),
      );
    }

    if (status == 'Cancel') {
      checkReorder = true;
      return const Text(
        'Hủy yêu cầu',
        style: TextStyle(fontSize: 15, color: Colors.grey),
      );
    }

    if (status == 'Finish soon') {
      checkReorder = true;
      return const Text(
        'Kết thúc sớm',
        style: TextStyle(fontSize: 15, color: Colors.green),
      );
    }

    if (status == 'OverTime') {
      checkReorder = true;
      return const Text(
        'Quá giờ chấp nhận',
        style: TextStyle(fontSize: 15, color: Colors.grey),
      );
    }

    if (status == 'Reject') {
      checkReorder = true;
      return const Text(
        'Bị từ chối',
        style: TextStyle(fontSize: 15, color: Colors.grey),
      );
    }

    if (status == 'Interrupt') {
      checkReorder = true;
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
