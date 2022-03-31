import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/hiring_stage_page.dart';
import 'package:play_together_mobile/pages/home_page.dart';
import 'package:play_together_mobile/widgets/decline_button.dart';
import 'package:play_together_mobile/widgets/second_main_button.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;

import '../services/order_service.dart';
import '../services/user_service.dart';

class HiringNegotiatingPage extends StatefulWidget {
  final OrderModel? orderModel;
  final UserModel userModel;
  final PlayerModel? playerModel;
  final TokenModel tokenModel;

  const HiringNegotiatingPage(
      {Key? key,
      this.orderModel,
      required this.tokenModel,
      required this.userModel,
      this.playerModel})
      : super(key: key);

  @override
  _HiringNegotiatingPageState createState() => _HiringNegotiatingPageState();
}

class _HiringNegotiatingPageState extends State<HiringNegotiatingPage> {
  String profileLink = "assets/images/defaultprofile.png";
  String profileLink2 = "assets/images/defaultprofile.png";
  List listGamesChoosen = ['Liên Minh', 'CSGO'];

  void check() {
    Future<UserModel?> checkStatus =
        UserService().getUserProfile(widget.tokenModel.message);
    checkStatus.then((value) {
      if (value != null) {
        print('check status màn request nè ' + value.status);
        if (value.status.contains('Hiring')) {
          setState(() {
            value = widget.userModel;
            helper.pushInto(
                context,
                HiringPage(
                  tokenModel: widget.tokenModel,
                  userModel: value,
                  orderModel: widget.orderModel,
                ),
                true);
          });
        } else if (value.status.contains('Online')) {
          setState(() {
            value = widget.userModel;
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (BuildContext context) => HomePage(
                    tokenModel: widget.tokenModel, userModel: widget.userModel),
              ),
              (route) => false,
            );
          });
        } else
          setState(() {
            value = widget.userModel;
          });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    check();
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: IconButton(
            //       onPressed: () {},
            //       icon: const Icon(
            //         Icons.close,
            //         color: Colors.black,
            //       )),
            // ),
          ],
          centerTitle: true,
          title: Text(
            'Đang chờ chấp thuận...',
            style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
        ),
        body: Column(
          children: [
            // Container(
            //   alignment: Alignment.center,
            //   child: Text(
            //     'Đang chờ chấp thuận...',
            //     style: TextStyle(fontSize: 20),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 30, 15, 15),
              child: Row(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 120,
                        width: 120,
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(widget.orderModel!.user!.avatar),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.userModel.name,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        ' •  •  ',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
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
                      Text(
                        ' •  • ',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
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
                          backgroundImage:
                              NetworkImage(widget.orderModel!.toUser!.avatar),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.playerModel!.name,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
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
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  Text(
                    widget.orderModel!.totalTimes.toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    ' giờ',
                    style: TextStyle(fontSize: 18),
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
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  Text(
                    widget.orderModel!.totalPrices.toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    ' đ',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 0.15,
                ),
              )),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(15, 15, 25, 0),
              child: Text(
                'Tựa game đã chọn: ',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 25, 10),
              child: Column(
                children: List.generate(listGamesChoosen.length,
                    (index) => buildGamesChoosenField(listGamesChoosen[index])),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SecondMainButton(
                text: 'Nhắn tin', onpress: () {}, height: 50, width: 250),
            SizedBox(
              height: 5,
            ),
            DeclineButton(
                text: 'Hủy yêu cầu',
                onpress: () {
                  setState(() {
                    Future<bool?> cancelFuture = OrderService()
                        .cancelOrderRequest(
                            widget.orderModel!.id, widget.tokenModel.message);
                    cancelFuture.then((check) {
                      if (check == true) {
                        setState(() {
                          print("Cancel về Home nè");
                          helper.pushInto(
                              context,
                              HomePage(
                                tokenModel: widget.tokenModel,
                                userModel: widget.userModel,
                              ),
                              true);
                        });
                      }
                    });
                  });
                },
                height: 50,
                width: 250),
            SecondMainButton(
                text: 'temp forward',
                onpress: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const HiringPage()),
                  // );
                },
                height: 50,
                width: 250),
          ],
        ));
  }

  Widget buildGamesChoosenField(String game) => Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.fromLTRB(15, 5, 25, 5),
        child: Text(
          "- " + game,
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      );
}
