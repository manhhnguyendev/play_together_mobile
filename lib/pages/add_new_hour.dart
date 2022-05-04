import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/online_hour_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/services/datings_service.dart';
import 'package:play_together_mobile/widgets/profile_accept_button.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNewHour extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;

  const AddNewHour(
      {Key? key, required this.userModel, required this.tokenModel})
      : super(key: key);

  @override
  State<AddNewHour> createState() => _AddNewHourState();
}

class _AddNewHourState extends State<AddNewHour> {
  bool isMonday = false;
  bool isTuesday = false;
  bool isWednesday = false;
  bool isThursday = false;
  bool isFriday = false;
  bool isSaturday = false;
  bool isSunday = false;
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
  int dayOfWeek = 1;
  bool checkFirstTime = true;
  late OnlineHourModel newOnlineHourModel;

  @override
  Widget build(BuildContext context) {
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
            child: TextButton(
              style: TextButton.styleFrom(primary: Colors.black),
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
            'Thêm giờ',
            style: GoogleFonts.montserrat(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 2, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chọn ngày trong tuần: ',
              style: GoogleFonts.montserrat(fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff8980FF),
                    ),
                    color: isMonday
                        ? const Color(0xff8980FF).withOpacity(1)
                        : const Color(0xff8980FF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SizedBox(
                    width: width * 0.2,
                    height: height * 0.05,
                    child: TextButton(
                      style: TextButton.styleFrom(primary: Colors.black),
                      onPressed: () {
                        setState(() {
                          if (!isMonday) {
                            isMonday = true;
                            isTuesday = false;
                            isWednesday = false;
                            isThursday = false;
                            isFriday = false;
                            isSaturday = false;
                            isSunday = false;
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Thứ 2',
                            style: GoogleFonts.montserrat(
                                fontSize: 15, fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff8980FF),
                    ),
                    color: isTuesday
                        ? const Color(0xff8980FF).withOpacity(1)
                        : const Color(0xff8980FF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SizedBox(
                    width: width * 0.2,
                    height: height * 0.05,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          if (!isTuesday) {
                            isTuesday = true;
                            isMonday = false;
                            isWednesday = false;
                            isThursday = false;
                            isFriday = false;
                            isSaturday = false;
                            isSunday = false;
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Thứ 3',
                            style: GoogleFonts.montserrat(
                                fontSize: 15, fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                      style: TextButton.styleFrom(primary: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff8980FF),
                    ),
                    color: isWednesday
                        ? const Color(0xff8980FF).withOpacity(1)
                        : const Color(0xff8980FF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SizedBox(
                    width: width * 0.2,
                    height: height * 0.05,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          if (!isWednesday) {
                            isWednesday = true;
                            isMonday = false;
                            isTuesday = false;
                            isThursday = false;
                            isFriday = false;
                            isSaturday = false;
                            isSunday = false;
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Thứ 4',
                            style: GoogleFonts.montserrat(
                                fontSize: 15, fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                      style: TextButton.styleFrom(primary: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff8980FF),
                    ),
                    color: isThursday
                        ? const Color(0xff8980FF).withOpacity(1)
                        : const Color(0xff8980FF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SizedBox(
                    width: width * 0.2,
                    height: height * 0.05,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          if (!isThursday) {
                            isThursday = true;
                            isMonday = false;
                            isTuesday = false;
                            isWednesday = false;
                            isFriday = false;
                            isSaturday = false;
                            isSunday = false;
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Thứ 5',
                            style: GoogleFonts.montserrat(
                                fontSize: 15, fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                      style: TextButton.styleFrom(primary: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff8980FF),
                    ),
                    color: isFriday
                        ? const Color(0xff8980FF).withOpacity(1)
                        : const Color(0xff8980FF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SizedBox(
                    width: width * 0.25,
                    height: height * 0.05,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          if (!isFriday) {
                            isFriday = true;
                            isMonday = false;
                            isTuesday = false;
                            isWednesday = false;
                            isThursday = false;
                            isSaturday = false;
                            isSunday = false;
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Thứ 6',
                            style: GoogleFonts.montserrat(
                                fontSize: 15, fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                      style: TextButton.styleFrom(primary: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff8980FF),
                    ),
                    color: isSaturday
                        ? const Color(0xff8980FF).withOpacity(1)
                        : const Color(0xff8980FF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SizedBox(
                    width: width * 0.25,
                    height: height * 0.05,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          if (!isSaturday) {
                            isSaturday = true;
                            isMonday = false;
                            isTuesday = false;
                            isWednesday = false;
                            isThursday = false;
                            isFriday = false;
                            isSunday = false;
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Thứ 7',
                            style: GoogleFonts.montserrat(
                                fontSize: 15, fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                      style: TextButton.styleFrom(primary: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff8980FF),
                    ),
                    color: isSunday
                        ? const Color(0xff8980FF).withOpacity(1)
                        : const Color(0xff8980FF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SizedBox(
                    width: width * 0.3,
                    height: height * 0.05,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          if (!isSunday) {
                            isSunday = true;
                            isMonday = false;
                            isTuesday = false;
                            isWednesday = false;
                            isThursday = false;
                            isFriday = false;
                            isSaturday = false;
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Chủ Nhật',
                            style: GoogleFonts.montserrat(
                                fontSize: 15, fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                      style: TextButton.styleFrom(primary: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 15, 0),
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
                      decoration: const InputDecoration(
                        counterText: "",
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff320444), width: 1),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          if (value.isNotEmpty) {
                            if (int.parse(value) < 0 || int.parse(value) > 23) {
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
                      decoration: const InputDecoration(
                        counterText: "",
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff320444), width: 1),
                        ),
                      ),
                      maxLength: 2,
                      onChanged: (value) {
                        setState(() {
                          if (value.isNotEmpty) {
                            if (int.parse(value) < 0 || int.parse(value) > 59) {
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
                            if (int.parse(value) < 0 || int.parse(value) > 59) {
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
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 15, 0),
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
                      decoration: const InputDecoration(
                        counterText: "",
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff320444), width: 1),
                        ),
                      ),
                      maxLength: 2,
                      onChanged: (value) {
                        setState(() {
                          if (value.isNotEmpty) {
                            if (int.parse(value) < 0 || int.parse(value) > 23) {
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
                          if (int.parse(toHour) < 0 || int.parse(toHour) > 23) {
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
                      decoration: const InputDecoration(
                        counterText: "",
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff320444), width: 1),
                        ),
                      ),
                      maxLength: 2,
                      onChanged: (value) {
                        setState(() {
                          if (value.isNotEmpty) {
                            if (int.parse(value) < 0 || int.parse(value) > 59) {
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
                            if (int.parse(value) < 0 || int.parse(value) > 59) {
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
          ],
        ),
      )),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: AcceptProfileButton(
                text: 'Thêm mới',
                onPress: () {
                  if (isMonday) {
                    dayOfWeek = 2;
                  }
                  if (isTuesday) {
                    dayOfWeek = 3;
                  }
                  if (isWednesday) {
                    dayOfWeek = 4;
                  }
                  if (isThursday) {
                    dayOfWeek = 5;
                  }
                  if (isFriday) {
                    dayOfWeek = 6;
                  }
                  if (isSaturday) {
                    dayOfWeek = 7;
                  }
                  if (isSunday) {
                    dayOfWeek = 8;
                  }
                  bool valid = true;
                  if (dayOfWeek == 1) {
                    valid = false;
                  }
                  if (fromHour.isEmpty || fromHour == "") {
                    valid = false;
                  }
                  if (toHour.isEmpty || toHour == "") {
                    valid = false;
                  }
                  if (fromHour.isNotEmpty && toHour.isNotEmpty) {
                    if (int.parse(fromHour) > int.parse(toHour)) {
                      valid = false;
                    } else if (int.parse(fromHour) == int.parse(toHour)) {
                      if (int.parse(fromMinute) > int.parse(toMinute)) {
                        valid = false;
                      }
                    }
                  }
                  if (valid == true) {
                    newFromHour =
                        int.parse(fromHour) * 60 + int.parse(fromMinute);
                    newToHour = int.parse(toHour) * 60 + int.parse(toMinute);
                    CreateOnlineHourModel newModel = CreateOnlineHourModel(
                        fromHour: newFromHour,
                        toHour: newToHour,
                        dayInWeek: dayOfWeek);
                    Future<bool?> addFuture = DatingService()
                        .createDating(newModel, widget.tokenModel.message);
                    addFuture.then((value) {
                      if (value == true) {
                        setState(() {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Thêm thành công"),
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
                  } else if (dayOfWeek == 1) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Vui lòng chọn ngày"),
                    ));
                  } else if (fromHour.isEmpty || toHour.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Vui lòng nhập giờ"),
                    ));
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
