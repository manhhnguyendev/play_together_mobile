import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:play_together_mobile/models/rating_comment_model.dart';
import 'package:play_together_mobile/pages/history_hiring_detail_page.dart';
import 'package:play_together_mobile/pages/home_page.dart';
import 'package:play_together_mobile/pages/report_page.dart';
import 'package:play_together_mobile/services/rating_service.dart';
import 'package:play_together_mobile/widgets/second_main_button.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;

import '../models/order_model.dart';
import '../models/token_model.dart';
import '../models/user_model.dart';

class RatingAndCommentPage extends StatefulWidget {
  final OrderModel? orderModel;
  final UserModel? userModel;
  final TokenModel tokenModel;

  const RatingAndCommentPage(
      {Key? key, this.orderModel, this.userModel, required this.tokenModel})
      : super(key: key);

  @override
  _RatingAndCommentPageState createState() => _RatingAndCommentPageState();
}

class _RatingAndCommentPageState extends State<RatingAndCommentPage> {
  String profileLink = "assets/images/defaultprofile.png";
  String comment = "";
  double ratingStar = 0;

  @override
  Widget build(BuildContext context) {
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
                    MaterialPageRoute(builder: (context) => const ReportPage()),
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
          'Kết thúc thuê',
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.normal),
        ),
      ),
      body: Column(
        children: [
          // Container(
          //   alignment: Alignment.center,
          //   child: Text(
          //     'Kết thúc thuê',
          //     style: TextStyle(fontSize: 20),
          //   ),
          // ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 150,
            width: 150,
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.orderModel!.toUser!.avatar),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            widget.orderModel!.toUser!.name,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 25,
          ),
          RatingBar.builder(
            initialRating: ratingStar,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating.toString());
              ratingStar = rating;
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 25, 10, 20),
            child: Container(
              height: 300,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: TextFormField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                maxLength: 1000,
                onChanged: (newValue) => comment = newValue,
                decoration: const InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                  counterText: "",
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: "Nhập đánh giá của bạn...",
                  hintText: "Nhập vào đánh giá người chơi của bạn",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SecondMainButton(
              text: 'Gửi',
              onpress: () {
                print(comment);
                print(int.parse((ratingStar.round()).toString()));
                RatingCreateModel rateComment = RatingCreateModel(
                    rate: ratingStar.round(),
                    comment: comment != "" ? comment : "null comment");
                Future<bool?> rateFuture = RatingService().createRating(
                    widget.orderModel!.id,
                    widget.tokenModel.message,
                    rateComment);
                rateFuture.then((rate) {
                  // if (rate == true) {
                  print("a \n a \n a \n a \n a \n a \n a \n " +
                      "Rate xong về home nè!!!!");
                  setState(() {
                    helper.pushInto(
                        context,
                        HomePage(
                          tokenModel: widget.tokenModel,
                          userModel: widget.userModel!,
                        ),
                        true);
                  });
                  // }
                  // else
                  //   print("rate lỗi rồi");
                });
              },
              height: 50,
              width: 200),
        ],
      ),
    );
  }
}
