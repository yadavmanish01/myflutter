import 'package:equatable/equatable.dart';
import '../../../../utils/enum.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final bool showPassword;
  final PostApiStatus postApiStatus;
  final String message;

  const LoginState({
    this.email = '',
    this.password = '',
    this.showPassword = true,
    this.postApiStatus = PostApiStatus.INITIAL,
    this.message = '',
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? showPassword,
    PostApiStatus? loginStatus,
    String? message,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      showPassword: showPassword ?? this.showPassword,
      postApiStatus: loginStatus ?? this.postApiStatus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    showPassword,
    postApiStatus,
    message,
  ];
}