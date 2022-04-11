import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/online_hour_model.dart';
import 'package:play_together_mobile/widgets/profile_accept_button.dart';

class UpdateSingleHourPage extends StatefulWidget {
  final OnlineHourModel onlineHourModel;
  final int position;
  const UpdateSingleHourPage(
      {Key? key, required this.onlineHourModel, required this.position})
      : super(key: key);

  @override
  State<UpdateSingleHourPage> createState() => _UpdateSingleHourPageState();
}

class _UpdateSingleHourPageState extends State<UpdateSingleHourPage> {
  var fromHourController = new TextEditingController();
  var toHourController = new TextEditingController();
  String fromHour = "";
  String toHour = "";
  bool checkFirstTime = true;
  late OnlineHourModel newOnlineHourModel;
  @override
  Widget build(BuildContext context) {
    if (checkFirstTime) {
      fromHourController.text = widget.onlineHourModel.fromHour.toString();
      toHourController.text = widget.onlineHourModel.toHour.toString();
      fromHour = widget.onlineHourModel.fromHour.toString();
      toHour = widget.onlineHourModel.toHour.toString();
      print(fromHour + " init");
      print(toHour + ' init');
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
          padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Thứ 2: ",
                style: TextStyle(fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
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
                padding: const EdgeInsets.only(left: 15.0),
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
          )),
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
                  }

                  if (valid) {
                    List<OnlineHourModel> listReplace = [];
                    newOnlineHourModel = new OnlineHourModel(
                        id: widget.onlineHourModel.id,
                        fromHour: int.parse(fromHour),
                        toHour: int.parse(toHour),
                        dayInWeek: widget.onlineHourModel.dayInWeek);
                    listReplace.add(newOnlineHourModel);
                    demoListHour.replaceRange(
                        widget.position, widget.position + 1, listReplace);

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
