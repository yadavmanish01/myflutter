import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myflutter/modules/auth/login/loginView.dart';
import 'package:myflutter/modules/auth/signup/signup.dart';
import 'package:myflutter/modules/home/home.dart';
import 'package:myflutter/modules/home/newsbloc/view/news_view.dart';
import 'package:myflutter/modules/splash/splashView.dart';
import '../widgets/simpleErrorPage.dart';
import 'app_route_constant.dart';

class MyAppRouter {
  GoRouter router = GoRouter(
    errorPageBuilder: (context, state) {
      return MaterialPage(child: SimpleErrorPage());
    },
    routes: [
      GoRoute(
        name: MyAppRouteConstants.splashRouteName,
        path: '/',
        pageBuilder: (context, state) {
          return MaterialPage(child: Splashview());
        },
      ),
      GoRoute(
        name: MyAppRouteConstants.homeRouteName,
        path: '/home',
        pageBuilder: (context, state) {
          return MaterialPage(child: HomePage());
        },
      ),
      GoRoute(
        name: MyAppRouteConstants.loginRouteName,
        path: '/login',
        pageBuilder: (context, state) {
          return MaterialPage(child: Loginview());
        },
      ),
      GoRoute(
        name: MyAppRouteConstants.signupRouteName,
        path: '/signup',
        pageBuilder: (context, state) {
          return MaterialPage(child: SignupPage());
        },
      ),
      GoRoute(
        name: MyAppRouteConstants.NewsScreenRouteName,
        path: '/newsScreen',
        pageBuilder: (context, state) {
          return MaterialPage(child: NewsScreen());
        },
      ),
    ],
  );
}
