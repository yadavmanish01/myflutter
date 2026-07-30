class QuizCategoryModel {
  final String id;
  final String title;
  final String description;
  final String difficulty;
  final int totalQuestions;
  final String color;
  final String icon;

  QuizCategoryModel({
    required this.id,
    required this.title,
    required this.description,
    required this.difficulty,
    required this.totalQuestions,
    required this.color,
    required this.icon,
  });

  factory QuizCategoryModel.fromJson(
      Map<String, dynamic> json, String id) {
    return QuizCategoryModel(
      id: id,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      difficulty: json['difficulty'] ?? '',
      totalQuestions: json['totalQuestions'] ?? 0,
      color: json['color'] ?? '',
      icon: json['icon'] ?? '',
    );
  }
}