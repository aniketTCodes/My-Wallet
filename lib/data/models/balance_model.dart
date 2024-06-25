// To parse this JSON data, do
//
//     final balanceModel = balanceModelFromJson(jsonString);

import 'dart:convert';

BalanceModel balanceModelFromJson(String str) => BalanceModel.fromJson(json.decode(str));

String balanceModelToJson(BalanceModel data) => json.encode(data.toJson());

class BalanceModel {
    String status;
    String message;
    int balance;

    BalanceModel({
        required this.status,
        required this.message,
        required this.balance,
    });

    factory BalanceModel.fromJson(Map<String, dynamic> json) => BalanceModel(
        status: json["status"],
        message: json["message"],
        balance: json["balance"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "balance": balance,
    };
}
