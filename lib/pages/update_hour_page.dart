import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/online_hour_model.dart';
import 'package:play_together_mobile/pages/add_new_hour.dart';
import 'package:play_together_mobile/pages/update_single_hour_page.dart';

class UpdateHourPage extends StatefulWidget {
  const UpdateHourPage({Key? key}) : super(key: key);

  @override
  State<UpdateHourPage> createState() => _UpdateHourPageState();
}

class _UpdateHourPageState extends State<UpdateHourPage> {
  bool checkFirstTime = true;
  late List<OnlineHourModel> mondayList;
  late List<OnlineHourModel> tuesdayList;
  late List<OnlineHourModel> wednesdayList;
  late List<OnlineHourModel> thursdayList;
  late List<OnlineHourModel> fridayList;
  late List<OnlineHourModel> saturdayList;
  late List<OnlineHourModel> sundayList;

  void loadData() {
    for (var hour in demoListHour) {
      switch (hour.dayInWeek) {
        case 2:
          mondayList.add(hour);
          break;
        case 3:
          tuesdayList.add(hour);
          break;
        case 4:
          wednesdayList.add(hour);
          break;
        case 5:
          thursdayList.add(hour);
          break;
        case 6:
          fridayList.add(hour);
          break;
        case 7:
          saturdayList.add(hour);
          break;
        case 8:
          sundayList.add(hour);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (checkFirstTime) {
    //   //loadData();
    //   checkFirstTime = false;
    //   print("done");
    // } else {
    //   print("refresh");
    // }
    mondayList = [];
    tuesdayList = [];
    wednesdayList = [];
    thursdayList = [];
    fridayList = [];
    saturdayList = [];
    sundayList = [];
    loadData();
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
            'Chỉnh sửa giờ',
            style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: (() async {
                final check = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddNewHour()));
                setState(() {
                  checkFirstTime = false;
                });
              }),
              child: Icon(
                Icons.add,
                color: Colors.black,
                size: 30,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 10, 5, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thứ 2:',
                style: TextStyle(fontSize: 18),
              ),
              // Column(
              //   children: List.generate(mondayList.length,
              //       (index) => buildHourPerDay(mondayList[index], index)),
              // ),
              buildListHour(mondayList),
              Divider(
                //height: 10,
                thickness: 1,
                indent: 5,
                endIndent: 5,
              ),
              Text(
                'Thứ 3:',
                style: TextStyle(fontSize: 18),
              ),
              // Column(
              //   children: List.generate(tuesdayList.length,
              //       (index) => buildHourPerDay(mondayList[index], index)),
              // ),
              buildListHour(tuesdayList),
              Divider(
                //height: 10,
                thickness: 1,
                indent: 5,
                endIndent: 5,
              ),
              Text(
                'Thứ 4:',
                style: TextStyle(fontSize: 18),
              ),
              // Column(
              //   children: List.generate(wednesdayList.length,
              //       (index) => buildHourPerDay(mondayList[index], index)),
              // ),
              buildListHour(wednesdayList),
              Divider(
                //height: 10,
                thickness: 1,
                indent: 5,
                endIndent: 5,
              ),
              Text(
                'Thứ 5:',
                style: TextStyle(fontSize: 18),
              ),
              // Column(
              //   children: List.generate(thursdayList.length,
              //       (index) => buildHourPerDay(mondayList[index], index)),
              // ),
              buildListHour(thursdayList),
              Divider(
                //height: 10,
                thickness: 1,
                indent: 5,
                endIndent: 5,
              ),
              Text(
                'Thứ 6:',
                style: TextStyle(fontSize: 18),
              ),
              // Column(
              //   children: List.generate(fridayList.length,
              //       (index) => buildHourPerDay(mondayList[index], index)),
              // ),
              buildListHour(fridayList),
              Divider(
                //height: 10,
                thickness: 1,
                indent: 5,
                endIndent: 5,
              ),
              Text(
                'Thứ 7:',
                style: TextStyle(fontSize: 18),
              ),
              buildListHour(saturdayList),
              Divider(
                //height: 10,
                thickness: 1,
                indent: 5,
                endIndent: 5,
              ),
              Text(
                'Chủ nhật',
                style: TextStyle(fontSize: 18),
              ),
              buildListHour(sundayList),
            ],
          )),
    );
  }

  Widget buildHourPerDay(OnlineHourModel hourModel, int position) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () async {
        mondayList.clear();
        tuesdayList.clear();
        wednesdayList.clear();
        thursdayList.clear();
        fridayList.clear();
        saturdayList.clear();
        sundayList.clear();
        final check = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UpdateSingleHourPage(
                      onlineHourModel: hourModel,
                      position: position,
                    )));
        setState(() {
          checkFirstTime = true;
        });
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                children: [
                  SizedBox(
                    width: width * 0.7,
                    child: Text(
                      " • " +
                          hourModel.fromHour.toString() +
                          ":00 - " +
                          hourModel.toHour.toString() +
                          ":00",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        demoListHour.remove(hourModel);
                        setState(() {
                          // mondayList.clear();
                          // tuesdayList.clear();
                          // wednesdayList.clear();
                          // thursdayList.clear();
                          // fridayList.clear();
                          // saturdayList.clear();
                          // sundayList.clear();
                          //checkFirstTime = true;
                        });
                      },
                      icon: Icon(
                        Icons.delete_outline,
                        size: width * 0.08,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListHour(List<OnlineHourModel> list) {
    if (list.length > 0) {
      return Column(
        children: List.generate(
            list.length, (index) => buildHourPerDay(list[index], index)),
      );
    } else {
      return Text('Không có dữ liệu');
    }
  }
}
