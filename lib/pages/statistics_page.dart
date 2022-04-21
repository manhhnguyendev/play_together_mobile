import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/rating_and_comment_user_page.dart';

class StatisticsPage extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;
  const StatisticsPage(
      {Key? key, required this.userModel, required this.tokenModel})
      : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: FlatButton(
              child: const Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          centerTitle: true,
          title: Text(
            'Thống kê',
            style: GoogleFonts.montserrat(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Container(
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Tỷ lệ hoàn thành',
                                style: GoogleFonts.montserrat(fontSize: 18),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.pie_chart,
                                        size: 30,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '100' '%',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 15, color: Colors.green),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Theo ngày',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 15, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.pie_chart,
                                        size: 30,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '100' '%',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 15, color: Colors.green),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Theo tháng',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 15, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
                    const VerticalDivider(
                      color: Colors.black,
                      thickness: 1,
                      width: 1,
                    ),
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RatingCommentUserPage(
                                        userModel: widget.userModel,
                                        tokenModel: widget.tokenModel,
                                        checkCanReport: true,
                                      )),
                            );
                          },
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Đánh giá',
                                style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Icon(
                                FontAwesomeIcons.solidStar,
                                color: Colors.amber,
                                size: 35,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '4.5',
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Container(
              decoration: BoxDecoration(border: Border.all()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Doanh thu',
                    style: GoogleFonts.montserrat(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              '1.000.000' 'đ',
                              style: GoogleFonts.montserrat(
                                  fontSize: 15, color: Colors.green),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text('Theo ngày',
                                style: GoogleFonts.montserrat(
                                    fontSize: 15, color: Colors.grey)),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            Text(
                              '15.000.000' 'đ',
                              style: GoogleFonts.montserrat(
                                  fontSize: 15, color: Colors.green),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text('Theo tháng',
                                style: GoogleFonts.montserrat(
                                    fontSize: 15, color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
