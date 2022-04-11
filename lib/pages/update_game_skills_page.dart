import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/skill_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/add_new_skills.dart';
import 'package:play_together_mobile/widgets/profile_accept_button.dart';

class UpdateGameSkillsPage extends StatefulWidget {
  // final UserModel userModel;
  // final TokenModel tokenModel;
  // const UpdateGameSkillsPage(
  //     {Key? key, required this.userModel, required this.tokenModel})
  //     : super(key: key);

  const UpdateGameSkillsPage({Key? key}) : super(key: key);
  @override
  State<UpdateGameSkillsPage> createState() => _UpdateGameSkillsPageState();
}

class _UpdateGameSkillsPageState extends State<UpdateGameSkillsPage> {
  @override
  Widget build(BuildContext context) {
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
            'Chỉnh sửa kỹ năng',
            style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: (() async {
                final check = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddNewSkillsPage()));
                setState(() {});
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
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: List.generate(demoListSkills.length,
              (index) => buildSkills(demoListSkills[index])),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: AcceptProfileButton(text: 'Cập nhật', onpress: () {})),
      ),
    );
  }

  Widget buildSkills(SkillModel skillModel) {
    List<DropdownMenuItem<String>> listDrop = [];
    bool checkListRank = false;
    if (skillModel.listRank != null) {
      if (skillModel.listRank.length > 0) {
        checkListRank = true;
        listDrop = skillModel.listRank
            .map((val) => DropdownMenuItem<String>(
                  child: Text(val),
                  value: val,
                ))
            .toList();
      }
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: width * 0.4,
                child: Text(
                  skillModel.name,
                  maxLines: 2,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Spacer(),
              Visibility(
                visible: checkListRank,
                child: SizedBox(
                  width: width * 0.4,
                  height: height * 0.05,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(5)),
                    child: DropdownButtonHideUnderline(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: DropdownButton(
                          isExpanded: true,
                          value: skillModel.rankChoosen,
                          items: listDrop,
                          onChanged: (value) {
                            skillModel.rankChoosen = value as String;
                            setState(() {
                              skillModel.rankChoosen = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    demoListSkills.remove(skillModel);
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.delete_outline,
                    size: width * 0.08,
                  )),
            ],
          ),
          Divider(
            height: 10,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
