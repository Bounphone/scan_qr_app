import 'dart:convert';

MyQrModel myQrModelFromJson(String str) => MyQrModel.fromJson(json.decode(str));

String myQrModelToJson(MyQrModel data) => json.encode(data.toJson());

class MyQrModel {
    MyQrModel({
        required this.status,
        required this.data,
    });

    String status;
    List<Data> data;

    factory MyQrModel.fromJson(Map<String, dynamic> json) => MyQrModel(
        status: json["status"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Data {
    Data({
        required this.id,
        required this.name,
        required this.qrCode,
        required this.createdBy,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    String id;
    String name;
    String qrCode;
    String createdBy;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        name: json["name"],
        qrCode: json["qrCode"],
        createdBy: json["createdBy"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "qrCode": qrCode,
        "createdBy": createdBy,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
