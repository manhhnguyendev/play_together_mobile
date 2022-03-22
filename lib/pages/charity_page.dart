import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/widgets/bottom_bar.dart';

class CharityPage extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;
  const CharityPage(
      {Key? key, required this.userModel, required this.tokenModel})
      : super(key: key);

  @override
  State<CharityPage> createState() => _CharityPageState();
}

class _CharityPageState extends State<CharityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(
        userModel: widget.userModel,
        tokenModel: widget.tokenModel,
        bottomBarIndex: 2,
      ),
    );
  }
}
