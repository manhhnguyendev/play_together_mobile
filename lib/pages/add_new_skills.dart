import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/skill_model.dart';
import 'package:play_together_mobile/widgets/profile_accept_button.dart';

class AddNewSkillsPage extends StatefulWidget {
  const AddNewSkillsPage({Key? key}) : super(key: key);

  @override
  State<AddNewSkillsPage> createState() => _AddNewSkillsPageState();
}

class _AddNewSkillsPageState extends State<AddNewSkillsPage> {
  bool check1st = true;
  SkillModel skill = new SkillModel(
      id: 5,
      name: "Skill mới",
      rankChoosen: "Kim Cương",
      listRank: ["Không hạng", "Đồng", "Bạc", "Vàng", "Bạch Kim", "Kim Cương"]);

  void addNewSkills(SkillModel skillModel) {
    demoListSkills.add(skillModel);
  }

  @override
  Widget build(BuildContext context) {
    if (check1st) {
      addNewSkills(skill);
      check1st = false;
    }
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
            'Thêm kỹ năng',
            style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
      body: Column(children: [Text(skill.name)]),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: AcceptProfileButton(text: 'Cập nhật', onpress: () {})),
      ),
    );
  }
}
