import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myflutter/modules/auth/login/google_Signin_bloc/google_signin_bloc.dart';
import 'package:myflutter/modules/auth/login/google_Signin_bloc/google_signin_repository.dart';
import 'package:myflutter/modules/auth/login/login_repository.dart';
import 'package:myflutter/modules/auth/login/loginbloc/login_bloc.dart';
import 'package:myflutter/modules/auth/reset_password/reset_passwordbloc/password_bloc.dart';
import 'package:myflutter/modules/home/bookmarks/bloc/bookmarks_bloc.dart';
import 'package:myflutter/modules/home/bookmarks/bookmarks_repository.dart';
import 'package:myflutter/modules/home/homebloc/homebloc.dart';
import 'package:myflutter/modules/home/newsbloc/news_repository.dart';
import 'package:myflutter/modules/home/newsbloc/newsbloc.dart';
import 'package:myflutter/modules/home/packages/bloc/packages_bloc.dart';
import 'package:myflutter/modules/home/packages/pub_repository/pub_repository.dart';
import 'package:myflutter/modules/home/quiz/bloc/quiz_bloc.dart';
import 'package:myflutter/modules/home/quiz/bloc/quiz_repository.dart';
import 'package:myflutter/routes/app_route_config.dart';
import 'package:myflutter/theme/bloctheme/bloc_theme_bloc.dart';

import 'modules/auth/reset_password/resetPasswordRepository.dart';
import 'modules/home/newsbloc/newsevent.dart';
import 'modules/home/packages/bloc/packages_event.dart';
import 'modules/home/packages/firestore_repository/firestore_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(const MainApp());
}

final GoRouter _router = MyAppRouter().router;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => LoginBloc(LoginRepository())),
        BlocProvider(create: (context) => Homebloc()),
        BlocProvider(
          create: (context) =>
              NewsBloc(NewsRepository())..add(FetchNewsEvent()),
        ),
        BlocProvider(
          create: (context) => GoogleSigninBloc(GoogleSigninRepository()),
        ),
        BlocProvider(
          create: (context) => ResetPasswordBloc(Resetpasswordrepository()),
        ),
        BlocProvider(create: (context) => QuizBloc(QuizRepository())),
        BlocProvider(
          create: (context) {
            print('PACKAGE BLOC CREATED');

            final bloc = PackageBloc(
              firestoreRepository: PackageFirestoreRepository(),
              pubRepository: PackagePubRepository(),
            );

            print('ADDING LOAD PACKAGES EVENT');

            bloc.add(const LoadPackagesEvent());

            return bloc;
          },
        ),
        BlocProvider(create: (context) => BookmarkBloc(repository: BookmarkRepository())),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: state.themeData,
            routerConfig: _router,
          );
        },
      ),
    );
  }
}
