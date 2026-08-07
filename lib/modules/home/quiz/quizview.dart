import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myflutter/routes/app_route_constant.dart';

import '../../../extens/constants.dart';
import '../../../utils/appstyles.dart';

class QuizHomePage extends StatelessWidget {
  const QuizHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        "title": "Flutter",
        "icon": Icons.flutter_dash,
        "questions": "120 Questions",
        "color": Colors.blue
      },
      {
        "title": "Dart",
        "icon": Icons.code,
        "questions": "80 Questions",
        "color": Colors.orange
      },
      {
        "title": "BLoC",
        "icon": Icons.account_tree,
        "questions": "50 Questions",
        "color": Colors.green
      },
      {
        "title": "Firebase",
        "icon": Icons.local_fire_department,
        "questions": "60 Questions",
        "color": Colors.deepOrange
      },
      {
        "title": "Widgets",
        "icon": Icons.widgets,
        "questions": "100 Questions",
        "color": Colors.purple
      },
      {
        "title": "Animations",
        "icon": Icons.animation,
        "questions": "40 Questions",
        "color": Colors.teal
      },
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Flutter Quiz",
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff0175C2),
                      Color(0xff13B9FD),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      "🔥 Daily Challenge",
                      style: AppStyle.headline.copyWith(color: Colors.white)
                    ),
              10.ph,
                    const Text(
                      "Complete today's quiz and earn bonus XP.",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
       20.ph,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue,
                      ),
                      onPressed: () {context.pushNamed(MyAppRouteConstants.quizPageRouteName);},
                      child: const Text("Start Quiz"),
                    )
                  ],
                ),
              ),
      25.ph,
      
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Quiz Categories",
                   style:AppStyle.subheading,
                  ),
                  Icon(Icons.quiz),
                ],
              ),
      15.ph,
      
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: .95,
                ),
                itemBuilder: (context, index) {
                  final item = categories[index];
      
                  return InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {},
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: [
      
                            CircleAvatar(
                              radius: 28,
                              backgroundColor:
                              (item["color"] as Color).withOpacity(.15),
                              child: Icon(
                                item["icon"] as IconData,
                                color: item["color"] as Color,
                                size: 30,
                              ),
                            ),
      
                            Text(
                              item["title"] as String,
                             style: AppStyle.bigbody,
                            ),
      
                            Text(
                              item["questions"] as String,
                             style: AppStyle.caption,
                            ),
      
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: item["color"] as Color,
                                borderRadius:
                                BorderRadius.circular(30),
                              ),
                              child: const Text(
                                "Start",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      25.ph,
      
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.emoji_events,
                        color: Colors.amber,
                        size: 45,
                      ),
           15.pw,
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your Progress",
                              style:AppStyle.bigbody,
                            ),
                     8.ph,
                            LinearProgressIndicator(
                              value: 0.65,
                              minHeight: 8,
                            ),
                          8.ph,
                            Text("65% Completed"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
      20.ph
            ],
          ),
        ),
      ),
    );
  }
}