class QuizCategoryModel {
  final String id;
  final String title;
  final String description;
  final String difficulty;
  final int totalQuestions;

  final String color;
  final String icon;
  final String iconBackground;

  final int questionsPerQuiz;
  final int duration;

  QuizCategoryModel({
    required this.id,
    required this.title,
    required this.description,
    required this.difficulty,
    required this.totalQuestions,
    required this.color,
    required this.icon,
    required this.iconBackground,
    required this.questionsPerQuiz,
    required this.duration,
  });

  factory QuizCategoryModel.fromJson(
      Map<String, dynamic> json,
      String id,
      ) {
    return QuizCategoryModel(
      id: id,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      difficulty: json['difficulty'] ?? '',
      totalQuestions: json['totalQuestions'] ?? 0,

      // Colors
      color: json['color'] ?? '#0175C2',
      icon: json['icon'] ?? 'quiz',
      iconBackground:
      json['iconBackground'] ?? '#E3F2FD',

      // Quiz settings
      questionsPerQuiz:
      json['questionsPerQuiz'] ?? 20,

      duration:
      json['duration'] ?? 300,
    );
  }
}