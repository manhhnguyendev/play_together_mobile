import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:play_together_mobile/pages/report_page.dart';
import 'package:play_together_mobile/widgets/second_main_button.dart';

class RatingAndCommentPage extends StatefulWidget {
  const RatingAndCommentPage({Key? key}) : super(key: key);

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
              backgroundImage: AssetImage(profileLink),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Player name",
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
                onSaved: (newValue) => comment = newValue!,
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
          SecondMainButton(text: 'Gửi', onpress: () {}, height: 50, width: 200),
        ],
      ),
    );
  }
}
