part of 'bloc_theme_bloc.dart';
class ThemeState extends Equatable {
final ThemeData themeData;
  const ThemeState({required this.themeData});

  @override
  // TODO: implement props
  List<Object?> get props => [themeData];
}

