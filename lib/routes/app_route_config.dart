import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myflutter/modules/auth/login/loginView.dart';
import 'package:myflutter/modules/home/home.dart';
import '../widgets/simpleErrorPage.dart';
import 'app_route_constant.dart';

class MyAppRouter {
  GoRouter router = GoRouter(
    errorPageBuilder: (context, state) {
      return MaterialPage(child: SimpleErrorPage());
    },
    routes: [
      GoRoute(name:  MyAppRouteConstants.loginRouteName,
      path: '/',
      pageBuilder: (context,state){return MaterialPage(child: Loginview());}),
      GoRoute(
        name: MyAppRouteConstants.splashRouteName,
        path: '/home',
        pageBuilder: (context, state) {
          return MaterialPage(child: HomePage());
        },
      ),
    ],
  );
}
