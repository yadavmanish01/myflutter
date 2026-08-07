import 'package:equatable/equatable.dart';

abstract class SignupState extends Equatable{
  const SignupState({this.email,this.password});
  final String? email;
  final String? password;
}