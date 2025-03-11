part of 'auth_bloc.dart';

@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.login({
    required String username,
    required String password,
  }) = _LoginEvent;
  const factory AuthEvent.register(
      {required String username,
      required String password,
      required String email}) = _RegisterEvent;
  const factory AuthEvent.logout() = _LogoutEvent;
  const factory AuthEvent.init() = _InitEvent;
  const factory AuthEvent.loginWithGoogle() = _LoginWithGoogleEvent;
  const factory AuthEvent.loginWithApple() = _LoginWithAppleEvent;
  const factory AuthEvent.checkSession() = _CheckSessionEvent;
  const factory AuthEvent.changeCurrentUser({required LoginModel currentModel,required String userID}) =
      _ChangeCurrentUserEvent;
}
