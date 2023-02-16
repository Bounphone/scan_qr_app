import 'dart:convert';

GetMyQrModel getMyQrModelFromJson(String str) => GetMyQrModel.fromJson(json.decode(str));

String getMyQrModelToJson(GetMyQrModel data) => json.encode(data.toJson());

class GetMyQrModel {
    GetMyQrModel({
        required this.status,
        required this.data,
    });

    String status;
    List<Datum> data;

    factory GetMyQrModel.fromJson(Map<String, dynamic> json) => GetMyQrModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        required this.id,
        required this.name,
        required this.qrCode,
        required this.createdBy,
        required this.latitude,
        required this.longtitude,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    String id;
    String name;
    String qrCode;
    String createdBy;
    dynamic latitude;
    dynamic longtitude;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        name: json["name"],
        qrCode: json["qrCode"],
        createdBy: json["createdBy"],
        latitude: json["latitude"],
        longtitude: json["longtitude"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "qrCode": qrCode,
        "createdBy": createdBy,
        "latitude": latitude,
        "longtitude": longtitude,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
