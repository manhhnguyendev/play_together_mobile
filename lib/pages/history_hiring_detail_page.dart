import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryHiringDetail extends StatefulWidget {
  final OrderModel orderModel;
  final UserModel userModel;
  final TokenModel tokenModel;
  final OrderDetailModel orderDetailModel;

  const HistoryHiringDetail(
      {Key? key,
      required this.orderModel,
      required this.tokenModel,
      required this.userModel,
      required this.orderDetailModel})
      : super(key: key);

  @override
  _HistoryHiringDetailState createState() => _HistoryHiringDetailState();
}

class _HistoryHiringDetailState extends State<HistoryHiringDetail> {
  String? rating;
  final _commentController = TextEditingController();
  final _reasonController = TextEditingController();
  bool checkFinalPrice = true;
  bool checkReason = true;
  bool checkRating = true;
  bool checkComment = true;
  bool checkPlayer = true;
  bool checkExpectedPrice = true;
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

    if (widget.orderDetailModel.status == "Reject") {
      checkFinalPrice = true;
    } else if (widget.orderDetailModel.status == "OverTime") {
      checkFinalPrice = true;
    } else if (widget.orderDetailModel.status == "Cancel") {
      checkFinalPrice = true;
    } else if (widget.orderDetailModel.toUserId == widget.userModel.id) {
      checkFinalPrice = true;
    } else {
      checkFinalPrice = false;
    }

    if (widget.orderDetailModel.reason!.isNotEmpty ||
        widget.orderDetailModel.reason != "") {
      checkReason = true;
    } else {
      checkReason = false;
    }

    if (widget.orderDetailModel.ratings!.isNotEmpty) {
      checkComment = true;
    } else {
      checkComment = false;
    }

    if (widget.orderDetailModel.ratings!.isNotEmpty) {
      checkRating = true;
    } else {
      checkRating = false;
    }

    if (widget.orderDetailModel.toUserId == widget.userModel.id) {
      checkPlayer = true;
    } else {
      checkPlayer = false;
    }

    if (widget.orderDetailModel.userId == widget.userModel.id) {
      checkExpectedPrice = true;
    } else {
      checkExpectedPrice = false;
    }

    rating = widget.orderDetailModel.status == 'Reject'
        ? ''
        : widget.orderDetailModel.status == 'OverTime'
            ? ''
            : widget.orderDetailModel.status == 'Cancel'
                ? ''
                : widget.orderDetailModel.ratings!.isEmpty
                    ? ''
                    : widget.orderDetailModel.ratings![0].rate.toString();

    _commentController.text = (widget.orderDetailModel.status == 'Reject'
        ? ''
        : widget.orderDetailModel.status == 'OverTime'
            ? ''
            : widget.orderDetailModel.status == 'Cancel'
                ? ''
                : widget.orderDetailModel.ratings!.isEmpty
                    ? ''
                    : widget.orderDetailModel.ratings![0].comment);

