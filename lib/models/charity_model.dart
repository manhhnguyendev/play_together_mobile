class CharityModel {
  final int id;
  final String avatar;
  final String name;
  final String address;
  final String phone;

  CharityModel({
    required this.id,
    required this.avatar,
    required this.name,
    required this.address,
    required this.phone,
  });
}

List<CharityModel> demoSearchCharity = [
  CharityModel(
      id: 1,
      name: 'Hội chữ thập đỏ',
      avatar: "assets/images/defaultprofile.png",
      address: 'aaaaaaaa',
      phone: '0243 8224 030'),
  CharityModel(
      id: 1,
      name: 'Phẫu thuật nụ cười',
      avatar: "assets/images/defaultprofile.png",
      address: 'bbbbbbbbb',
      phone: '0243 8224 030'),
  CharityModel(
      id: 1,
      name: 'Từ thiện trẻ em SG',
      avatar: "assets/images/defaultprofile.png",
      address: 'ccccccccccccc',
      phone: '0243 8224 030'),
];
