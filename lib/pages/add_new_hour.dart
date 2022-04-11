import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/online_hour_model.dart';
import 'package:play_together_mobile/widgets/profile_accept_button.dart';

class AddNewHour extends StatefulWidget {
  const AddNewHour({Key? key}) : super(key: key);

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
  var fromHourController = new TextEditingController();
  var toHourController = new TextEditingController();
  String fromHour = "";
  String toHour = "";
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
            'Thêm giờ',
            style: TextStyle(
                fontSize: 18,
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
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  //4 sao
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff8980FF),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SizedBox(
                    width: width * 0.2,
                    height: height * 0.05,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          if (!isMonday) {
                            isMonday = true;
                          } else {
                            isMonday = false;
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Thứ 2',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                      color: isMonday
                          ? const Color(0xff8980FF).withOpacity(1)
                          : const Color(0xff8980FF).withOpacity(0.1),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  //4 sao
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff8980FF),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SizedBox(
                    width: width * 0.2,
                    height: height * 0.05,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          if (!isTuesday) {
                            isTuesday = true;
                          } else {
                            isTuesday = false;
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Thứ 3',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                      color: isTuesday
                          ? const Color(0xff8980FF).withOpacity(1)
                          : const Color(0xff8980FF).withOpacity(0.1),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  //4 sao
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff8980FF),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SizedBox(
                    width: width * 0.2,
                    height: height * 0.05,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          if (!isWednesday) {
                            isWednesday = true;
                          } else {
                            isWednesday = false;
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Thứ 4',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                      color: isWednesday
                          ? const Color(0xff8980FF).withOpacity(1)
                          : const Color(0xff8980FF).withOpacity(0.1),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  //4 sao
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff8980FF),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SizedBox(
                    width: width * 0.2,
                    height: height * 0.05,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          if (!isThursday) {
                            isThursday = true;
                          } else {
                            isThursday = false;
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Thứ 5',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                      color: isThursday
                          ? const Color(0xff8980FF).withOpacity(1)
                          : const Color(0xff8980FF).withOpacity(0.1),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  //4 sao
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff8980FF),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SizedBox(
                    width: width * 0.25,
                    height: height * 0.05,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          if (!isFriday) {
                            isFriday = true;
                          } else {
                            isFriday = false;
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Thứ 6',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                      color: isFriday
                          ? const Color(0xff8980FF).withOpacity(1)
                          : const Color(0xff8980FF).withOpacity(0.1),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  //4 sao
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff8980FF),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SizedBox(
                    width: width * 0.25,
                    height: height * 0.05,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          if (!isSaturday) {
                            isSaturday = true;
                          } else {
                            isSaturday = false;
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Thứ 7',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                      color: isSaturday
                          ? const Color(0xff8980FF).withOpacity(1)
                          : const Color(0xff8980FF).withOpacity(0.1),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  //4 sao
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff8980FF),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SizedBox(
                    width: width * 0.25,
                    height: height * 0.05,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          if (!isSunday) {
                            isSunday = true;
                          } else {
                            isSunday = false;
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Chủ Nhật',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                      color: isSunday
                          ? const Color(0xff8980FF).withOpacity(1)
                          : const Color(0xff8980FF).withOpacity(0.1),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Row(
                children: [
                  Text(
                    "Từ: ",
                    style: TextStyle(fontSize: 15),
                  ),
                  Spacer(),
                  SizedBox(
                    width: width * 0.7,
                    child: TextFormField(
                      initialValue: fromHourController.text,
                      maxLength: 2,
                      onChanged: (value) {
                        setState(() {
                          fromHour = value;
                          if (fromHour.length > 1) {
                            if (int.parse(fromHour) < 0 ||
                                int.parse(fromHour) > 23) {
                              fromHour = "";
                            }
                          }
                          print(fromHour);
                        });
                      },
                      onSaved: (value) {},
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Text(' giờ'),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Row(
                children: [
                  Text("Đến: "),
                  Spacer(),
                  SizedBox(
                    width: width * 0.7,
                    child: TextFormField(
                      initialValue: toHourController.text,
                      maxLength: 2,
                      onChanged: (value) {
                        setState(() {
                          toHour = value;
                          if (toHour.length > 1) {
                            if (int.parse(toHour) < 0 ||
                                int.parse(toHour) > 23) {
                              toHour = "";
                            }
                          }
                          print(toHour);
                        });
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Text(' giờ'),
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
                  }

                  if (valid) {
                    for (var item in demoListHour) {
                      print(item.fromHour.toString() +
                          "-" +
                          item.toHour.toString() +
                          "/ " +
                          item.dayInWeek.toString());
                    }

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Cập nhật thành công"),
                    ));
                    //Navigator.pop(context);
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
