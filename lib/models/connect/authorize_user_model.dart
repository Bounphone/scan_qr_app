import 'dart:convert';

AuthorizeUserModel authorizeUserModelFromJson(String str) => AuthorizeUserModel.fromJson(json.decode(str));

String authorizeUserModelToJson(AuthorizeUserModel data) => json.encode(data.toJson());

class AuthorizeUserModel {
  AuthorizeUserModel({
    this.code,
    this.message,
    this.success,
    this.detail,
  });

  String? code;
  String? message;
  bool? success;
  String? detail;

  factory AuthorizeUserModel.fromJson(Map<String, dynamic> json) => AuthorizeUserModel(
    code: json["code"],
    message: json["message"],
    success: json["success"],
    detail: json["detail"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "success": success,
    "detail": detail,
  };
}
