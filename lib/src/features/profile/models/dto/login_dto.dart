import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mirar/src/features/profile/models/login_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

part 'login_dto.g.dart';

@JsonSerializable()
class LoginDto {
  @JsonKey(name: "objectId")
  final String objectID;
  @JsonKey(name: "username")
  final String username;
  @JsonKey(name: "email", defaultValue: "")
  final String email;
  @JsonKey(name: "createdAt")
  final String createdAt;
  @JsonKey(name: "sessionToken", includeFromJson: true)
  final String sessionToken;

  LoginDto({
    required this.sessionToken,
    required this.objectID,
    required this.username,
    required this.email,
    required this.createdAt,
  });

  factory LoginDto.fromJson(ParseUser user) {
    return LoginDto(
        sessionToken: user.sessionToken ?? "",
        objectID: user.objectId ?? "",
        username: user.username ?? "",
        email: user.emailAddress ?? "",
        createdAt: user.createdAt.toString());
  }

  Map<String, dynamic> toJson() => _$LoginDtoToJson(this);

  static LoginModel toModel({required LoginDto dto}) {
    return LoginModel(
      objectID: dto.objectID,
      username: dto.username,
      email: dto.email,
      createdAt: dto.createdAt,
    );
  }

  factory LoginDto.fromParseUser(
      {required String objectID,
      required String username,
      required String email,
      required String createdAt,
      required String sessionToken}) {
    return LoginDto(
      objectID: objectID,
      username: username,
      email: email,
      createdAt: createdAt,
      sessionToken: sessionToken,
    );
  }
}
