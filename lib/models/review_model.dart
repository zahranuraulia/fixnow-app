class ReviewModel {
  final String id;
  final String techId;
  final String userName;
  final double rating;
  final String comment;
  final String date;

  ReviewModel({
    required this.id,
    required this.techId,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.date,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      techId: json['tech_id'],
      userName: json['user_name'],
      rating: json['rating'].toDouble(),
      comment: json['comment'],
      date: json['date'],
    );
  }
}