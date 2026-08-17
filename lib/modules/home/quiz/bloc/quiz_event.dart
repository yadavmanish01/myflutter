import 'package:equatable/equatable.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object?> get props => [];
}

/// Start Timer
class StartTimerEvent extends QuizEvent {
  final int duration;

  const StartTimerEvent(this.duration);

  @override
  List<Object?> get props => [duration];
}

class LoadQuizCategoriesEvent extends QuizEvent {
  const LoadQuizCategoriesEvent();
}

/// Timer Tick
class TimerTickEvent extends QuizEvent {
  final int remainingSeconds;

  const TimerTickEvent(this.remainingSeconds);

  @override
  List<Object?> get props => [remainingSeconds];
}
/// Load Questions
class LoadQuizEvent extends QuizEvent {

  final String categoryId;

  const LoadQuizEvent(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

/// Select Option
class OptionSelectionEvent extends QuizEvent {
  final int selectedIndex;

  const OptionSelectionEvent(this.selectedIndex);

  @override
  List<Object?> get props => [selectedIndex];
}

/// Next Question
class NextQuestionEvent extends QuizEvent {}

/// Previous Question
class PreviousQuestionEvent extends QuizEvent {}

/// Submit Quiz
class SubmitQuizEvent extends QuizEvent {
  final String userId;
  final String quizId;
  final String quizTitle;
  final int timeTaken;

  const SubmitQuizEvent({
    required this.userId,
    required this.quizId,
    required this.quizTitle,
    required this.timeTaken,
  });

  @override
  List<Object?> get props => [
    userId,
    quizId,
    quizTitle,
    timeTaken,
  ];
}