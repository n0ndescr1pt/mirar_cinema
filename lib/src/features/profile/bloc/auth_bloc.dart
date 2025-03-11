import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mirar/src/common/dio/dio_exceptions.dart';
import 'package:mirar/src/features/profile/data/auth_repository.dart';
import 'package:mirar/src/features/profile/models/login_model.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authRepository;
  final Talker _talker;
  AuthBloc({
    required IAuthRepository authRepository,
    required Talker talker,
  })  : _authRepository = authRepository,
        _talker = talker,
        super(const AuthState.initial()) {
    on<_LoginEvent>(_onLogin);
    on<_RegisterEvent>(_onRegister);
    on<_LogoutEvent>(_onLogout);
    on<_CheckSessionEvent>(_onCheckSession);
    on<_LoginWithAppleEvent>(_onLoginWithApple);
    on<_LoginWithGoogleEvent>(_onLoginWithGoogle);
  }

  _onLogin(_LoginEvent event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final loginModel = await _authRepository.login(
          username: event.username, password: event.password);
      emit(AuthState.login(loginModel: loginModel));
    } catch (e) {
      _talker.error("AuthBloc _onLogin", e);
      emit(const AuthState.error());
    }
  }

  _onLoginWithApple(_LoginWithAppleEvent event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final loginModel = await _authRepository.loginWithApple();
      emit(AuthState.login(loginModel: loginModel));
    } catch (e) {
      _talker.error("AuthBloc  _LoginWithAppleEvent", e);
      emit(const AuthState.error());
    }
  }

  _onLoginWithGoogle(
      _LoginWithGoogleEvent event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final loginModel = await _authRepository.loginWithGoogle();
      emit(AuthState.login(loginModel: loginModel));
    } catch (e) {
      _talker.error("AuthBloc_LoginWithGoogleEvent", e);
      emit(const AuthState.error());
    }
  }

  _onRegister(_RegisterEvent event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final loginModel = await _authRepository.register(
          username: event.username,
          password: event.password,
          email: event.email);
      emit(AuthState.login(loginModel: loginModel));
    } on BadRequestException catch (e) {
      emit(AuthState.registrationError(code: e.code));
    } catch (e) {
      _talker.error("AuthBloc _onRegister", e);
      emit(const AuthState.registrationError(code: null));
    }
  }

  _onLogout(_LogoutEvent event, Emitter<AuthState> emit) async {
    try {
      await _authRepository.logout();
      emit(const AuthState.loggedOut());
    } catch (e) {
      _talker.error("AuthBloc _onLogout", e);
      emit(const AuthState.error());
    }
  }

  _onCheckSession(_CheckSessionEvent event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {

      final loginModel = await _authRepository.isActiveSession();
      if (loginModel != null) {
        emit(AuthState.login(loginModel: loginModel));
      } else {
        emit(const AuthState.loggedOut());
      }
    } catch (e) {
      _talker.error("AuthBloc _onCheckSession", e);
      emit(const AuthState.loggedOut());
    }
  }
}
