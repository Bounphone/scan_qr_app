import 'dart:convert';

TokenModel? tokenModelFromJson(String str) => TokenModel.fromJson(json.decode(str));

String tokenModelToJson(TokenModel? data) => json.encode(data!.toJson());

class TokenModel {
  TokenModel({
    this.code,
    this.message,
    this.success,
    this.detail,
    this.username,
    this.accessToken,
    this.expire,
    this.refreshToken,
    this.password,
  });

  String? code;
  String? message;
  bool? success;
  String? detail;
  String? username;
  String? accessToken;
  int? expire;
  String? refreshToken;
  String? password;

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
    code: json["code"],
    message: json["message"],
    success: json["success"],
    detail: json["detail"],
    username: json["username"],
    accessToken: json["accessToken"],
    expire: json["expire"],
    refreshToken: json["refreshToken"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "success": success,
    "detail": detail,
    "username": username,
    "accessToken": accessToken,
    "expire": expire,
    "refreshToken": refreshToken,
    "password": password,
  };
}
