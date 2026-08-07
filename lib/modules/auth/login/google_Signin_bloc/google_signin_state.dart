part of 'google_signin_bloc.dart';

class GoogleSigninState extends Equatable {
  final PostApiStatus loginStatus;
  final String message;


  const GoogleSigninState({
    this.loginStatus = PostApiStatus.INITIAL,
    this.message = '',
  });

  GoogleSigninState copyWith({
    PostApiStatus? loginStatus,
    String? message,
  }) {
    return GoogleSigninState(
      loginStatus: loginStatus ?? this.loginStatus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    loginStatus,
    message,
  ];
}