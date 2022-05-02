import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/widgets/search_player_card.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesListPage extends StatefulWidget {
  final String title;
  final List<GetAllUserModel> playerList;
  final UserModel userModel;
  final TokenModel tokenModel;

  const CategoriesListPage(
      {Key? key,
      required this.title,
      required this.userModel,
      required this.tokenModel,
      required this.playerList})
      : super(key: key);

  @override
  State<CategoriesListPage> createState() => _CategoriesListPageState();
}

class _CategoriesListPageState extends State<CategoriesListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: TextButton(
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
            widget.title,
            style: GoogleFonts.montserrat(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
              children: List.generate(widget.playerList.length,
                  (index) => buildListSearch(widget.playerList[index]))),
        ),
      ),
    );
  }

  Widget buildListSearch(GetAllUserModel _playerModel) => SearchPlayerCard(
        playerModel: _playerModel,
        tokenModel: widget.tokenModel,
        userModel: widget.userModel,
      );
}
