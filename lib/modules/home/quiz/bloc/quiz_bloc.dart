import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myflutter/modules/home/quiz/bloc/quiz_repository.dart';
import 'quiz_event.dart';
import 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository repository;

  QuizBloc(this.repository) : super(const QuizState()) {
    on<LoadQuizEvent>(_loadQuiz);
    on<OptionSelectionEvent>(_selectOption);
    on<NextQuestionEvent>(_nextQuestion);
    on<PreviousQuestionEvent>(_previousQuestion);
    on<SubmitQuizEvent>(_submitQuiz);
  }

  Future<void> _loadQuiz(
      LoadQuizEvent event,
      Emitter<QuizState> emit,
  ) async {
    print("LoadQuizEvent received");
    print("Category: ${event.categoryId}");
    emit(state.copyWith(isLoading: true));

    final questions = await repository.getQuestions(event.categoryId);
    print("Questions fetched: ${questions.length}");
    emit(
      state.copyWith(
        isLoading: false,
        questions: questions,
      ),
    );
  }

  void _selectOption(
      OptionSelectionEvent event,
      Emitter<QuizState> emit,
      ) {
    final answers = Map<int, int>.from(state.selectedAnswers);

    answers[state.currentQuestionIndex] = event.selectedIndex;

    emit(
      state.copyWith(
        selectedAnswers: answers,
      ),
    );
  }

  void _nextQuestion(
      NextQuestionEvent event,
      Emitter<QuizState> emit,
      ) {
    if (state.currentQuestionIndex < state.questions.length - 1) {
      emit(
        state.copyWith(
          currentQuestionIndex: state.currentQuestionIndex + 1,
        ),
      );
    }
  }

  void _previousQuestion(
      PreviousQuestionEvent event,
      Emitter<QuizState> emit,
      ) {
    if (state.currentQuestionIndex > 0) {
      emit(
        state.copyWith(
          currentQuestionIndex: state.currentQuestionIndex - 1,
        ),
      );
    }
  }

  void _submitQuiz(
      SubmitQuizEvent event,
      Emitter<QuizState> emit,
      ) {
    int score = 0;

    for (int i = 0; i < state.questions.length; i++) {
      final selected = state.selectedAnswers[i];

      if (selected != null &&
          selected == state.questions[i].correctAnswerIndex) {
        score++;
      }
    }

    emit(
      state.copyWith(
        score: score,
      ),
    );
  }
}