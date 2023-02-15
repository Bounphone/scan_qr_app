import 'dart:convert';

GetCheckInModel getCheckInModelFromJson(String str) =>
    GetCheckInModel.fromJson(json.decode(str));

String getCheckInModelToJson(GetCheckInModel data) =>
    json.encode(data.toJson());

class GetCheckInModel {
  GetCheckInModel({
    required this.status,
    required this.data,
  });

  String status;
  List<Data> data;

  factory GetCheckInModel.fromJson(Map<String, dynamic> json) =>
      GetCheckInModel(
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
    required this.qrId,
    required this.checkInDate,
    required this.userId,
    required this.lat,
    required this.long,
    required this.v,
  });

  String id;
  String qrId;
  DateTime checkInDate;
  String userId;
  int lat;
  int long;
  int v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        qrId: json["qrId"],
        checkInDate: DateTime.parse(json["checkInDate"]),
        userId: json["userId"],
        lat: json["lat"],
        long: json["long"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "qrId": qrId,
        "checkInDate": checkInDate.toIso8601String(),
        "userId": userId,
        "lat": lat,
        "long": long,
        "__v": v,
      };
}
