import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/history_hiring_detail_page.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_together_mobile/services/order_service.dart';

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
  bool checkStatus = true;

  @override
  Widget build(BuildContext context) {
    String date = "";
    String time = "";
    if (widget.orderModel.timeStart != "0001-01-01T00:00:00") {
      date = DateFormat('dd/MM/yyyy')
          .format(DateTime.parse(widget.orderModel.timeStart));
      time = DateFormat('hh:mm a')
          .format(DateTime.parse(widget.orderModel.timeStart));
    } else {
      date = DateFormat('dd/MM/yyyy')
          .format(DateTime.parse(widget.orderModel.processExpired));
      time = DateFormat('hh:mm a')
          .format(DateTime.parse(widget.orderModel.processExpired));
    }

    if (widget.orderModel.status == "Reject") {
      checkStatus = false;
    } else if (widget.orderModel.status == "OverTime") {
      checkStatus = false;
    } else if (widget.orderModel.status == "Cancel") {
      checkStatus = false;
    } else {
      checkStatus = true;
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: GestureDetector(
        onTap: () {
          Future<ResponseModel<OrderDetailModel>?> orderFuture = OrderService()
              .getDetailOrderById(
                  widget.orderModel.id, widget.tokenModel.message);
          orderFuture.then((orderDetailModel) {
            if (orderDetailModel != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HistoryHiringDetail(
                          orderModel: widget.orderModel,
                          userModel: widget.userModel,
                          tokenModel: widget.tokenModel,
                          orderDetailModel: orderDetailModel.content,
                        )),
              );
            }
          });
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
                      style: GoogleFonts.montserrat(
                          fontSize: 18, color: Colors.black),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      date + ', ' + time,
                      style: GoogleFonts.montserrat(
                          fontSize: 15, color: Colors.grey),
                    )
                  ],
                ),
                const Spacer(),
                Visibility(
                  visible: checkStatus,
                  child: Text(
                    widget.orderModel.finalPrices.toStringAsFixed(0).toVND(),
                    style: GoogleFonts.montserrat(
                        fontSize: 18, color: Colors.black),
                  ),
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
                      children: [
                        Text(
                          'Đặt lại ',
                          style: GoogleFonts.montserrat(
                              fontSize: 15, color: const Color(0xff8980FF)),
                        ),
                        const Icon(
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
      return Text(
        'Đang thuê',
        style: GoogleFonts.montserrat(fontSize: 15, color: Colors.red),
      );
    }

    if (status == 'Starting') {
      checkReorder = false;
      return Text(
        'Đang xử lý',
        style: GoogleFonts.montserrat(fontSize: 15, color: Colors.amber),
      );
    }

    if (status == 'Finish') {
      checkReorder = false;
      return Text(
        'Hoàn thành',
        style: GoogleFonts.montserrat(fontSize: 15, color: Colors.green),
      );
    }

    if (status == 'Cancel') {
      checkReorder = true;
      return Text(
        'Hủy yêu cầu',
        style: GoogleFonts.montserrat(fontSize: 15, color: Colors.grey),
      );
    }

    if (status == 'Hirer Finish Soon') {
      checkReorder = true;
      return Text(
        'Người thuê kết thúc sớm',
        style: GoogleFonts.montserrat(fontSize: 15, color: Colors.green),
      );
    }

    if (status == 'Player Finish Soon') {
      checkReorder = true;
      return Text(
        'Người chơi kết thúc sớm',
        style: GoogleFonts.montserrat(fontSize: 15, color: Colors.green),
      );
    }

    if (status == 'OverTime') {
      checkReorder = true;
      return Text(
        'Quá giờ chấp nhận',
        style: GoogleFonts.montserrat(fontSize: 15, color: Colors.grey),
      );
    }

    if (status == 'Reject') {
      checkReorder = true;
      return Text(
        'Bị từ chối',
        style: GoogleFonts.montserrat(fontSize: 15, color: Colors.grey),
      );
    }

    if (status == 'Complete') {
      checkReorder = true;
      return Text(
        'Hoàn thành',
        style: GoogleFonts.montserrat(fontSize: 15, color: Colors.green),
      );
    }

    if (status == 'Interrupt') {
      checkReorder = true;
      return Text(
        'Người dùng bị khóa',
        style: GoogleFonts.montserrat(fontSize: 15, color: Colors.grey),
      );
    }

    return Text(
      status,
      style: GoogleFonts.montserrat(fontSize: 15, color: Colors.black),
    );
  }
}
