import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:play_together_mobile/models/search_player_model.dart';
import 'package:play_together_mobile/constants/my_color.dart' as my_colors;

class SearchPlayerCard extends StatefulWidget {
  final SearchPlayerModel searchPlayerModel;
  const SearchPlayerCard({Key? key, required this.searchPlayerModel})
      : super(key: key);

  @override
  _SearchPlayerCardState createState() => _SearchPlayerCardState();
}

class _SearchPlayerCardState extends State<SearchPlayerCard> {
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi');
  bool checkFirstTime = true;
  String games = '';
  void createGamesOfPlayer() {
    for (var i = 0; i < widget.searchPlayerModel.abilities.length; i++) {
      games += widget.searchPlayerModel.abilities[i] + ", ";
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (checkFirstTime) {
      createGamesOfPlayer();
      checkFirstTime = false;
    }
    return Container(
      child: GestureDetector(
        onTap: () {},
        child: Column(
          children: [
            Row(children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(1 / 1000 * size.width),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.2),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    child: Image.asset(widget.searchPlayerModel.avatar,
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.searchPlayerModel.name,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          games,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                '${formatCurrency.format(widget.searchPlayerModel.pricePerHour)}/h',
                                style: TextStyle(
                                    fontSize: 15, color: Color(0xff8980FF)),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  Text(
                                    (widget.searchPlayerModel.rating)
                                        .toString(),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    '(${widget.searchPlayerModel.totalComment})',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        createStatus(widget.searchPlayerModel.status),
                      ],
                    ),
                  ))
            ]),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Container(
                decoration: BoxDecoration(border: Border.all(width: 0.1)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget createStatus(String status) {
    if (status == 'Hiring') {
      return Text(
        'Đang được thuê',
        style: TextStyle(fontSize: 15, color: Colors.red),
      );
    }

    if (status == 'Processing') {
      return Text(
        'Đang thương lượng',
        style: TextStyle(fontSize: 15, color: Colors.yellow),
      );
    }

    if (status == 'Offline') {
      return Text(
        'Đang offline',
        style: TextStyle(fontSize: 15, color: Colors.grey),
      );
    }

    if (status == 'Online') {
      return Text(
        'Có thể thuê',
        style: TextStyle(fontSize: 15, color: Colors.green),
      );
    }

    return Text(
      status,
      style: TextStyle(fontSize: 15, color: Colors.black),
    );
  }
}
