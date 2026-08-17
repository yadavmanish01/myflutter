import 'package:equatable/equatable.dart';
import '../../../../model/quizmodel/question_model.dart';
import '../../../../model/quizmodel/quiz_category_model.dart';

class QuizState extends Equatable {
  final bool isLoading;
  final List<QuestionModel> questions;
  final int currentQuestionIndex;
  final int remainingSeconds;
  final List<QuizCategoryModel> categories;

  /// questionIndex -> selectedOptionIndex
  final Map<int, int> selectedAnswers;

  final int score;
  final int correct;
  final int wrong;
  final int skipped;
  final double percentage;
  final bool isSubmitted;

  const QuizState({
    this.categories = const [],
    this.isLoading = false,
    this.questions = const [],
    this.currentQuestionIndex = 0,
    this.selectedAnswers = const {},
    this.score = 0,
    this.correct = 0,
    this.wrong = 0,
    this.skipped = 0,
    this.percentage = 0.0,
    this.isSubmitted = false,
    this.remainingSeconds = 0,
  });

  QuizState copyWith({
    bool? isLoading,
    List<QuestionModel>? questions,
    int? currentQuestionIndex,
    Map<int, int>? selectedAnswers,
    int? score,
    int? correct,
    int? wrong,
    int? skipped,
    List<QuizCategoryModel>? categories,
    double? percentage,
    bool? isSubmitted,
    int? remainingSeconds,
  }) {
    return QuizState(
      isLoading: isLoading ?? this.isLoading,
      questions: questions ?? this.questions,
      remainingSeconds:
      remainingSeconds ?? this.remainingSeconds,
      currentQuestionIndex:
      currentQuestionIndex ?? this.currentQuestionIndex,
      selectedAnswers:
      selectedAnswers ?? this.selectedAnswers,
      score: score ?? this.score,
      correct: correct ?? this.correct,
      wrong: wrong ?? this.wrong,
      skipped: skipped ?? this.skipped,
      percentage: percentage ?? this.percentage,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    questions,
    currentQuestionIndex,
    selectedAnswers,
    score,
    correct,
    wrong,
    skipped,
    categories,
    percentage,
    isSubmitted,
    remainingSeconds,
  ];
}