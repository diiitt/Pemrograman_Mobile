class FeedbackModel {
  String name;
  String comment;
  int rating;

  FeedbackModel({
    required this.name,
    required this.comment,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'comment': comment,
      'rating': rating,
    };
  }
}