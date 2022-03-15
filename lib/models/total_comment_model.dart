class TotalComment {
  final int id;
  final int totalComment;
  final int rating;

  TotalComment({
    required this.id,
    required this.totalComment,
    required this.rating,
  });
}

List<TotalComment> demoListTotalComment = [
  TotalComment(id: 1, totalComment: 1, rating: 1),
  TotalComment(id: 2, totalComment: 5, rating: 2),
  TotalComment(id: 3, totalComment: 15, rating: 3),
  TotalComment(id: 4, totalComment: 38, rating: 4),
  TotalComment(id: 5, totalComment: 73, rating: 5),
];
