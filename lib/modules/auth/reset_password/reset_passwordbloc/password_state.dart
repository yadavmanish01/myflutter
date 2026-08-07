import 'package:equatable/equatable.dart';
import 'package:myflutter/utils/enum.dart';

class ResetPasswordStates extends Equatable {
  final String email;
  final PostApiStatus postApiStatus;
  final String message;

  const ResetPasswordStates({
    this.email = '',
    this.postApiStatus = PostApiStatus.INITIAL,
    this.message = '',
  });

  ResetPasswordStates copyWith({
    String? email,
    PostApiStatus? emailStatus,
    String? message,
  }) {
    return ResetPasswordStates(
      email: email ?? this.email,
      postApiStatus: emailStatus ?? postApiStatus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    email,
    postApiStatus,
    message,
  ];
}