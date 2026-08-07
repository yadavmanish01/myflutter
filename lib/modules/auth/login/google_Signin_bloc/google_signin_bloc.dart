import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../utils/enum.dart';
import 'google_signin_repository.dart';

part 'google_signin_event.dart';
part 'google_signin_state.dart';

class GoogleSigninBloc
    extends Bloc<GoogleSigninEvent, GoogleSigninState> {
  final GoogleSigninRepository repository;

  GoogleSigninBloc(this.repository)
      : super(const GoogleSigninState()) {
    on<GoogleSignInApi>(_googleSignin);
  }

  Future<void> _googleSignin(
      GoogleSignInApi event,
      Emitter<GoogleSigninState> emit,
      ) async {
    emit(
      state.copyWith(
        loginStatus: PostApiStatus.LOADING,
      ),
    );

    try {
      await repository.googleSignIn();

      emit(
        state.copyWith(
          loginStatus: PostApiStatus.COMPLETED,
          message: "Google Login Successful",
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          loginStatus: PostApiStatus.ERROR,
          message: e.message ?? "Google Login Failed",
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