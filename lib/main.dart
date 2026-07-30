import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myflutter/modules/auth/login/google_Signin_bloc/google_signin_bloc.dart';
import 'package:myflutter/modules/auth/login/google_Signin_bloc/google_signin_repository.dart';
import 'package:myflutter/modules/auth/login/login_repository.dart';
import 'package:myflutter/modules/auth/login/loginbloc/login_bloc.dart';
import 'package:myflutter/modules/auth/reset_password/reset_passwordbloc/password_bloc.dart';
import 'package:myflutter/modules/home/homebloc/homebloc.dart';
import 'package:myflutter/modules/home/newsbloc/news_repository.dart';
import 'package:myflutter/modules/home/newsbloc/newsbloc.dart';
import 'package:myflutter/modules/home/quiz/bloc/quiz_bloc.dart';
import 'package:myflutter/modules/home/quiz/bloc/quiz_repository.dart';
import 'package:myflutter/routes/app_route_config.dart';
import 'package:myflutter/theme/bloctheme/bloc_theme_bloc.dart';

import 'modules/auth/reset_password/resetPasswordRepository.dart';
import 'modules/home/newsbloc/newsevent.dart';


void main()async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
runApp(const MainApp());
}

final GoRouter _router = MyAppRouter().router;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider(create: (context)=>LoginBloc(LoginRepository())),
        BlocProvider(
          create: (context) => Homebloc(),
        ),
        BlocProvider(
          create: (context) => NewsBloc(NewsRepository())
            ..add(FetchNewsEvent()),
        ),
        BlocProvider(
          create: (context) =>GoogleSigninBloc(GoogleSigninRepository())
        ),
        BlocProvider(
            create: (context) =>ResetPasswordBloc(Resetpasswordrepository())
        ),
        BlocProvider(
            create: (context) =>QuizBloc(QuizRepository())
        ),
      ],
      child: BlocBuilder<ThemeBloc,ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: state.themeData,
            routerConfig:_router
          );
        },
      ),
    );
  }
}
