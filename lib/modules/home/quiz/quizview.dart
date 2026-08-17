
    // final categories = [
    //   {
    //     "title": "Flutter",
    //     "icon": Icons.flutter_dash,
    //     "questions": "120 Questions",
    //     "color": Colors.blue
    //   },
    //   {
    //     "title": "Dart",
    //     "icon": Icons.code,
    //     "questions": "80 Questions",
    //     "color": Colors.orange
    //   },
    //   {
    //     "title": "BLoC",
    //     "icon": Icons.account_tree,
    //     "questions": "50 Questions",
    //     "color": Colors.green
    //   },
    //   {
    //     "title": "Firebase",
    //     "icon": Icons.local_fire_department,
    //     "questions": "60 Questions",
    //     "color": Colors.deepOrange
    //   },
    //   {
    //     "title": "Widgets",
    //     "icon": Icons.widgets,
    //     "questions": "100 Questions",
    //     "color": Colors.purple
    //   },
    //   {
    //     "title": "Animations",
    //     "icon": Icons.animation,
    //     "questions": "40 Questions",
    //     "color": Colors.teal
    //   },
    // ];

    import 'package:flutter/material.dart';
    import 'package:flutter_bloc/flutter_bloc.dart';
    import 'package:go_router/go_router.dart';
    import 'package:myflutter/routes/app_route_constant.dart';
    import '../../../extens/constants.dart';
    import '../../../utils/appstyles.dart';
    import 'bloc/quiz_bloc.dart';
    import 'bloc/quiz_event.dart';
import 'bloc/quiz_state.dart';

    class QuizHomePage extends StatefulWidget {
      const QuizHomePage({super.key});

  @override
  State<QuizHomePage> createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
      @override
  void initState() {
        context.read<QuizBloc>().add(
          const LoadQuizCategoriesEvent(),
        );
    super.initState();
  }

      Color hexToColor(String hex) {
        return Color(
          int.parse(
            hex.replaceFirst('#', '0xff'),
          ),
        );
      }

      IconData getQuizIcon(String iconName) {
        switch (iconName) {
          case 'flutter':
            return Icons.flutter_dash;

          case 'code':
            return Icons.code;

          case 'account_tree':
            return Icons.account_tree;

          case 'local_fire_department':
            return Icons.local_fire_department;

          case 'widgets':
            return Icons.widgets;

          case 'animation':
            return Icons.animation;

          case 'firebase':
            return Icons.local_fire_department;

          default:
            return Icons.quiz;
        }
      }

      @override
      Widget build(BuildContext context) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Flutter Quiz"),
              centerTitle: true,
            ),
            body: BlocBuilder<QuizBloc, QuizState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return SingleChildScrollView(
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
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [

                            Text(
                              "🔥 Daily Challenge",
                              style: AppStyle.headline.copyWith(
                                color: Colors.white,
                              ),
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
                              onPressed: () {
                                context.pushNamed(
                                  MyAppRouteConstants
                                      .quizPageRouteName,
                                );
                              },
                              child: const Text("Start Quiz"),
                            ),
                          ],
                        ),
                      ),
                      25.ph,
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Quiz Categories",
                            style: AppStyle.subheading,
                          ),
                          Icon(Icons.quiz),
                        ],
                      ),

                      15.ph,
                      if (state.categories.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(30),
                          child: Text(
                            "No quiz categories found",
                          ),
                        )
                      else
                        GridView.builder(
                          shrinkWrap: true,
                          physics:
                          const NeverScrollableScrollPhysics(),

                          itemCount: state.categories.length,

                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: .95,
                          ),

                          itemBuilder: (context, index) {

                            final category =
                            state.categories[index];

                            final cardColor =
                            hexToColor(category.color);

                            final iconBackground =
                            hexToColor(
                              category.iconBackground,
                            );

                            final icon =
                            getQuizIcon(category.icon);

                            return InkWell(
                              borderRadius:
                              BorderRadius.circular(18),

                              onTap: () {
                                context.pushNamed(
                                  MyAppRouteConstants
                                      .quizPageRouteName,
                                  extra: category.id,
                                );
                              },

                              child: Card(
                                elevation: 4,

                                shape:
                                RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(18),
                                ),

                                child: Padding(
                                  padding:
                                  const EdgeInsets.all(16),

                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceEvenly,

                                    children: [
                                      CircleAvatar(
                                        radius: 28,
                                        backgroundColor:
                                        iconBackground,
                                        child: Icon(
                                          icon,
                                          color: cardColor,
                                          size: 30,
                                        ),
                                      ),
                                      Text(
                                        category.title,
                                        style:
                                        AppStyle.bigbody,
                                      ),
                                      Text(
                                        "${category.totalQuestions} Questions",
                                        style:
                                        AppStyle.caption,
                                      ),
                                      Container(
                                        padding:
                                        const EdgeInsets
                                            .symmetric(
                                          horizontal: 18,
                                          vertical: 8,
                                        ),
                                        decoration:
                                        BoxDecoration(
                                          color: cardColor,
                                          borderRadius:
                                          BorderRadius
                                              .circular(30),
                                        ),
                                        child: const Text(
                                          "Start",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight:
                                            FontWeight.bold,
                                          ),
                                        ),
                                      ),
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
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(18),
                        ),
                        child: Padding(
                          padding:
                          const EdgeInsets.all(18),
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
                                      style:
                                      AppStyle.bigbody,
                                    ),

                                    8.ph,

                                    const LinearProgressIndicator(
                                      value: 0.65,
                                      minHeight: 8,
                                    ),
                                    8.ph,
                                    const Text(
                                      "65% Completed",
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      20.ph,
                    ],
                  ),
                );
              },
            ),
          ),
        );
      }
}
