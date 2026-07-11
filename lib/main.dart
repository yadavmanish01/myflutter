import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myflutter/modules/home/homebloc/homebloc.dart';
import 'package:myflutter/routes/app_route_config.dart';
import 'package:myflutter/theme/bloctheme/bloc_theme_bloc.dart';


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
        BlocProvider(
          create: (context) => Homebloc(),
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
