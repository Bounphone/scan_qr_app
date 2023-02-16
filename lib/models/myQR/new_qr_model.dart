import 'dart:convert';

NewQrModel newQrModelFromJson(String str) => NewQrModel.fromJson(json.decode(str));

String newQrModelToJson(NewQrModel data) => json.encode(data.toJson());

class NewQrModel {
    NewQrModel({
        required this.status,
        required this.data,
    });

    String status;
    Data data;

    factory NewQrModel.fromJson(Map<String, dynamic> json) => NewQrModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        required this.name,
        required this.qrCode,
        required this.createdBy,
        required this.latitude,
        required this.longtitude,
        required this.id,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    String name;
    String qrCode;
    String createdBy;
    dynamic latitude;
    dynamic longtitude;
    String id;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        qrCode: json["qrCode"],
        createdBy: json["createdBy"],
        latitude: json["latitude"],
        longtitude: json["longtitude"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "qrCode": qrCode,
        "createdBy": createdBy,
        "latitude": latitude,
        "longtitude": longtitude,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
