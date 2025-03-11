import 'package:mirar/src/common/dio/dio_api.dart';
import 'package:mirar/src/features/profile/data/sign_in_services.dart';
import 'package:mirar/src/features/profile/models/dto/login_dto.dart';
import 'package:mirar/src/resources/constants.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class IAuthDataSources {
  Future<LoginDto> register(
      {required String username,
      required String password,
      required String email});
  Future<void> logout();
  Future<LoginDto> loginWithApple();
  Future<LoginDto> loginWithGoogle();
  String getSessionToken();
  Future<LoginDto> login({required String username, required String password});
  Future<LoginDto?> isActiveSession();
}

class NetworkAuthDataSources implements IAuthDataSources {
  final SharedPreferences _prefs;
  final ISignInServices _signInServices;

  const NetworkAuthDataSources(
      {required ISignInServices signInServices,
      required ApiProvider apiProvider,
      required SharedPreferences prefs})
      : _prefs = prefs,
        _signInServices = signInServices;
  Future<bool> isSessionValid(String sessionToken) async {
    final response = await ParseUser.getCurrentUserFromServer(sessionToken);
    return response?.success ?? false;
  }

  @override
  Future<LoginDto?> isActiveSession() async {
    try {
      final sessionToken = _prefs.getString(sessionTokenPrefsKey) ?? "";
      final currentUser = await ParseUser.currentUser() as ParseUser?;
      final isValid = await isSessionValid(sessionToken);
      if (currentUser != null && isValid) {
        print(currentUser.sessionToken);
        return LoginDto(
          createdAt: currentUser.createdAt.toString(),
          email: currentUser.emailAddress ?? "",
          username: currentUser.username ?? "",
          objectID: currentUser.objectId ?? "",
          sessionToken: currentUser.sessionToken ?? "",
        );
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LoginDto> login(
      {required String username, required String password}) async {
    try {
      final user = ParseUser(username, password, null);
      var response = await user.login();
      if (response.success) {
        final user = response.result as ParseUser;
        await _prefs.setString(sessionTokenPrefsKey, user.sessionToken!);
        return LoginDto.fromJson(user);
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      final token = _prefs.getString(sessionTokenPrefsKey);
      await _signInServices.logout(token!);
      await _prefs.remove(sessionTokenPrefsKey);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LoginDto> register({
    required String username,
    required String password,
    required String email,
  }) async {
    final user = ParseUser(username, password, email);

    try {
      print("start");
      final response = await user.signUp();
      print(response.error);
      if (response.success) {
        final user = response.result as ParseUser;
        final sessionToken = user.sessionToken ?? "";

        await _prefs.setString(sessionTokenPrefsKey, sessionToken);

        return LoginDto(
          createdAt: user.createdAt.toString(),
          email: email,
          username: username,
          objectID: user.objectId ?? "",
          sessionToken: sessionToken,
        );
      } else {
        throw Exception(response.error?.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  String getSessionToken() {
    return _prefs.getString(sessionTokenPrefsKey) ?? "";
  }

  @override
  Future<LoginDto> loginWithApple() async {
    try {
      final loginDto = await _signInServices.signInWithApple();
      await _prefs.setString(sessionTokenPrefsKey, loginDto.sessionToken);
      return loginDto;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LoginDto> loginWithGoogle() async {
    try {
      final loginDto = await _signInServices.signInWithGoogle();
      await _prefs.setString(sessionTokenPrefsKey, loginDto.sessionToken);
      return loginDto;
    } catch (e) {
      rethrow;
    }
  }
}
