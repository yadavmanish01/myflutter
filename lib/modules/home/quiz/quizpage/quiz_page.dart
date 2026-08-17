import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myflutter/modules/home/quiz/bloc/quiz_bloc.dart';
import 'package:myflutter/modules/home/quiz/bloc/quiz_state.dart';
import '../../../../extens/constants.dart';
import '../../../../utils/appstyles.dart';
import '../bloc/quiz_event.dart';
import '../results/resultsView.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${remainingSeconds.toString().padLeft(2, '0')}';
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<QuizBloc>().add(
      const LoadQuizEvent("flutter_basics"),
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<QuizBloc, QuizState>(
        listener: (context, state) {
          if (state.isSubmitted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => ResultPage(
                  score: state.score,
                  totalQuestions: state.questions.length,
                  correct: state.correct,
                  wrong: state.wrong,
                  skipped: state.skipped,
                  percentage: state.percentage,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state.questions.isEmpty) {
            return const Scaffold(
              body: Center(
                child: Text("No Questions Found"),
              ),
            );
          }

          final question = state.questions[state.currentQuestionIndex];
          final selected =
          state.selectedAnswers[state.currentQuestionIndex];
          return Scaffold(
            appBar: AppBar(
              title: const Text("Flutter Basics"),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Question Number
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Question ${state.currentQuestionIndex + 1} / ${state.questions.length}",
                        style: AppStyle.bigbody,
                      ),
                      Text(
                        formatTime(state.remainingSeconds),
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  10.ph,

                  LinearProgressIndicator(
                    value: (state.currentQuestionIndex + 1) /
                        state.questions.length,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(10),
                  ),

                  30.ph,

                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                       question.question,
                        style: AppStyle.subheading,
                      ),
                    ),
                  ),

                  25.ph,

                  Expanded(
                    child: ListView.separated(
                      itemCount: question.options.length,
                      separatorBuilder: (_, __) => 15.ph,
                      itemBuilder: (context, index) {
                        return InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () {
                            context.read<QuizBloc>().add(
                              OptionSelectionEvent(index),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: selected == index
                                  ? Colors.blue.withOpacity(.1)
                                  : Theme.of(context).highlightColor,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: selected == index
                                    ? Colors.blue
                                    : Colors.grey.shade300,
                                width: 2,
                              ),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.blue.shade100,
                                  child: Text(
                                    String.fromCharCode(65 + index),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                15.pw,
                                Expanded(
                                  child: Text(
                                    question.options[index],
                                    style: AppStyle.bigbody,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: state.currentQuestionIndex > 0,
                    replacement: const SizedBox.shrink(),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<QuizBloc>().add(
                          PreviousQuestionEvent(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: const Color(0xff0175C2),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text(
                          "Previous Question",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  10.ph,
                  Visibility(
                    visible: state.currentQuestionIndex<state.questions.length-1,
                    replacement: const SizedBox.shrink(),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<QuizBloc>().add(
                            NextQuestionEvent(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: const Color(0xff0175C2),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text(
                          "Next Question",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  10.ph,

                  Visibility(
                    visible: state.currentQuestionIndex ==
                        state.questions.length - 1,
                    replacement: const SizedBox.shrink(),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<QuizBloc>().add(
                            const SubmitQuizEvent(
                              userId: 'test_user_123',
                              quizId: 'flutter_basics',
                              quizTitle: 'Flutter Basics',
                              timeTaken: 0,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          backgroundColor: const Color(0xff0175C2),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text(
                          "Submit",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}