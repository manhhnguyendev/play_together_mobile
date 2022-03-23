class CharityDetailModel {
  final int id;
  final String avatar;
  final String name;
  final String address;
  final String phone;
  final String website;
  final String email;
  final String description;

  CharityDetailModel({
    required this.id,
    required this.avatar,
    required this.name,
    required this.address,
    required this.phone,
    required this.website,
    required this.email,
    required this.description,
  });
}

CharityDetailModel demoCharityDetailModel = new CharityDetailModel(
    id: 1,
    avatar: "assets/images/defaultprofile.png",
    name: "Hoi Chu thap do",
    address: "01 Nguyen Trai, phuong 1, quan 100000000, Ho chi minh city",
    phone: "1234 5678 90",
    website: "www.hoichuthapdo.com",
    email: "hoichuthapdo@gmail.com",
    description:
        "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
