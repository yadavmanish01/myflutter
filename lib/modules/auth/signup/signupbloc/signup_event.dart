import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable{
  const SignupEvent();
}

class EmailFieldEvent extends SignupEvent{
  final String email;
  EmailFieldEvent({required this.email});

  @override
  // TODO: implement props
  List<Object?> get props =>[email];
}

class PasswordFieldEvent extends SignupEvent{
  final String password;
  PasswordFieldEvent({required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [password];}

class ShowPasswordEvent extends SignupEvent {
  final bool showPassword;

  const ShowPasswordEvent({this.showPassword = false});

  @override
  List<Object?> get props => [showPassword];
}