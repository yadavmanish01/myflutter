import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myflutter/modules/home/homebloc/homebloc.dart';
import 'package:myflutter/routes/app_route_config.dart';
import 'package:myflutter/theme/bloctheme/bloc_theme_bloc.dart';


void main() {
  runApp(const MainApp());
}

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
      child: MaterialApp.router(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.light,
        routerConfig: MyAppRouter().router,
      ),
    );
  }
}
