import 'dart:convert';

AccessTokenModel accessTokenModelFromJson(String str) => AccessTokenModel.fromJson(json.decode(str));

String accessTokenModelToJson(AccessTokenModel data) => json.encode(data.toJson());

class AccessTokenModel {
    AccessTokenModel({
        required this.id,
        required this.email,
        required this.firstname,
        required this.surname,
        required this.photo,
        required this.role,
        required this.iat,
        required this.exp,
    });

    String id;
    String email;
    String firstname;
    String surname;
    String photo;
    String role;
    int iat;
    int exp;

    factory AccessTokenModel.fromJson(Map<String, dynamic> json) => AccessTokenModel(
        id: json["id"],
        email: json["email"],
        firstname: json["firstname"],
        surname: json["surname"],
        photo: json["photo"],
        role: json["role"],
        iat: json["iat"],
        exp: json["exp"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "firstname": firstname,
        "surname": surname,
        "photo": photo,
        "role": role,
        "iat": iat,
        "exp": exp,
    };
}
