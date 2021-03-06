import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:play_together_mobile/models/rating_comment_model.dart';
import 'package:play_together_mobile/pages/history_page.dart';
import 'package:play_together_mobile/pages/report_page.dart';
import 'package:play_together_mobile/services/rating_service.dart';
import 'package:play_together_mobile/widgets/second_main_button.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:google_fonts/google_fonts.dart';

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
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
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
        title: Text(
          'K???t th??c thu??',
          style: GoogleFonts.montserrat(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
              style: GoogleFonts.montserrat(fontSize: 20),
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
                  style: GoogleFonts.montserrat(),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  maxLength: 1000,
                  onChanged: (newValue) => comment = newValue,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 0, horizontal: 10.0),
                    counterText: "",
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: "Nh???p ????nh gi?? c???a b???n...",
                    hintText: "Nh???p v??o ????nh gi?? ng?????i ch??i c???a b???n",
                    hintStyle: GoogleFonts.montserrat(),
                    labelStyle: GoogleFonts.montserrat(),
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
                text: 'G???i',
                onPress: () {
                  if (ratingStar <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Vui l??ng ????nh gi??!"),
                    ));
                  } else if (comment.isEmpty || comment == "") {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Vui l??ng nh???p ????nh gi??!"),
                    ));
                  } else {
                    RatingCreateModel rateComment = RatingCreateModel(
                        rate: ratingStar.round(), comment: comment);
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
                        Fluttertoast.showToast(
                            msg: "????nh gi?? th??nh c??ng!",
                            textColor: Colors.white,
                            backgroundColor:
                                const Color.fromRGBO(137, 128, 255, 1),
                            toastLength: Toast.LENGTH_SHORT);
                      }
                    });
                  }
                },
                height: 50,
                width: 200),
          )),
    );
  }
}
