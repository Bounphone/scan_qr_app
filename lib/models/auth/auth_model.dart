import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
    AuthModel({
        required this.status,
        required this.token,
    });

    String status;
    String token;

    factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        status: json["status"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "token": token,
    };
}
