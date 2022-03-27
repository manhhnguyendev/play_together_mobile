import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/charity_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/receive_request_page.dart';
import 'package:play_together_mobile/widgets/bottom_bar.dart';
import 'package:play_together_mobile/constants/my_color.dart' as my_colors;
import 'package:play_together_mobile/widgets/charity_card.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;

import '../models/order_model.dart';
import '../services/order_service.dart';
import '../services/user_service.dart';

class CharityPage extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;
  const CharityPage(
      {Key? key, required this.userModel, required this.tokenModel})
      : super(key: key);

  @override
  State<CharityPage> createState() => _CharityPageState();
}

class _CharityPageState extends State<CharityPage> {
  late String search;
  var _controller = TextEditingController();
  UserModel? lateUser;
  List<OrderModel>? _listOrder;
//check status
  void check() {
    Future<UserModel?> checkStatus =
        UserService().getUserProfile(widget.tokenModel.message);

    checkStatus.then((value) {
      if (value != null) {
        if (value.status.contains('Online')) {
          print(value.status);
          setState(() {
            lateUser = value;
            //print("đổi nè");
          });
        } else {
          Future<List<OrderModel>?> checkPlayer = OrderService()
              .getAllOrdersForPlayer(widget.tokenModel.message, true, "");
          checkPlayer.then(((order) {
            setState(() {
              _listOrder = order;
              if (_listOrder![0].toUserId == widget.userModel.id) {
                print(value.status);
                setState(() {
                  lateUser = value;
                  helper.pushInto(
                      context,
                      ReceiveRequestPage(
                          //fromUserModel: _listOrder![0].user,
                          orderModel: _listOrder![0],
                          tokenModel: widget.tokenModel,
                          userModel: lateUser!),
                      true);
                });
              }
            });
          }));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    check();
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        bottomOpacity: 0,
        toolbarOpacity: 1,
        toolbarHeight: 65,
        title: Container(
          margin: const EdgeInsets.only(top: 10, left: 10),
          child: Row(children: [
            const CircleAvatar(
              radius: 27,
              backgroundColor: Colors.white,
              backgroundImage:
                  AssetImage("assets/images/play_together_logo_no_text.png"),
            ),
            SizedBox(
              width: size.width / 25,
            ),
            GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => SearchPage()),
                // );
              },
              child: Container(
                width: size.width * 0.7,
                decoration: BoxDecoration(
                  color: my_colors.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: _controller,
                  onChanged: (value) {
                    search = value;
                    setState(() {
                      print(search + ' changed');
                    });
                  },
                  onSubmitted: (value) {
                    if (search.length != 0 && value.length != 0) {
                      setState(() {
                        print(search + ' summit');
                      });
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 30 / 375 * size.width,
                        vertical: 9 / 512 * size.height),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: "Tìm kiếm hội từ thiện",
                    prefixIcon: const Icon(
                      Icons.search,
                      color: my_colors.secondary,
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
            children: List.generate(demoSearchCharity.length,
                (index) => buildListSearch(demoSearchCharity[index]))),
      )),
      bottomNavigationBar: BottomBar(
        userModel: widget.userModel,
        tokenModel: widget.tokenModel,
        bottomBarIndex: 2,
      ),
    );
  }

  Widget buildListSearch(CharityModel model) =>
      CharityCard(charityModel: model);
}
