import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:myflutter/theme/app_theme.dart';

part 'bloc_theme_event.dart';
part 'bloc_theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeData:appThemeData[AppThemeMode.light]!)) {
    on<ThemeEvent>((event, emit) {
     if(event is ThemeChanged){
       emit.call(ThemeState(themeData: appThemeData[event.theme]!));
     }
    });
  }
}
