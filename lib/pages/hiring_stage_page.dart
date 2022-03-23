import 'package:flutter/material.dart';
import 'package:play_together_mobile/pages/rating_comment_player_page.dart';
import 'package:play_together_mobile/widgets/countdown_widget.dart';
import 'package:play_together_mobile/widgets/decline_button.dart';
import 'package:play_together_mobile/widgets/second_main_button.dart';

class HiringPage extends StatefulWidget {
  const HiringPage({Key? key}) : super(key: key);

  @override
  _HiringPageState createState() => _HiringPageState();
}

class _HiringPageState extends State<HiringPage> with TickerProviderStateMixin {
  String profileLink = "assets/images/defaultprofile.png";
  String profileLink2 = "assets/images/defaultprofile.png";
  List listGamesChoosen = ['Liên Minh', 'CSGO'];
  late AnimationController controller;
  int hour = 2;
  double progress = 1.0;
  createAlertDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Kết thúc sớm đơn thuê này ?"),
              content: TextField(
                controller: customController,
              ), // TextField
              actions: <Widget>[
                MaterialButton(
                  elevation: 5.0,
                  child: Text('Không'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                MaterialButton(
                  elevation: 5.0,
                  child: Text('Có'),
                  onPressed: () {
                    // widget.testModel.status = "EndEarly";
                    // widget.testModel.reason = customController.text;
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) =>
                    //           TestOrder(testModel: testModel)),
                    // );
                  },
                ) // MaterialButton
                // <Widget>[]
              ] // AlertDialog
              );
        });
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: hour * 60 * 60),
    );

    controller.addListener(() {
      if (controller.isAnimating) {
        setState(() {
          progress = controller.value;
        });
      } else {
        setState(() {
          progress = 1.0;
          isPlaying = false;
        });
      }
    });
    controller.reverse(from: controller.value == 0 ? 1.0 : controller.value);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String get countText {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${controller.duration!.inHours}:${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  bool isPlaying = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: IconButton(
            //       onPressed: () {},
            //       icon: const Icon(
            //         Icons.close,
            //         color: Colors.black,
            //       )),
            // ),
          ],
          centerTitle: true,
          title: Text(
            'Đang thuê...',
            style: TextStyle(
                fontSize: 18, color: Colors.red, fontWeight: FontWeight.normal),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Container(
              //   alignment: Alignment.center,
              //   child: Text(
              //     'Đang thuê',
              //     style: TextStyle(fontSize: 20, color: Colors.red),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 30, 15, 15),
                child: Row(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 120,
                          width: 120,
                          child: CircleAvatar(
                            backgroundImage: AssetImage(profileLink),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Player name",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/play_together_logo_no_text.png"),
                                  fit: BoxFit.cover)),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        SizedBox(
                          height: 120,
                          width: 120,
                          child: CircleAvatar(
                            backgroundImage: AssetImage(profileLink),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Hirer Name",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                      border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                      width: 0.15,
                    ),
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 25, 10),
                child: Row(
                  children: [
                    Text(
                      'Thời lượng thuê ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Spacer(),
                    Text(
                      '2',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      ' giờ',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 25, 10),
                child: Row(
                  children: [
                    Text(
                      'Tổng chi phí ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Spacer(),
                    Text(
                      '1.000.000',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      ' đ',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(
                    border: Border(
                  top: BorderSide(
                    color: Colors.grey,
                    width: 0.15,
                  ),
                )),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(15, 15, 25, 0),
                child: Text(
                  'Tựa game đã chọn: ',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 25, 10),
                child: Column(
                  children: List.generate(
                      listGamesChoosen.length,
                      (index) =>
                          buildGamesChoosenField(listGamesChoosen[index])),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      'Thời gian còn lại:',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: AnimatedBuilder(
                        animation: controller,
                        builder: (context, child) => Text(
                          countText,
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(
                    border: Border(
                  top: BorderSide(
                    color: Colors.grey,
                    width: 0.15,
                  ),
                )),
              ),
              SizedBox(
                height: 40,
              ),
              SecondMainButton(
                  text: 'Nhắn tin', onpress: () {}, height: 50, width: 250),
              SizedBox(
                height: 5,
              ),
              DeclineButton(
                  text: 'Kết thúc sớm',
                  onpress: () {
                    createAlertDialog(context);
                  },
                  height: 50,
                  width: 250),
              SecondMainButton(
                  text: 'temp forward',
                  onpress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RatingAndCommentPage()),
                    );
                  },
                  height: 50,
                  width: 250),
            ],
          ),
        ));
  }

  Widget buildGamesChoosenField(String game) => Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.fromLTRB(15, 5, 25, 5),
        child: Text(
          "- " + game,
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      );
}
