import 'package:json_annotation/json_annotation.dart';

part 'auth_models.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String email;
  final String? name;

  User({
    required this.id,
    required this.email,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class LoginRequest {
  final String email;
  final String password;

  LoginRequest({
    required this.email,
    required this.password,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class SignupRequest {
  final String email;
  final String password;
  final String? name;

  SignupRequest({
    required this.email,
    required this.password,
    this.name,
  });

  factory SignupRequest.fromJson(Map<String, dynamic> json) => _$SignupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignupRequestToJson(this);
}

@JsonSerializable()
class AuthResponse {
  final String token;
  final User user;
  final String? message;

  AuthResponse({
    required this.token,
    required this.user,
    this.message,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
