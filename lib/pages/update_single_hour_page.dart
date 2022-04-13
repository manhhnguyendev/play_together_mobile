import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/online_hour_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/services/datings_service.dart';
import 'package:play_together_mobile/widgets/profile_accept_button.dart';

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
    double height = MediaQuery.of(context).size.height;

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
            style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 10, 5, 0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Thứ 2: ",
                  style: TextStyle(fontSize: 18),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 15, 15, 0),
                    child: Row(
                      children: [
                        Text(
                          "Từ: ",
                          style: TextStyle(fontSize: 18),
                        ),
                        Spacer(),
                        SizedBox(
                          width: width * 0.2,
                          child: TextField(
                            controller: fromHourController,
                            maxLength: 2,
                            decoration: InputDecoration(counterText: ""),
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
                              if (value != null) {
                                fromHour = value;
                                if (fromHour.length > 1) {
                                  if (int.parse(fromHour) < 0 ||
                                      int.parse(fromHour) > 23) {
                                    fromHour = "";
                                  }
                                }
                              }
                            },
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Text(
                          " : ",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          width: width * 0.2,
                          child: TextField(
                            controller: fromMinuteController,
                            decoration: InputDecoration(counterText: ""),
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
                                if (value != null) {
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
                                }
                              });
                            },
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Text(' giờ'),
                      ],
                    )),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0, 15.0, 0),
                  child: Row(
                    children: [
                      Text(
                        "Đến: ",
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      SizedBox(
                        width: width * 0.2,
                        child: TextField(
                          controller: toHourController,
                          decoration: InputDecoration(counterText: ""),
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
                            if (value != null) {
                              toHour = value;
                              if (toHour.length > 1) {
                                if (int.parse(toHour) < 0 ||
                                    int.parse(toHour) > 23) {
                                  toHour = "";
                                }
                              }
                            }
                          },
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Text(
                        " : ",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        width: width * 0.2,
                        child: TextField(
                          controller: toMinuteController,
                          decoration: InputDecoration(counterText: ""),
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
                              if (value != null) {
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
                              }
                            });
                          },
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Text(' giờ'),
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
                  if (fromHour.length == 0) {
                    valid = false;
                  }

                  if (toHour.length == 0) {
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
                    print(newFromHour.toString() + " luu cai nay");
                    print(newToHour.toString() + " luu cai nay");
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
                          print('Cập nhật thành công');
                          Navigator.pop(context);
                        });
                      } else {
                        print("THÊM BỊ LỖI");
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Giờ nhập bị trùng"),
                        ));
                      }
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Giờ nhập không chính xác"),
                    ));
                  }
                })),
      ),
    );
  }
}
