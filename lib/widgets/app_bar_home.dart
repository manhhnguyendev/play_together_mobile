import 'package:flutter/material.dart';
import 'package:play_together_mobile/constants/my_color.dart' as my_colors;
import 'package:play_together_mobile/pages/search_page.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String titles;

  //final PreferredSizeWidget? bottomAppBar;
  final void Function() onPressedSearch;
  Appbar(
      {Key? key,
      required this.height,
      required this.titles,
      required this.onPressedSearch})
      : super(key: key);
  Size get preferredSize => Size.fromHeight(height);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AppBar(
      elevation: 1,
      backgroundColor: Colors.white,
      bottomOpacity: 0,
      toolbarOpacity: 1,
      toolbarHeight: 65,
      title: Container(
        margin: EdgeInsets.only(top: 10, left: 10),
        child: Row(children: [
          // avatar
          CircleAvatar(
            radius: 27,
            backgroundColor: Colors.white,
            backgroundImage:
                AssetImage("assets/images/play_together_logo_no_text.png"),
          ),
          SizedBox(
            width: size.width / 25,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, SearchPage.routeName);
            },
            child: Container(
              width: size.width * 0.7,
              decoration: BoxDecoration(
                color: my_colors.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 30 / 375 * size.width,
                      vertical: 9 / 512 * size.height),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: "Tìm kiếm",
                  prefixIcon: Icon(
                    Icons.search,
                    color: my_colors.secondary,
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
      // bottom: bottomAppBar,
    );
  }
}
