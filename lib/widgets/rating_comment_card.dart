import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:play_together_mobile/models/rating_comment_model.dart';
import 'package:play_together_mobile/models/token_model.dart';

class RatingCard extends StatefulWidget {
  final RatingModel? ratingModel;
  final TokenModel tokenModel;
  const RatingCard({Key? key, this.ratingModel, required this.tokenModel})
      : super(key: key);

  @override
  State<RatingCard> createState() => _RatingCardState();
}

class _RatingCardState extends State<RatingCard> {
  @override
  Widget build(BuildContext context) {
    // String date = DateFormat('dd/MM/yyyy').format(widget.ratingModel!.createdDate);
    // String startTime = DateFormat('hh:mm a').format(widget.ratingModel!.date);
    String date = DateFormat('dd/MM/yyyy')
        .format(DateTime.parse(widget.ratingModel!.createdDate));
    String startTime = DateFormat('hh:mm a')
        .format(DateTime.parse(widget.ratingModel!.createdDate));
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 70,
                  width: 70,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage(widget.ratingModel!.user!.avatar),
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.ratingModel!.user!.name,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        buildRatingStar(widget.ratingModel!.rate),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          date + ', ' + startTime,
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.ratingModel!.comment,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        )
                      ],
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.report_gmailerrorred_rounded,
                        color: Colors.black,
                      )))
            ],
          ),
          Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }

  Widget buildRatingStar(int rating) {
    switch (rating) {
      case 1:
        return Row(children: [
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 20,
          ),
        ]);

      case 2:
        return Row(children: [
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 20,
          ),
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 20,
          ),
        ]);

      case 3:
        return Row(children: [
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 20,
          ),
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 20,
          ),
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 20,
          ),
        ]);

      case 4:
        return Row(children: [
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 20,
          ),
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 20,
          ),
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 20,
          ),
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 20,
          ),
        ]);

      case 5:
        return Row(children: [
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 20,
          ),
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 20,
          ),
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 20,
          ),
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 20,
          ),
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 20,
          ),
        ]);

      default:
        return Text('unknown');
    }
  }
}
