import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class EmailChanged extends LoginEvent {
  final String email;

  const EmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class PasswordChanged extends LoginEvent {
  final String password;

  const PasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class ShowPassword extends LoginEvent {
  const ShowPassword();
}

class LoginApi extends LoginEvent {
  const LoginApi();
}


class LogoutApi extends LoginEvent{
  const LogoutApi();
}