import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/end_order_page.dart';
import 'package:play_together_mobile/pages/history_hiring_detail_page.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_together_mobile/pages/player_profile_page.dart';
import 'package:play_together_mobile/services/order_service.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;

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
  bool checkReorder = true;
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

    if (widget.orderModel.toUser!.id == widget.userModel.id) {
      checkReorder = false;
    } else {
      checkReorder = true;
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: GestureDetector(
        onTap: () {
          Future<ResponseModel<OrderDetailModel>?> orderDetailFuture =
              OrderService().getDetailOrderById(
                  widget.orderModel.id, widget.tokenModel.message);
          orderDetailFuture.then((orderDetailModel) {
            if (orderDetailModel != null) {
              if (orderDetailModel.content.ratings!.isEmpty &&
                  orderDetailModel.content.reports!.isEmpty) {
                Future<ResponseModel<OrderModel>?> orderFuture = OrderService()
                    .getOrderById(
                        orderDetailModel.content.id, widget.tokenModel.message);
                orderFuture.then((order) {
                  if (order != null) {
                    if (helper.getDayElapsed(DateTime.now().toString(),
                            order.content.timeFinish) >=
                        -10800) {
                      helper.pushInto(
                          context,
                          EndOrderPage(
                            tokenModel: widget.tokenModel,
                            userModel: widget.userModel,
                            orderModel: order.content,
                          ),
                          true);
                    } else {
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
                  }
                });
              } else {
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
                      widget.orderModel.user!.id == widget.userModel.id
                          ? widget.orderModel.toUser!.name
                          : widget.orderModel.user!.name,
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
                    widget.orderModel.user!.id == widget.userModel.id
                        ? '??? ' +
                            (widget.orderModel.finalPrices /
                                    (1 - widget.orderModel.percentSub))
                                .toStringAsFixed(0)
                                .toVND()
                        : '+ ' +
                            widget.orderModel.finalPrices
                                .toStringAsFixed(0)
                                .toVND(),
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
                  visible: checkReorder,
                  child: GestureDetector(
                    onTap: () {
                      Future<ResponseModel<PlayerModel>?> getPlayerByIdFuture =
                          UserService().getPlayerById(
                              widget.orderModel.toUserId,
                              widget.tokenModel.message);
                      getPlayerByIdFuture.then((playerDetail) {
                        if (playerDetail != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlayerProfilePage(
                                      userModel: widget.userModel,
                                      playerModel: playerDetail.content,
                                      tokenModel: widget.tokenModel,
                                    )),
                          );
                        }
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          '?????t l???i ',
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
        '??ang thu??',
        style: GoogleFonts.montserrat(fontSize: 15, color: Colors.red),
      );
    }

    if (status == 'Starting') {
      checkReorder = false;
      return Text(
        '??ang x??? l??',
        style: GoogleFonts.montserrat(fontSize: 15, color: Colors.amber),
      );
    }

    if (status == 'Finish') {
      checkReorder = false;
      return Text(
        'Ho??n th??nh',
        style: GoogleFonts.montserrat(fontSize: 15, color: Colors.green),
      );
    }

    if (status == 'Cancel') {
      checkReorder = true;
      return Text(
        'H???y y??u c???u',
        style: GoogleFonts.montserrat(fontSize: 15, color: Colors.grey),
      );
    }

    if (status == 'Hirer Finish Soon') {
      checkReorder = true;
      return Text(
        'Ng?????i thu?? k???t th??c s???m',
        style: GoogleFonts.montserrat(fontSize: 15, color: Colors.green),
      );
    }

    if (status == 'Player Finish Soon') {
      checkReorder = true;
      return Text(
        'Ng?????i ch??i k???t th??c s???m',
        style: GoogleFonts.montserrat(fontSize: 15, color: Colors.green),
      );
    }

    if (status == 'OverTime') {
      checkReorder = true;
      return Text(
        'Qu?? gi??? ch???p nh???n',
        style: GoogleFonts.montserrat(fontSize: 15, color: Colors.grey),
      );
    }

    if (status == 'Reject') {
      checkReorder = true;
      return Text(
        'B??? t??? ch???i',
        style: GoogleFonts.montserrat(fontSize: 15, color: Colors.grey),
      );
    }

    if (status == 'Complete') {
      checkReorder = true;
      return Text(
        'Ho??n th??nh',
        style: GoogleFonts.montserrat(fontSize: 15, color: Colors.green),
      );
    }

    if (status == 'Interrupt') {
      checkReorder = true;
      return Text(
        'B??? gi??n ??o???n',
        style: GoogleFonts.montserrat(fontSize: 15, color: Colors.grey),
      );
    }

    return Text(
      status,
      style: GoogleFonts.montserrat(fontSize: 15, color: Colors.black),
    );
  }
}
