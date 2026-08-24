import 'package:flutter/material.dart';

import '../../../../extens/constants.dart';
import '../../../../utils/appstyles.dart';

class ResultPage extends StatelessWidget {
  final String categoryId;
  final int score;
  final int totalQuestions;
  final int correct;
  final int wrong;
  final int skipped;
  final double percentage;

  const ResultPage({
    super.key,
    required this.categoryId,
    required this.score,
    required this.totalQuestions,
    required this.correct,
    required this.wrong,
    required this.skipped,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            categoryId
                .replaceAll('_', ' ')
                .split(' ')
                .map(
                  (word) => word[0].toUpperCase() + word.substring(1),
            )
                .join(' '),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.withOpacity(0.12),
                  ),
                  child: const Icon(
                    Icons.emoji_events,
                    size: 50,
                    color: Colors.orange,
                  ),
                ),

             20.ph,
                const Text(
                  'Quiz Completed!',
                  style: AppStyle.headline
                ),

           8.ph,

                Text(
                  'Here is your quiz performance',
                  style:AppStyle.subheading
                ),

               30.ph,

                /// Percentage Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xff0175C2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Your Score',
                        style: AppStyle.bigbody
                      ),

                    8.ph,

                      Text(
                        '${percentage.toStringAsFixed(0)}%',
                        style: AppStyle.headline
                      ),

                      8.ph,

                      Text(
                        '$score / $totalQuestions',
                        style: AppStyle.body
                      ),
                    ],
                  ),
                ),

                25.ph,

                /// Result Statistics
                Row(
                  children: [
                    Expanded(
                      child: _ResultCard(
                        title: 'Correct',
                        value: '$correct',
                        icon: Icons.check_circle,
                        color: Colors.green,
                      ),
                    ),
                 12.pw,
                    Expanded(
                      child: _ResultCard(
                        title: 'Wrong',
                        value: '$wrong',
                        icon: Icons.cancel,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                12.ph,
                Row(
                  children: [
                    Expanded(
                      child: _ResultCard(
                        title: 'Skipped',
                        value: '$skipped',
                        icon: Icons.skip_next,
                        color: Colors.orange,
                      ),
                    ),
                    12.pw,
                    Expanded(
                      child: _ResultCard(
                        title: 'Total',
                        value: '$totalQuestions',
                        icon: Icons.quiz,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                35.ph,
                /// Back Home
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.popUntil(
                        context,
                            (route) => route.isFirst,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      backgroundColor:
                      const Color(0xff0175C2),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Back to Home',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                /// Try Again
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      foregroundColor:
                      const Color(0xff0175C2),
                      side: const BorderSide(
                        color: Color(0xff0175C2),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Back to Quiz',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _ResultCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 30,
          ),

          const SizedBox(height: 8),

          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}