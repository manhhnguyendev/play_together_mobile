import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/online_hour_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/services/datings_service.dart';
import 'package:play_together_mobile/widgets/profile_accept_button.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateSingleHourPage extends StatefulWidget {
  final OnlineHourModel onlineHourModel;
  final int position;
  final UserModel userModel;
  final TokenModel tokenModel;

  const UpdateSingleHourPage(
      {Key? key,
      required this.onlineHourModel,
      required this.position,
      required this.userModel,
      required this.tokenModel})
      : super(key: key);

  @override
  State<UpdateSingleHourPage> createState() => _UpdateSingleHourPageState();
}

class _UpdateSingleHourPageState extends State<UpdateSingleHourPage> {
  var fromHourController = TextEditingController();
  var toHourController = TextEditingController();
  String fromHour = "";
  String toHour = "";
  var fromMinuteController = TextEditingController();
  var toMinuteController = TextEditingController();
  String fromMinute = "";
  String toMinute = "";
  late int newFromHour;
  late int newToHour;
  bool checkFirstTime = true;
  late OnlineHourModel newOnlineHourModel;

  @override
  Widget build(BuildContext context) {
    if (checkFirstTime) {
      String rawFromHour =
          (widget.onlineHourModel.fromHour / 60).toStringAsFixed(0);
      String rawFromMinute =
          (widget.onlineHourModel.fromHour % 60).toStringAsFixed(0);
      String rawToHour =
          (widget.onlineHourModel.toHour / 60).toStringAsFixed(0);
      String rawToMinute =
          (widget.onlineHourModel.toHour % 60).toStringAsFixed(0);

      if (rawToMinute.length == 1) {
        rawToMinute = "0" + rawToMinute;
      }
      if (rawFromMinute.length == 1) {
        rawFromMinute = "0" + rawFromMinute;
      }

      fromHourController.text = rawFromHour;
      fromHour = rawFromHour;
      fromMinuteController.text = rawFromMinute;
      fromMinute = rawFromMinute;
      toHourController.text = rawToHour;
      toHour = rawToHour;
      toMinuteController.text = rawToMinute;
      toMinute = rawToMinute;
      checkFirstTime = false;
    }

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
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
            'Chỉnh sửa giờ online',
            style: GoogleFonts.montserrat(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 10, 5, 0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thứ ' + widget.onlineHourModel.dayInWeek.toString() + ':',
                  style: GoogleFonts.montserrat(fontSize: 18),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(10, 15, 15, 0),
                    child: Row(
                      children: [
                        Text(
                          "Từ: ",
                          style: GoogleFonts.montserrat(fontSize: 18),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: width * 0.2,
                          child: TextField(
                            style: GoogleFonts.montserrat(),
                            controller: fromHourController,
                            maxLength: 2,
                            decoration: const InputDecoration(counterText: ""),
                            onChanged: (value) {
                              setState(() {
                                if (value.isNotEmpty) {
                                  if (int.parse(value) < 0 ||
                                      int.parse(value) > 23) {
                                    value = "";
                                    fromHour = "";
                                    fromHourController.text = "";
                                  } else {
                                    fromHour = value;
                                  }
                                }
                              });
                            },
                            onSubmitted: (value) {
                              fromHour = value;
                              if (fromHour.length > 1) {
                                if (int.parse(fromHour) < 0 ||
                                    int.parse(fromHour) > 23) {
                                  fromHour = "";
                                }
                              }
                            },
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Text(
                          " : ",
                          style: GoogleFonts.montserrat(fontSize: 15),
                        ),
                        SizedBox(
                          width: width * 0.2,
                          child: TextField(
                            style: GoogleFonts.montserrat(),
                            controller: fromMinuteController,
                            decoration: const InputDecoration(counterText: ""),
                            maxLength: 2,
                            onChanged: (value) {
                              setState(() {
                                if (value.isNotEmpty) {
                                  if (int.parse(value) < 0 ||
                                      int.parse(value) > 59) {
                                    value = "";
                                    fromMinute = "";
                                    fromMinuteController.text = "";
                                  } else {
                                    fromMinute = value;
                                  }
                                }
                              });
                            },
                            onSubmitted: (value) {
                              setState(() {
                                if (value.length > 1) {
                                  if (int.parse(value) < 0 ||
                                      int.parse(value) > 59) {
                                    value = "";
                                    fromMinute = "";
                                    fromMinuteController.text = "";
                                  } else {
                                    fromMinute = value;
                                  }
                                } else if (value.length == 1) {
                                  value = "0" + value;
                                  fromMinute = "0" + fromMinute;
                                  fromMinuteController.text =
                                      "0" + fromMinuteController.text;
                                }
                              });
                            },
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Text(
                          ' giờ',
                          style: GoogleFonts.montserrat(fontSize: 15),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0, 15.0, 0),
                  child: Row(
                    children: [
                      Text(
                        "Đến: ",
                        style: GoogleFonts.montserrat(fontSize: 18),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: width * 0.2,
                        child: TextField(
                          style: GoogleFonts.montserrat(),
                          controller: toHourController,
                          decoration: const InputDecoration(counterText: ""),
                          maxLength: 2,
                          onChanged: (value) {
                            setState(() {
                              if (value.isNotEmpty) {
                                if (int.parse(value) < 0 ||
                                    int.parse(value) > 23) {
                                  value = "";
                                  toHour = "";
                                  toHourController.text = "";
                                } else {
                                  toHour = value;
                                }
                              }
                            });
                          },
                          onSubmitted: (value) {
                            toHour = value;
                            if (toHour.length > 1) {
                              if (int.parse(toHour) < 0 ||
                                  int.parse(toHour) > 23) {
                                toHour = "";
                              }
                            }
                          },
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Text(
                        " : ",
                        style: GoogleFonts.montserrat(fontSize: 15),
                      ),
                      SizedBox(
                        width: width * 0.2,
                        child: TextField(
                          style: GoogleFonts.montserrat(),
                          controller: toMinuteController,
                          decoration: const InputDecoration(counterText: ""),
                          maxLength: 2,
                          onChanged: (value) {
                            setState(() {
                              if (value.isNotEmpty) {
                                if (int.parse(value) < 0 ||
                                    int.parse(value) > 59) {
                                  value = "";
                                  toMinute = "";
                                  toMinuteController.text = "";
                                } else {
                                  toMinute = value;
                                }
                              }
                            });
                          },
                          onSubmitted: (value) {
                            setState(() {
                              if (value.length > 1) {
                                if (int.parse(value) < 0 ||
                                    int.parse(value) > 59) {
                                  value = "";
                                  toMinute = "";
                                  toMinuteController.text = "";
                                } else {
                                  toMinute = value;
                                }
                              } else if (value.length == 1) {
                                value = "0" + value;
                                toMinute = "0" + toMinute;
                                toMinuteController.text =
                                    "0" + toMinuteController.text;
                              }
                            });
                          },
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Text(
                        ' giờ',
                        style: GoogleFonts.montserrat(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ])),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: AcceptProfileButton(
                text: 'Cập nhật',
                onpress: () {
                  bool valid = true;
                  if (fromHour.isEmpty) {
                    valid = false;
                  }

                  if (toHour.isEmpty) {
                    valid = false;
                  }

                  if (int.parse(fromHour) > int.parse(toHour)) {
                    valid = false;
                  } else if (int.parse(fromHour) == int.parse(toHour)) {
                    if (int.parse(fromMinute) > int.parse(toMinute)) {
                      valid = false;
                    }
                  }

                  if (valid) {
                    newFromHour =
                        int.parse(fromHour) * 60 + int.parse(fromMinute);
                    newToHour = int.parse(toHour) * 60 + int.parse(toMinute);

                    UpdateOnlineHourModel newModel = UpdateOnlineHourModel(
                      fromHour: newFromHour,
                      toHour: newToHour,
                    );
                    Future<bool?> addFuture = DatingService().updateDating(
                        widget.onlineHourModel.id,
                        newModel,
                        widget.tokenModel.message);
                    addFuture.then((value) {
                      if (value == true) {
                        setState(() {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Cập nhật thành công"),
                          ));

                          Navigator.pop(context);
                        });
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Giờ nhập bị trùng"),
                        ));
                      }
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Giờ nhập không chính xác"),
                    ));
                  }
                })),
      ),
    );
  }
}
