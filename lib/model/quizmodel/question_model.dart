class QuestionModel {
  final String id;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;

  QuestionModel({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
  });

  factory QuestionModel.fromJson(
      Map<String, dynamic> json, String id) {
    return QuestionModel(
      id: id,
      question: json['question'] ?? '',
      options: List<String>.from(json['options'] ?? []),
      correctAnswerIndex: json['answerIndex'] ?? 0,
      explanation: json['explanation'] ?? '',
    );
  }
}