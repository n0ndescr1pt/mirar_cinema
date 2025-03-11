import 'package:mirar/src/features/profile/data/data_sources/auth_data_sources.dart';
import 'package:mirar/src/features/profile/models/dto/login_dto.dart';
import 'package:mirar/src/features/profile/models/login_model.dart';

abstract interface class IAuthRepository {
  Future<LoginModel> register(
      {required String username,
      required String password,
      required String email});
  Future<LoginModel> loginWithApple();
  Future<LoginModel> loginWithGoogle();
  Future<void> logout();
  Future<LoginModel> login(
      {required String username, required String password});
  Future<LoginModel?> isActiveSession();
  String getSessionToken();
}

class AuthRepository implements IAuthRepository {
  final IAuthDataSources _networkAuthDataSources;

  AuthRepository({
    required IAuthDataSources networkAuthDataSources,
  }) : _networkAuthDataSources = networkAuthDataSources;

  @override
  Future<LoginModel?> isActiveSession() async {
    try {
      final dto = await _networkAuthDataSources.isActiveSession();

      return dto == null ? null : LoginDto.toModel(dto: dto);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LoginModel> login(
      {required String username, required String password}) async {
    try {
      final dto = await _networkAuthDataSources.login(
          username: username, password: password);
      return LoginDto.toModel(dto: dto);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _networkAuthDataSources.logout();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LoginModel> register(
      {required String username,
      required String password,
      required String email}) async {
    try {
      final dto = await _networkAuthDataSources.register(
          username: username, password: password, email: email);
      return LoginDto.toModel(dto: dto);
    } catch (e) {
      rethrow;
    }
  }

  @override
  String getSessionToken() {
    return _networkAuthDataSources.getSessionToken();
  }

  @override
  Future<LoginModel> loginWithApple() async {
    try {
      final dto = await _networkAuthDataSources.loginWithApple();
      return LoginDto.toModel(dto: dto);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LoginModel> loginWithGoogle() async {
    try {
      final dto = await _networkAuthDataSources.loginWithGoogle();
      return LoginDto.toModel(dto: dto);
    } catch (e) {
      rethrow;
    }
  }
}
