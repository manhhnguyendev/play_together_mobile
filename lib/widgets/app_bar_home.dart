import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_together_mobile/helpers/my_color.dart' as my_colors;
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/search_history_recommend_page.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  final TokenModel tokenModel;
  final UserModel userModel;
  final double height;
  final String titles;
  final void Function() onPressedSearch;

  const Appbar(
      {Key? key,
      required this.height,
      required this.titles,
      required this.onPressedSearch,
      required this.tokenModel,
      required this.userModel})
      : super(key: key);
  @override
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
        margin: const EdgeInsets.only(top: 10, left: 10),
        child: Row(children: [
          const CircleAvatar(
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
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SearchHistoryAndRecommendPage(
                          userModel: userModel,
                          tokenModel: tokenModel,
                        )),
              );
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
                  hintStyle: GoogleFonts.montserrat(),
                  prefixIcon: const Icon(
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
