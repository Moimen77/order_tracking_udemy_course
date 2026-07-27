import 'package:practical_google_maps_example/core/utils/app_status.dart';

class LoginState {
  final AppStatus status;
  final String? errorMessage;

  const LoginState({
    this.status = AppStatus.initial,
    this.errorMessage,
  });

  LoginState copyWith({
    AppStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}