    _reasonController.text = widget.orderDetailModel.reason != null
        ? widget.orderDetailModel.reason!
        : '';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: TextButton(
              style: TextButton.styleFrom(primary: Colors.black),
              child: const Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          centerTitle: true,
          title: Text(
            'Chi ti???t l?????t thu??',
            style: GoogleFonts.montserrat(
                fontSize: 20,
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
                          style: GoogleFonts.montserrat(fontSize: 18),
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
                    Text(
                      'Th???i l?????ng thu??: ',
                      style: GoogleFonts.montserrat(fontSize: 15),
                    ),
                    const Spacer(),
                    Text(
                      widget.orderDetailModel.totalTimes.toString(),
                      style: GoogleFonts.montserrat(fontSize: 15),
                    ),
                    Text(
                      ' gi???',
                      style: GoogleFonts.montserrat(fontSize: 15),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: checkExpectedPrice,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 25, 10),
                  child: Row(
                    children: [
                      Text(
                        'Chi ph?? d??? ki???n: ',
                        style: GoogleFonts.montserrat(fontSize: 15),
                      ),
                      const Spacer(),
                      Text(
                        widget.orderDetailModel.totalPrices
                            .toStringAsFixed(0)
                            .toVND(),
                        style: GoogleFonts.montserrat(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: checkPlayer,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 25, 10),
                  child: Row(
                    children: [
                      Text(
                        'S??? ti???n d??? ki???n: ',
                        style: GoogleFonts.montserrat(fontSize: 15),
                      ),
                      const Spacer(),
                      Text(
                        widget.orderDetailModel.totalPrices
                            .toStringAsFixed(0)
                            .toVND(),
                        style: GoogleFonts.montserrat(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: !checkFinalPrice,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 25, 10),
                  child: Row(
                    children: [
                      Text(
                        'Chi ph?? cu???i c??ng: ',
                        style: GoogleFonts.montserrat(fontSize: 15),
                      ),
                      const Spacer(),
                      Text(
                        (widget.orderDetailModel.finalPrices /
                                (1 - widget.orderDetailModel.percentSub))
                            .toStringAsFixed(0)
                            .toVND(),
                        style: GoogleFonts.montserrat(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: checkPlayer,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 25, 10),
                  child: Row(
                    children: [
                      Text(
                        'S??? ti???n nh???n ???????c: ',
                        style: GoogleFonts.montserrat(fontSize: 15),
                      ),
                      const Spacer(),
                      Text(
                        widget.orderDetailModel.finalPrices
                            .toStringAsFixed(0)
                            .toVND(),
                        style: GoogleFonts.montserrat(fontSize: 15),
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
                      Text(
                        'Th???i gian b???t ?????u: ',
                        style: GoogleFonts.montserrat(fontSize: 15),
                      ),
                      const Spacer(),
                      Text(
                        dateStart + ", " + timeStart,
                        style: GoogleFonts.montserrat(fontSize: 15),
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
                      Text(
                        'Th???i gian k???t th??c: ',
                        style: GoogleFonts.montserrat(fontSize: 15),
                      ),
                      const Spacer(),
                      Text(
                        dateFinish + ", " + timeFinish,
                        style: GoogleFonts.montserrat(fontSize: 15),
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
                      Text(
                        'Th???i gian: ',
                        style: GoogleFonts.montserrat(fontSize: 15),
                      ),
                      const Spacer(),
                      Text(
                        dateExpired + ", " + timeExpired,
                        style: GoogleFonts.montserrat(fontSize: 15),
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
                  child: Text(
                    'L?? do :',
                    style: GoogleFonts.montserrat(fontSize: 15),
                  ),
                ),
              ),
              Visibility(
                visible: checkReason,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: TextField(
                    style: GoogleFonts.montserrat(fontSize: 15),
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
                        '????nh gi??: ',
                        style: GoogleFonts.montserrat(fontSize: 15),
                      ),
                      const Icon(
                        FontAwesomeIcons.solidStar,
                        color: Colors.amber,
                        size: 15,
                      ),
                      Text(
                        ' ' + rating!,
                        style: GoogleFonts.montserrat(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: checkComment,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: Container(
                    height: 100,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: TextField(
                      style: GoogleFonts.montserrat(),
                      controller: _commentController,
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
      return Text(
        '??ang thu??',
        style: GoogleFonts.montserrat(fontSize: 17, color: Colors.red),
      );
    }

    if (status == 'Starting') {
      return Text(
        '??ang x??? l??',
        style: GoogleFonts.montserrat(fontSize: 17, color: Colors.amber),
      );
    }

    if (status == 'Cancel') {
      return Text(
        'H???y y??u c???u',
        style: GoogleFonts.montserrat(fontSize: 17, color: Colors.grey),
      );
    }

    if (status == 'Hirer Finish Soon') {
      return Text(
        'Ng?????i thu?? k???t th??c s???m',
        style: GoogleFonts.montserrat(fontSize: 17, color: Colors.green),
      );
    }

    if (status == 'Player Finish Soon') {
      return Text(
        'Ng?????i ch??i k???t th??c s???m',
        style: GoogleFonts.montserrat(fontSize: 17, color: Colors.green),
      );
    }

    if (status == 'OverTime') {
      return Text(
        'Qu?? gi??? ch???p nh???n',
        style: GoogleFonts.montserrat(fontSize: 17, color: Colors.grey),
      );
    }

    if (status == 'Reject') {
      return Text(
        'B??? t??? ch???i',
        style: GoogleFonts.montserrat(fontSize: 17, color: Colors.grey),
      );
    }

    if (status == 'Complete') {
      return Text(
        'Ho??n th??nh',
        style: GoogleFonts.montserrat(fontSize: 17, color: Colors.green),
      );
    }

    if (status == 'Interrupt') {
      return Text(
        'B??? gi??n ??o???n',
        style: GoogleFonts.montserrat(fontSize: 17, color: Colors.grey),
      );
    }

    return Text(
      status,
      style: GoogleFonts.montserrat(fontSize: 15, color: Colors.black),
    );
  }
}
