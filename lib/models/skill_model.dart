class SkillModel {
  int id;
  String name;
  String rankChoosen;
  List<String> listRank;

  SkillModel({
    required this.id,
    required this.name,
    required this.rankChoosen,
    required this.listRank,
  });
}

List<SkillModel> demoListSkills = [
  SkillModel(
      id: 1,
      name: "Liên Minh Huyền Thoại",
      rankChoosen: "Bạch Kim",
      listRank: ["Không hạng", "Đồng", "Bạc", "Vàng", "Bạch Kim", "Kim Cương"]),
  SkillModel(
      id: 2,
      name: "CSGO",
      rankChoosen: "MG",
      listRank: ["Không hạng", "Silver", "Nova", "MG", "SMFC", "GE"]),
  SkillModel(
      id: 3,
      name: "TestDelete",
      rankChoosen: "MG",
      listRank: ["Không hạng", "Silver", "Nova", "MG", "SMFC", "GE"]),
  SkillModel(
      id: 4,
      name: "TestDelete2",
      rankChoosen: "MG",
      listRank: ["Không hạng", "Silver", "Nova", "MG", "SMFC", "GE"]),
];
