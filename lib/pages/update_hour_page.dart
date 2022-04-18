import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:play_together_mobile/models/online_hour_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/add_new_hour.dart';
import 'package:play_together_mobile/pages/update_single_hour_page.dart';
import 'package:play_together_mobile/services/datings_service.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateHourPage extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;

  const UpdateHourPage(
      {Key? key, required this.tokenModel, required this.userModel})
      : super(key: key);

  @override
  State<UpdateHourPage> createState() => _UpdateHourPageState();
}

class _UpdateHourPageState extends State<UpdateHourPage> {
  late List<OnlineHourModel> mondayList;
  late List<OnlineHourModel> tuesdayList;
  late List<OnlineHourModel> wednesdayList;
  late List<OnlineHourModel> thursdayList;
  late List<OnlineHourModel> fridayList;
  late List<OnlineHourModel> saturdayList;
  late List<OnlineHourModel> sundayList;
  List<OnlineHourModel> allDatings = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllDatings(),
        builder: (context, snapshot) {
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
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.normal),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: (() async {
                      final check = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddNewHour(
                                    tokenModel: widget.tokenModel,
                                    userModel: widget.userModel,
                                  )));
                      setState(() {});
                    }),
                    child: const Icon(
                      FontAwesomeIcons.plus,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(10, 10, 5, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thứ 2:',
                      style: GoogleFonts.montserrat(fontSize: 18),
                    ),
                    buildListHour(mondayList),
                    const Divider(
                      thickness: 1,
                      indent: 5,
                      endIndent: 5,
                    ),
                    Text(
                      'Thứ 3:',
                      style: GoogleFonts.montserrat(fontSize: 18),
                    ),
                    buildListHour(tuesdayList),
                    const Divider(
                      thickness: 1,
                      indent: 5,
                      endIndent: 5,
                    ),
                    Text(
                      'Thứ 4:',
                      style: GoogleFonts.montserrat(fontSize: 18),
                    ),
                    buildListHour(wednesdayList),
                    const Divider(
                      thickness: 1,
                      indent: 5,
                      endIndent: 5,
                    ),
                    Text(
                      'Thứ 5:',
                      style: GoogleFonts.montserrat(fontSize: 18),
                    ),
                    buildListHour(thursdayList),
                    const Divider(
                      thickness: 1,
                      indent: 5,
                      endIndent: 5,
                    ),
                    Text(
                      'Thứ 6:',
                      style: GoogleFonts.montserrat(fontSize: 18),
                    ),
                    buildListHour(fridayList),
                    const Divider(
                      thickness: 1,
                      indent: 5,
                      endIndent: 5,
                    ),
                    Text(
                      'Thứ 7:',
                      style: GoogleFonts.montserrat(fontSize: 18),
                    ),
                    buildListHour(saturdayList),
                    const Divider(
                      thickness: 1,
                      indent: 5,
                      endIndent: 5,
                    ),
                    Text(
                      'Chủ nhật',
                      style: GoogleFonts.montserrat(fontSize: 18),
                    ),
                    buildListHour(sundayList),
                  ],
                )),
          );
        });
  }

  Widget buildHourPerDay(OnlineHourModel hourModel, int position) {
    double width = MediaQuery.of(context).size.width;
    bool checkDelete = true;

    Future getDatings() {
      Future<ResponseListModel<OnlineHourModel>?> getDatingsFuture =
          DatingService()
              .getAllDatings(widget.userModel.id, widget.tokenModel.message);
      getDatingsFuture.then((value) {
        if (value != null) {
          if (checkDelete) {
            allDatings = value.content;
          }
        }
      });
      return getDatingsFuture;
    }

    return FutureBuilder(
        future: getDatings(),
        builder: (context, snapshot) {
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
                            tokenModel: widget.tokenModel,
                            userModel: widget.userModel,
                            onlineHourModel: hourModel,
                            position: position,
                          )));
              setState(() {});
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
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
                                getTimeString(hourModel.fromHour) +
                                " - " +
                                getTimeString(hourModel.toHour),
                            style: GoogleFonts.montserrat(fontSize: 15),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              checkDelete = true;
                              Future<bool?> deleteFuture = DatingService()
                                  .deleteDating(
                                      hourModel.id, widget.tokenModel.message);
                              deleteFuture.then((value) {
                                if (value == true) {
                                  setState(() {
                                    checkDelete = false;
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Xóa thành công"),
                                    ));
                                  });
                                }
                              });
                            },
                            icon: const Icon(
                              FontAwesomeIcons.solidTrashAlt,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget buildListHour(List<OnlineHourModel> list) {
    if (list.isNotEmpty) {
      return Column(
        children: List.generate(
            list.length, (index) => buildHourPerDay(list[index], index)),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          'Không có dữ liệu',
          style: GoogleFonts.montserrat(),
        ),
      );
    }
  }

  Future getAllDatings() {
    Future<ResponseListModel<OnlineHourModel>?> getAllDatingsFuture =
        DatingService()
            .getAllDatings(widget.userModel.id, widget.tokenModel.message);
    getAllDatingsFuture.then((value) {
      if (value != null) {
        allDatings = value.content;
      }
    });
    return getAllDatingsFuture;
  }

  void loadData() {
    mondayList = [];
    tuesdayList = [];
    wednesdayList = [];
    thursdayList = [];
    fridayList = [];
    saturdayList = [];
    sundayList = [];
    if (allDatings.isNotEmpty) {
      for (var hour in allDatings) {
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
  }

  String getTimeString(int value) {
    final int hour = value ~/ 60;
    final int minutes = value % 60;
    return '${hour.toString().padLeft(2, "0")}:${minutes.toString().padLeft(2, "0")}';
  }
}
