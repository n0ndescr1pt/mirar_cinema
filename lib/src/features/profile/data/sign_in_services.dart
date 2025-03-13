import 'package:google_sign_in/google_sign_in.dart';
import 'package:mirar/src/features/profile/models/dto/login_dto.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

abstract interface class ISignInServices {
  Future<LoginDto> signInWithGoogle();
  Future<LoginDto> signInWithApple();
  Future<void> logout(String sessionToken);
}

class SignInServices implements ISignInServices {
  static const String serverClientID =
      '144400670380-36eoventthda4t7ijp33ufr8sf2lqlhj.apps.googleusercontent.com';

  @override
  Future<LoginDto> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      serverClientId: serverClientID,
      scopes: [
        'email',
      ],
    );
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final String accessToken = googleAuth.accessToken!;
      final String idToken = googleAuth.idToken!;
      final ParseResponse parseResponse = await ParseUser.loginWith(
        'google',
        google(
          accessToken,
          googleUser.id,
          idToken,
        ),
        username: googleUser.displayName ?? "",
        email: googleUser.email,
      );

      if (parseResponse.success) {
        ParseUser user = parseResponse.result;
        final objectID = user.objectId ?? "";
        final username = googleUser.displayName ?? "";
        final email = googleUser.email;
        final createdAt = user.createdAt.toString();
        return LoginDto.fromParseUser(
            objectID: objectID,
            username: username,
            createdAt: createdAt,
            email: email,
            sessionToken: user.sessionToken!);
      } else {
        await GoogleSignIn().signOut();
        throw Exception("Something went wrong, try again");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LoginDto> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final user = await ParseUser.currentUser() as ParseUser?;
      await user?.logout();

      final ParseResponse parseResponse = await ParseUser.loginWith(
        'apple',
        apple(
          credential.identityToken!,
          credential.userIdentifier!,
        ),
        email: credential.email,
        username: credential.givenName,
      );
      if (parseResponse.success) {
        ParseUser user = parseResponse.result;

        final objectID = user.objectId ?? "";
        final username = credential.givenName ?? "";
        final email = credential.email ?? "";
        final createdAt = user.createdAt.toString();
        return LoginDto.fromParseUser(
            objectID: objectID,
            username: username,
            createdAt: createdAt,
            email: email,
            sessionToken: user.sessionToken!);
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<void> logout(String sessionToken) async {
    final currentUser = await ParseUser.getCurrentUserFromServer(sessionToken);
    ParseUser? user = currentUser?.result;
    user?.logout(deleteLocalUserData: true);
    await GoogleSignIn().signOut();
  }
}
