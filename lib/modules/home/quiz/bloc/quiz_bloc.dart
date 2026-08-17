import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myflutter/modules/home/quiz/bloc/quiz_repository.dart';
import 'quiz_event.dart';
import 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository repository;

  QuizBloc(this.repository) : super(const QuizState()) {
    on<LoadQuizCategoriesEvent>(_loadCategories);
    on<LoadQuizEvent>(_loadQuiz);
    on<OptionSelectionEvent>(_selectOption);
    on<NextQuestionEvent>(_nextQuestion);
    on<PreviousQuestionEvent>(_previousQuestion);
    on<SubmitQuizEvent>(_submitQuiz);
    on<StartTimerEvent>(_startTimer);
    on<TimerTickEvent>(_timerTick);
  }
  Timer? _timer;

  Future<void> _loadCategories(
      LoadQuizCategoriesEvent event,
      Emitter<QuizState> emit,
      ) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );

    try {
      final categories =
      await repository.getQuizCategories();

      emit(
        state.copyWith(
          isLoading: false,
          categories: categories,
        ),
      );
    } catch (e) {
      print("Category error: $e");

      emit(
        state.copyWith(
          isLoading: false,
        ),
      );
    }
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
    add(const StartTimerEvent(300));
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

  void _startTimer(
      StartTimerEvent event,
      Emitter<QuizState> emit,
      ) {
    _timer?.cancel();

    int remaining = event.duration;

    emit(
      state.copyWith(
        remainingSeconds: remaining,
      ),
    );

    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        remaining--;

        if (remaining <= 0) {
          timer.cancel();

          add(
            const TimerTickEvent(0),
          );

          // Auto submit
          add(
            const SubmitQuizEvent(
              userId: 'test_user_123',
              quizId: 'flutter_basics',
              quizTitle: 'Flutter Basics',
              timeTaken: 300,
            ),
          );

          return;
        }

        add(
          TimerTickEvent(remaining),
        );
      },
    );
  }

  void _timerTick(
      TimerTickEvent event,
      Emitter<QuizState> emit,
      ) {
    emit(
      state.copyWith(
        remainingSeconds: event.remainingSeconds,
      ),
    );
  }
  Future<void> _submitQuiz(
      SubmitQuizEvent event,
      Emitter<QuizState> emit,
      ) async {
    int correct = 0;
    int wrong = 0;
    int skipped = 0;

    for (int i = 0; i < state.questions.length; i++) {
      final selected = state.selectedAnswers[i];

      if (selected == null) {
        skipped++;
      } else if (
      selected == state.questions[i].correctAnswerIndex) {
        correct++;
      } else {
        wrong++;
      }
    }

    final total = state.questions.length;

    final percentage = total == 0
        ? 0.0
        : (correct / total) * 100;

    try {
      await repository.saveQuizResult(
        userId: event.userId,
        quizId: event.quizId,
        quizTitle: event.quizTitle,
        totalQuestions: total,
        correct: correct,
        wrong: wrong,
        skipped: skipped,
        percentage: percentage,
        timeTaken: event.timeTaken,
      );

      emit(
        state.copyWith(
          score: correct,
          correct: correct,
          wrong: wrong,
          skipped: skipped,
          percentage: percentage,
          isSubmitted: true,
        ),
      );
    } catch (e) {
      print("Error saving quiz result: $e");
    }
  }
}