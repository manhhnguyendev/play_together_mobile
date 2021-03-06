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
import 'package:google_fonts/google_fonts.dart';

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
  bool checkEndEarly = true;
  bool checkPlayer = true;
  bool checkHirer = true;

  @override
  Widget build(BuildContext context) {
    bool checkExpired = widget.orderModel?.timeStart == "0001-01-01T00:00:00";
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
    var _reasonController = TextEditingController();
    _reasonController.text =
        widget.orderModel!.reason != null ? widget.orderModel!.reason! : "";

    if (widget.orderModel!.reason != "") {
      checkEndEarly = true;
    } else {
      checkEndEarly = false;
    }

    if (widget.orderModel!.toUserId == widget.userModel!.id) {
      checkPlayer = true;
    } else {
      checkPlayer = false;
    }

    if (widget.orderModel!.userId == widget.userModel!.id) {
      checkHirer = true;
    } else {
      checkHirer = false;
    }

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
        title: Text(
          'Chi ti???t thu??',
          style: GoogleFonts.montserrat(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(),
              child: Column(children: [
                Container(
                    alignment: Alignment.center,
                    child: createStatus(widget.orderModel!.status)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 25, 15),
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
                            style: GoogleFonts.montserrat(fontSize: 17),
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
                            style: GoogleFonts.montserrat(fontSize: 17),
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
                  padding: const EdgeInsets.fromLTRB(15, 15, 20, 10),
                  child: Row(
                    children: [
                      Text(
                        'Th???i l?????ng thu??:',
                        style: GoogleFonts.montserrat(fontSize: 17),
                      ),
                      const Spacer(),
                      Text(
                        widget.orderModel!.totalTimes.toString(),
                        style: GoogleFonts.montserrat(fontSize: 17),
                      ),
                      Text(
                        ' gi???',
                        style: GoogleFonts.montserrat(fontSize: 17),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: checkHirer,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 20, 10),
                    child: Row(
                      children: [
                        Text(
                          'Chi ph?? d??? ki???n: ',
                          style: GoogleFonts.montserrat(fontSize: 17),
                        ),
                        const Spacer(),
                        Text(
                          (widget.orderModel!.totalPrices
                              .toStringAsFixed(0)
                              .toVND()),
                          style: GoogleFonts.montserrat(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: checkPlayer,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 20, 10),
                    child: Row(
                      children: [
                        Text(
                          'S??? ti???n d??? ki???n: ',
                          style: GoogleFonts.montserrat(fontSize: 17),
                        ),
                        const Spacer(),
                        Text(
                          (widget.orderModel!.totalPrices
                              .toStringAsFixed(0)
                              .toVND()),
                          style: GoogleFonts.montserrat(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: checkHirer,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 20, 10),
                    child: Row(
                      children: [
                        Text(
                          'Chi ph?? cu???i c??ng:',
                          style: GoogleFonts.montserrat(fontSize: 17),
                        ),
                        const Spacer(),
                        Text(
                          (widget.orderModel!.finalPrices /
                                  (1 - widget.orderModel!.percentSub))
                              .toStringAsFixed(0)
                              .toVND(),
                          style: GoogleFonts.montserrat(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: checkPlayer,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 20, 10),
                    child: Row(
                      children: [
                        Text(
                          'S??? ti???n nh???n ???????c:',
                          style: GoogleFonts.montserrat(fontSize: 17),
                        ),
                        const Spacer(),
                        Text(
                          widget.orderModel!.finalPrices
                              .toStringAsFixed(0)
                              .toVND(),
                          style: GoogleFonts.montserrat(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: !checkExpired,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 20, 10),
                    child: Row(
                      children: [
                        Text(
                          'Th???i gian b???t ?????u:',
                          style: GoogleFonts.montserrat(fontSize: 17),
                        ),
                        const Spacer(),
                        Text(
                          dateStart + ", " + timeStart,
                          style: GoogleFonts.montserrat(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: !checkExpired,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 20, 10),
                    child: Row(
                      children: [
                        Text(
                          'Th???i gian k???t th??c:',
                          style: GoogleFonts.montserrat(fontSize: 17),
                        ),
                        const Spacer(),
                        Text(
                          dateFinish + ", " + timeFinish,
                          style: GoogleFonts.montserrat(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: checkExpired,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 20, 10),
                    child: Row(
                      children: [
                        Text(
                          'Th???i gian:',
                          style: GoogleFonts.montserrat(fontSize: 17),
                        ),
                        const Spacer(),
                        Text(
                          dateExpired + ", " + timeExpired,
                          style: GoogleFonts.montserrat(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(15, 15, 20, 10),
                  child: Text(
                    'T???a game ???? ch???n:',
                    style: GoogleFonts.montserrat(fontSize: 17),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 25, 0),
                  child: Column(
                    children: List.generate(
                        widget.orderModel!.gameOfOrders.isNotEmpty
                            ? widget.orderModel!.gameOfOrders.length
                            : 0,
                        (index) => buildGamesChoosenField(
                            widget.orderModel!.gameOfOrders[index])),
                  ),
                ),
                Visibility(
                  visible: checkEndEarly,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(15, 10, 25, 10),
                    child: Text(
                      'L?? do k???t th??c s???m:',
                      style: GoogleFonts.montserrat(fontSize: 17),
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
                        style: GoogleFonts.montserrat(fontSize: 15),
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
              ]))),
      bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: SecondMainButton(
                text: 'K???t th??c',
                onPress: () {
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
                width: 150),
          )),
    );
  }

  Widget createStatus(String status) {
    if (status == 'Processing') {
      return Text(
        '??ang thu??',
        style: GoogleFonts.montserrat(fontSize: 17, color: Colors.red),
      );
    }

    if (status == 'Complete') {
      return Text(
        'Ho??n th??nh',
        style: GoogleFonts.montserrat(fontSize: 17, color: Colors.green),
      );
    }

    if (status == 'Starting') {
      return Text(
        '??ang x??? l??',
        style: GoogleFonts.montserrat(fontSize: 17, color: Colors.amber),
      );
    }

    if (status == 'Finish') {
      return Text(
        'Ho??n th??nh',
        style: GoogleFonts.montserrat(fontSize: 17, color: Colors.green),
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

    if (status == 'Interrupt') {
      return Text(
        'Ng?????i d??ng b??? kh??a',
        style: GoogleFonts.montserrat(fontSize: 17, color: Colors.grey),
      );
    }

    return Text(
      status,
      style: GoogleFonts.montserrat(fontSize: 17, color: Colors.black),
    );
  }

  Widget buildGamesChoosenField(GameOfOrdersModel game) => Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.fromLTRB(15, 5, 25, 5),
        child: Text(
          "??? " + game.game.name,
          style: GoogleFonts.montserrat(fontSize: 15),
        ),
      );
}
