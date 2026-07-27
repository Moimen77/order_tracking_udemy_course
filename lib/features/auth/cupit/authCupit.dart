import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_google_maps_example/core/utils/app_status.dart';
import 'package:practical_google_maps_example/features/auth/cupit/authStates.dart';
import 'package:practical_google_maps_example/features/auth/repo/AuthRepo.dart';

class Authcupit extends Cubit<LoginState> {
  Authcupit(super.initialState, {required this.repo});
  final AuthRepo repo;
  Future<void> login(String email, String password) async {
    emit(state.copyWith(status: AppStatus.loading));
    try {
      final fun = await repo.signInWithEmailAndPassword(email, password);

      fun.fold(
        (error) {
          emit(state.copyWith(status: AppStatus.failure, errorMessage: error));
        },
        (userCredential) {
          emit(state.copyWith(status: AppStatus.success));
        },
      );
    } catch (e) {
      // If an error occurs, emit an error state with the error message
      emit(state.copyWith(
          status: AppStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> signUp(String email, String password) async {
    emit(state.copyWith(status: AppStatus.loading));
    try {
      final fun = await repo.signUpWithEmailAndPassword(email, password);

      fun.fold(
        (error) {
          emit(state.copyWith(status: AppStatus.failure, errorMessage: error));
        },
        (userCredential) {
          emit(state.copyWith(status: AppStatus.success));
        },
      );
    } catch (e) {
      // If an error occurs, emit an error state with the error message
      emit(state.copyWith(
          status: AppStatus.failure, errorMessage: e.toString()));
    }
  }
}
