import 'package:equatable/equatable.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object?> get props => [];
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
class SubmitQuizEvent extends QuizEvent {}