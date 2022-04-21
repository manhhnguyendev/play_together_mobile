import 'package:flutter/material.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/charity_page.dart';
import 'package:play_together_mobile/pages/home_page.dart';
import 'package:play_together_mobile/pages/history_page.dart';
import 'package:play_together_mobile/pages/notification_page.dart';
import 'package:play_together_mobile/pages/personal_page.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomBar extends StatefulWidget {
  final int bottomBarIndex;
  final UserModel userModel;
  final TokenModel tokenModel;
  const BottomBar(
      {Key? key,
      required this.bottomBarIndex,
      required this.userModel,
      required this.tokenModel})
      : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedLabelStyle: GoogleFonts.montserrat(),
      unselectedLabelStyle: GoogleFonts.montserrat(),
      selectedItemColor: const Color.fromRGBO(137, 128, 255, 1),
      unselectedItemColor: Colors.grey,
      currentIndex: widget.bottomBarIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined, size: 30),
          activeIcon: Icon(Icons.home, size: 30),
          label: "Trang chủ",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.text_snippet_outlined, size: 30),
          activeIcon: Icon(Icons.text_snippet, size: 30),
          label: "Lịch sử",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.health_and_safety_outlined),
          activeIcon: Icon(Icons.health_and_safety_rounded, size: 30),
          label: "Hội từ thiện",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_outlined, size: 30),
          activeIcon: Icon(Icons.notifications, size: 30),
          label: "Thông báo",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outlined, size: 30),
          activeIcon: Icon(Icons.person, size: 30),
          label: "Cá nhân",
        ),
      ],
      onTap: (index) {
        if (index != widget.bottomBarIndex) {
          bool isRightToLeft = false;
          if (index > widget.bottomBarIndex) {
            isRightToLeft = true;
          }
          if (index == 0) {
            helper.pushInto(
              context,
              HomePage(
                userModel: widget.userModel,
                tokenModel: widget.tokenModel,
              ),
              isRightToLeft,
            );
          } else if (index == 1) {
            helper.pushInto(
              context,
              HistoryPage(
                userModel: widget.userModel,
                tokenModel: widget.tokenModel,
              ),
              isRightToLeft,
            );
          } else if (index == 2) {
            helper.pushInto(
              context,
              CharityPage(
                userModel: widget.userModel,
                tokenModel: widget.tokenModel,
              ),
              isRightToLeft,
            );
          } else if (index == 3) {
            helper.pushInto(
              context,
              NotificationsPage(
                userModel: widget.userModel,
                tokenModel: widget.tokenModel,
              ),
              isRightToLeft,
            );
          } else if (index == 4) {
            helper.pushInto(
              context,
              PersonalPage(
                userModel: widget.userModel,
                tokenModel: widget.tokenModel,
              ),
              isRightToLeft,
            );
          }
        }
      },
    );
  }
}
