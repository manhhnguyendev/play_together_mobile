import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:play_together_mobile/models/rating_comment_model.dart';
import 'package:play_together_mobile/pages/history_page.dart';
import 'package:play_together_mobile/services/rating_service.dart';
import 'package:play_together_mobile/widgets/second_main_button.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';

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
  String comment = "";
  double ratingStar = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Kết thúc thuê',
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.normal),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            SizedBox(
              height: 150,
              width: 150,
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage(widget.orderModel!.toUser!.avatar),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.orderModel!.toUser!.name,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 25,
            ),
            RatingBar.builder(
              initialRating: ratingStar,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
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
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                    counterText: "",
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: "Nhập đánh giá của bạn...",
                    hintText: "Nhập vào đánh giá người chơi của bạn",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: SecondMainButton(
                text: 'Gửi',
                onpress: () {
                  RatingCreateModel rateComment = RatingCreateModel(
                      rate: ratingStar.round(),
                      comment: comment != "" ? comment : comment);
                  Future<bool?> rateFuture = RatingService().createRating(
                      widget.orderModel!.id,
                      widget.tokenModel.message,
                      rateComment);
                  rateFuture.then((rate) {
                    if (rate == true) {
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
                  });
                },
                height: 50,
                width: 200),
          )),
    );
  }
}
