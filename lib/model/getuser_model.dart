// To parse this JSON data, do
//
//     final getusermodel = getusermodelFromJson(jsonString);

import 'dart:convert';

Getusermodel getusermodelFromJson(String str) => Getusermodel.fromJson(json.decode(str));

String getusermodelToJson(Getusermodel data) => json.encode(data.toJson());

class Getusermodel {
  Getusermodel({
    this.success,
    this.data,
    this.adminData,
  });

  bool? success;
  Data? data;
  Data? adminData;

  factory Getusermodel.fromJson(Map<String, dynamic> json) => Getusermodel(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    adminData: json["adminData"] == null ? null : Data.fromJson(json["adminData"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data!.toJson(),
    "adminData": adminData == null ? null : adminData!.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.password,
    this.createdAt,
    this.updatedAt,
    this.latitude,
    this.longitude,
    this.status,
    this.mobile,
  });

  String? id;
  String? firstName;
  String? lastName;
  String? email;
  int? phone;
  String? password;
  DateTime? createdAt;
  DateTime? updatedAt;
  double? latitude;
  double? longitude;
  Status? status;
  int? mobile;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"] == null ? null : json["_id"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    email: json["email"] == null ? null : json["email"],
    phone: json["phone"] == null ? null : json["phone"],
    password: json["password"] == null ? null : json["password"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    mobile: json["mobile"] == null ? null : json["mobile"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "firstName": firstName == null ? null : firstName,
    "lastName": lastName == null ? null : lastName,
    "email": email == null ? null : email,
    "phone": phone == null ? null : phone,
    "password": password == null ? null : password,
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "status": status == null ? null : status!.toJson(),
    "mobile": mobile == null ? null : mobile,
  };
}

class Status {
  Status({
    this.name,
    this.modificationDate,
  });

  String? name;
  DateTime? modificationDate;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    name: json["name"] == null ? null : json["name"],
    modificationDate: json["modificationDate"] == null ? null : DateTime.parse(json["modificationDate"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "modificationDate": modificationDate == null ? null : modificationDate!.toIso8601String(),
  };
}
