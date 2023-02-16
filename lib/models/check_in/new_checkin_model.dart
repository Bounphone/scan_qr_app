import 'dart:convert';

NewCheckInModel newCheckInModelFromJson(String str) => NewCheckInModel.fromJson(json.decode(str));

String newCheckInModelToJson(NewCheckInModel data) => json.encode(data.toJson());

class NewCheckInModel {
    NewCheckInModel({
        required this.status,
        required this.data,
    });

    String status;
    Data data;

    factory NewCheckInModel.fromJson(Map<String, dynamic> json) => NewCheckInModel(
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
        required this.qrId,
        required this.checkInDate,
        required this.userId,
        required this.latitude,
        required this.longtitude,
        required this.id,
        required this.v,
    });

    String qrId;
    DateTime checkInDate;
    String userId;
    dynamic latitude;
    dynamic longtitude;
    String id;
    int v;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        qrId: json["qrId"],
        checkInDate: DateTime.parse(json["checkInDate"]),
        userId: json["userId"],
        latitude: json["latitude"],
        longtitude: json["longtitude"],
        id: json["_id"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "qrId": qrId,
        "checkInDate": checkInDate.toIso8601String(),
        "userId": userId,
        "latitude": latitude,
        "longtitude": longtitude,
        "_id": id,
        "__v": v,
    };
}
