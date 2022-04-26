import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/system_feedback_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/create_system_feedbacks.dart';
import 'package:play_together_mobile/services/system_feedback_service.dart';
import 'package:play_together_mobile/widgets/feedback_card.dart';

class SystemFeedbackPage extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;
  const SystemFeedbackPage(
      {Key? key, required this.userModel, required this.tokenModel})
      : super(key: key);

  @override
  State<SystemFeedbackPage> createState() => _SystemFeedbackPageState();
}

class _SystemFeedbackPageState extends State<SystemFeedbackPage> {
  List<SystemFeedbackModel> listFeedback = [];

  Future getAllFeedbacks() {
    Future<ResponseListModel<SystemFeedbackModel>?> getAllFeedbackFuture =
        SystemFeedbackService()
            .getAllFeedbacks(widget.userModel.id, widget.tokenModel.message);
    getAllFeedbackFuture.then((value) {
      if (value != null) {
        listFeedback = value.content;
      }
    });
    return getAllFeedbackFuture;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllFeedbacks(),
        builder: (context, snapshot) {
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
                  'Trung tâm phản hồi',
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
                              builder: (context) => CreateFeedbackPage(
                                    userModel: widget.userModel,
                                    tokenModel: widget.tokenModel,
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
                child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                  children: List.generate(listFeedback.length,
                      (index) => buildFeedbackCard(listFeedback[index]))),
            )),
          );
        });
  }

  Widget buildFeedbackCard(SystemFeedbackModel model) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: FeedbackCard(
          tokenModel: widget.tokenModel,
          userModel: widget.userModel,
          systemFeedbackModel: model),
    );
  }
}
