// To parse this JSON data, do
//
//     final airdropModel = airdropModelFromJson(jsonString);

import 'dart:convert';

AirdropModel airdropModelFromJson(String str) => AirdropModel.fromJson(json.decode(str));

String airdropModelToJson(AirdropModel data) => json.encode(data.toJson());

class AirdropModel {
    String message;
    String status;

    AirdropModel({
        required this.message,
        required this.status,
    });

    factory AirdropModel.fromJson(Map<String, dynamic> json) => AirdropModel(
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
    };
}
