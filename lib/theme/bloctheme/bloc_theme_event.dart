part of 'bloc_theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeChanged extends ThemeEvent{
  final AppThemeMode theme;
  ThemeChanged({required this.theme});


  @override
  // TODO: implement props
  List<Object?> get props => [theme];}
