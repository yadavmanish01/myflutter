import 'package:equatable/equatable.dart';
import '../../../../model/quizmodel/question_model.dart';

class QuizState extends Equatable {
  final bool isLoading;
  final List<QuestionModel> questions;
  final int currentQuestionIndex;

  /// questionIndex -> selectedOptionIndex
  final Map<int, int> selectedAnswers;

  final int score;

  const QuizState({
    this.isLoading = false,
    this.questions = const [],
    this.currentQuestionIndex = 0,
    this.selectedAnswers = const {},
    this.score = 0,
  });

  QuizState copyWith({
    bool? isLoading,
    List<QuestionModel>? questions,
    int? currentQuestionIndex,
    Map<int, int>? selectedAnswers,
    int? score,
  }) {
    return QuizState(
      isLoading: isLoading ?? this.isLoading,
      questions: questions ?? this.questions,
      currentQuestionIndex:
      currentQuestionIndex ?? this.currentQuestionIndex,
      selectedAnswers:
      selectedAnswers ?? this.selectedAnswers,
      score: score ?? this.score,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    questions,
    currentQuestionIndex,
    selectedAnswers,
    score,
  ];
}