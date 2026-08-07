import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myflutter/modules/auth/login/loginbloc/login_event.dart';
import 'package:myflutter/modules/auth/login/loginbloc/login_state.dart';
import '../../../../utils/enum.dart';
import '../login_repository.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;

  LoginBloc(this.repository) : super(const LoginState()) {
    on<EmailChanged>(_emailChanged);
    on<PasswordChanged>(_passwordChanged);
    on<ShowPassword>(_showPassword);
    on<LoginApi>(_loginApi);
    on<LogoutApi>(_logoutApi);
  }

  void _emailChanged(
      EmailChanged event,
      Emitter<LoginState> emit,
      ) {
    emit(state.copyWith(email: event.email));
  }

  void _passwordChanged(
      PasswordChanged event,
      Emitter<LoginState> emit,
      ) {
    emit(state.copyWith(password: event.password));
  }

  void _showPassword(
      ShowPassword event,
      Emitter<LoginState> emit,
      ) {
    emit(
      state.copyWith(
        showPassword: !state.showPassword,
      ),
    );
  }

  Future<void> _loginApi(
      LoginApi event,
      Emitter<LoginState> emit,
      ) async {
    emit(
      state.copyWith(
        loginStatus: PostApiStatus.LOADING,
      ),
    );

    try {
      await repository.loginApi(
        email: state.email.trim(),
        password: state.password.trim(),
      );

      emit(
        state.copyWith(
          loginStatus: PostApiStatus.COMPLETED,
          message: "Login Successful",
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          loginStatus: PostApiStatus.ERROR,
          message: e.message ?? "Login Failed",
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loginStatus: PostApiStatus.ERROR,
          message: e.toString(),
        ),
      );
    }
  }

  void _logoutApi(LogoutApi event, Emitter<LoginState> emit,)async{
    emit(state.copyWith(loginStatus: PostApiStatus.LOADING,));
    try {
      await repository.logoutApi(
      );

      emit(
        state.copyWith(
          loginStatus: PostApiStatus.COMPLETED,
          message: "Logout Successful",
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          loginStatus: PostApiStatus.ERROR,
          message: e.message ?? "Logout Failed",
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loginStatus: PostApiStatus.ERROR,
          message: e.toString(),
        ),
      );
    }
  }
}