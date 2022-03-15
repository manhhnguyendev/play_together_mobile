class SearchPlayerModel {
  final int id;
  final String name;
  final List<String> abilities;
  final String avatar;
  final int pricePerHour;
  final double rating;
  final int totalComment;
  final String status;

  SearchPlayerModel({
    required this.id,
    required this.name,
    required this.abilities,
    required this.pricePerHour,
    required this.avatar,
    required this.rating,
    required this.status,
    required this.totalComment,
  });
}

List<SearchPlayerModel> demoSearchPlayer = [
  SearchPlayerModel(
      id: 1,
      name: "Hằng Đàm",
      abilities: ['LOL', 'PUBG'],
      pricePerHour: 5000000,
      avatar: "assets/images/play_together_logo_text.png",
      rating: 4.5,
      totalComment: 150,
      status: 'Hiring'),
  SearchPlayerModel(
      id: 2,
      name: "Jennie",
      abilities: ['LOL', 'PUBG'],
      pricePerHour: 500000,
      avatar: "assets/images/play_together_logo_text.png",
      rating: 4,
      totalComment: 70,
      status: 'Processing'),
  SearchPlayerModel(
      id: 3,
      name: "Zuto",
      abilities: ['LOL', 'PUBG', 'DOTA2', 'CSGO'],
      pricePerHour: 20000,
      avatar: "assets/images/play_together_logo_text.png",
      rating: 5,
      totalComment: 10,
      status: 'Online'),
  SearchPlayerModel(
      id: 4,
      name: "Test4",
      abilities: ['LOL', 'PUBG', 'DOTA2', 'CSGO'],
      pricePerHour: 10000,
      avatar: "assets/images/play_together_logo_text.png",
      rating: 1,
      totalComment: 1,
      status: 'Offline'),
];
