part of 'auth_bloc.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.login({required LoginModel loginModel}) = _LoginState;
  const factory AuthState.loggedOut() = _LoggedOutState;
  const factory AuthState.error() = _ErrorLoginState;
  const factory AuthState.registrationError({required int? code}) = _ErrorRegistrationState;
  const factory AuthState.initial() = _InitialAuthState;
  const factory AuthState.loading() = _Loading;
}
