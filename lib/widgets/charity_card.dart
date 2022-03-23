import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/charity_detail_model.dart';
import 'package:play_together_mobile/models/charity_model.dart';
import 'package:play_together_mobile/pages/charity_detail_page.dart';

class CharityCard extends StatefulWidget {
  final CharityModel charityModel;
  const CharityCard({Key? key, required this.charityModel}) : super(key: key);

  @override
  State<CharityCard> createState() => _CharityCardState();
}

class _CharityCardState extends State<CharityCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CharityDetailPage(
                      charityDetailModel: demoCharityDetailModel,
                    )),
          );
        },
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        child: Image.asset(widget.charityModel.avatar,
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
                              widget.charityModel.name,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.charityModel.address,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.charityModel.phone,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                            SizedBox(
                              height: 5,
                            ),
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
}
