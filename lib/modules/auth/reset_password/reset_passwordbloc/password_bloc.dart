import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myflutter/modules/auth/reset_password/resetPasswordRepository.dart';
import 'package:myflutter/modules/auth/reset_password/reset_passwordbloc/password_event.dart';
import 'package:myflutter/modules/auth/reset_password/reset_passwordbloc/password_state.dart';
import 'package:myflutter/utils/enum.dart';

class ResetPasswordBloc
    extends Bloc<ResetPasswordEvent, ResetPasswordStates> {
  final Resetpasswordrepository repository;

  ResetPasswordBloc(this.repository)
      : super( ResetPasswordStates()) {
    on<PasswordchangeEvent>(_passwordChanged);
    on<ForgetpasswordApi>(_forgetPasswordApi);
  }

  void _passwordChanged(
      PasswordchangeEvent event,
      Emitter<ResetPasswordStates> emit,
      ) {
    emit(
      state.copyWith(
        email: event.password,
      ),
    );
  }

  Future<void> _forgetPasswordApi(
      ForgetpasswordApi event,
      Emitter<ResetPasswordStates> emit,
      ) async {
    emit(
      state.copyWith(
        emailStatus: PostApiStatus.LOADING,
      ),
    );

    try {
      await repository.ForgetPasswordApi(
        email: state.email.trim(),
      );

      emit(
        state.copyWith(
          emailStatus: PostApiStatus.COMPLETED,
          message: "Password reset email sent successfully.",
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          emailStatus: PostApiStatus.ERROR,
          message: e.message ?? "Failed to send reset email.",
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          emailStatus: PostApiStatus.ERROR,
          message: e.toString(),
        ),
      );
    }
  }
}