import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myflutter/modules/auth/login/loginbloc/login_bloc.dart';
import 'package:myflutter/modules/auth/login/loginbloc/login_event.dart';
import 'package:myflutter/modules/auth/login/loginbloc/login_state.dart';
import 'package:myflutter/modules/home/homebloc/homeEvent.dart';
import 'package:myflutter/modules/home/homebloc/homebloc.dart';
import 'package:myflutter/modules/home/homebloc/homestate.dart';
import 'package:myflutter/modules/home/packages/packagesView.dart';
import 'package:myflutter/routes/app_route_constant.dart';
import 'package:myflutter/utils/appstyles.dart';
import 'package:myflutter/widgets/custom_button.dart';
import '../../extens/constants.dart';
import '../../theme/app_theme.dart';
import '../../theme/bloctheme/bloc_theme_bloc.dart';
import '../../utils/enum.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "MyFlutter",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_none_rounded,
              color: theme.colorScheme.primary,
            ),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) =>
                    AlertDialog(
                        title: Text(
                          "Are you sure,you want to Logout?",
                          style: AppStyle.title,
                        ),
                        content:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child:BlocConsumer<LoginBloc, LoginState>(
                                  listener: (context, state) {
                                    if (state.postApiStatus == PostApiStatus.COMPLETED) {
                                      context.pop();
                                      context.goNamed(MyAppRouteConstants.loginRouteName);
                                    }

                                    if (state.postApiStatus == PostApiStatus.ERROR) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(state.message)),
                                      );
                                    }
                                  },
                                  builder: (context, state) {
                                    return CustomButton(
                                      onPressed: () {
                                        context.read<LoginBloc>().add(LogoutApi());
                                      },
                                      title: "Yes",
                                      loading: state.postApiStatus == PostApiStatus.LOADING,
                                    );
                                  },
                                )),
                              20.pw,
                              Expanded(
                                child: CustomButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  title: "No",
                                  loading: false,
                                ),
                              ),
                            ],
                          ),

                    ),
              );
            },
            icon: Icon(Icons.logout, color: theme.colorScheme.primary),
          ),
          10.pw,
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Hero Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("👋 Welcome", style: TextStyle(color: Colors.white70)),
                  SizedBox(height: 8),
                  Text(
                    "MyFlutter",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Latest Flutter News, Packages,\nInterview Questions & Daily Quiz",
                    style: TextStyle(color: Colors.white70, height: 1.4),
                  ),
                ],
              ),
            ),

            30.ph,

            Text(
              "Quick Access",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            15.ph,

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.35,
              children: [
                FeatureCard(
                  onTap: () {
                    context.pushNamed(MyAppRouteConstants.NewsScreenRouteName);
                  },
                  icon: Icons.article_outlined,
                  title: "Latest News",
                  subtitle: "Flutter Updates",
                ),

                FeatureCard(
                  onTap: (){
                    context.pushNamed(MyAppRouteConstants.packagesRouteName);
                  },
                  icon: Icons.extension_outlined,
                  title: "Packages",
                  subtitle: "New Packages",
                ),
                FeatureCard(
                  icon: Icons.work_outline,
                  title: "Interview",
                  subtitle: "Top Questions",
                ),
                FeatureCard(
                  onTap: (){context.pushNamed(MyAppRouteConstants.quizRouteName);},
                  icon: Icons.quiz_outlined,
                  title: "Daily Quiz",
                  subtitle: "Test Yourself",
                ),
                FeatureCard(
                  icon: Icons.bookmark_border,
                  title: "Bookmarks",
                  subtitle: "Saved Articles",
                ),
                FeatureCard(
                  icon: Icons.notifications_active_outlined,
                  title: "Notifications",
                  subtitle: "Latest Alerts",
                ),
              ],
            ),

            30.ph,

            Text(
              "Settings",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            15.ph,

            /// Your old Dark Mode widget
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: theme.colorScheme.outline.withOpacity(.15),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.dark_mode_outlined,
                    color: theme.colorScheme.primary,
                  ),
                  15.pw,
                  const Expanded(
                    child: Text(
                      "Dark Mode",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  BlocBuilder<Homebloc, Homestate>(
                    builder: (context, state) {
                      return Switch(
                        value: state.isSwitch,
                        onChanged: (newvalue) {
                          context.read<Homebloc>().add(ThemeSwitchEvent());

                          if (newvalue) {
                            context.read<ThemeBloc>().add(
                              ThemeChanged(theme: AppThemeMode.dark),
                            );
                          } else {
                            context.read<ThemeBloc>().add(
                              ThemeChanged(theme: AppThemeMode.light),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),

            30.ph,

            Text(
              "Latest Flutter News",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            15.ph,

            Card(
              elevation: 0,
              color: theme.colorScheme.surface,
              child: const ListTile(
                leading: CircleAvatar(child: Icon(Icons.newspaper)),
                title: Text("News will appear here"),
                subtitle: Text(
                  "Connect Firebase and display latest Flutter news.",
                ),
              ),
            ),

            25.ph,

            Text(
              "Latest Packages",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            15.ph,

            Card(
              elevation: 0,
              color: theme.colorScheme.surface,
              child: const ListTile(
                leading: CircleAvatar(child: Icon(Icons.inventory_2_outlined)),
                title: Text("Packages will appear here"),
                subtitle: Text("Newest packages from pub.dev"),
              ),
            ),

            50.ph,
          ],
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const FeatureCard({
    super.key,
    required this.icon,
    this.onTap,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: theme.colorScheme.outline.withOpacity(.12)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: theme.colorScheme.primary.withOpacity(.12),
                child: Icon(icon, color: theme.colorScheme.primary),
              ),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
