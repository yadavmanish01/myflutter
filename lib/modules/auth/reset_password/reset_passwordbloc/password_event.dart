import 'package:equatable/equatable.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object?> get props => [];
}

class PasswordchangeEvent extends ResetPasswordEvent {
  final String password;

  const PasswordchangeEvent({required this.password});

  @override
  List<Object?> get props => [password];
}

class ForgetpasswordApi extends ResetPasswordEvent {
  const ForgetpasswordApi();

  @override
  List<Object?> get props => [];
}