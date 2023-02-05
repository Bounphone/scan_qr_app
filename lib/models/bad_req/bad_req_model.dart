import 'dart:convert';

BadReqModel badReqModelFromJson(String str) => BadReqModel.fromJson(json.decode(str));

String badReqModelToJson(BadReqModel data) => json.encode(data.toJson());

class BadReqModel {
  BadReqModel({
    this.code,
    this.message,
    this.success,
    this.detail,
  });

  String? code;
  String? message;
  bool? success;
  String? detail;

  factory BadReqModel.fromJson(Map<String, dynamic> json) => BadReqModel(
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
