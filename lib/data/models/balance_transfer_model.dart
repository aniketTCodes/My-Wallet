// To parse this JSON data, do
//
//     final balanceTransferModel = balanceTransferModelFromJson(jsonString);

import 'dart:convert';

BalanceTransferModel balanceTransferModelFromJson(String str) => BalanceTransferModel.fromJson(json.decode(str));

String balanceTransferModelToJson(BalanceTransferModel data) => json.encode(data.toJson());

class BalanceTransferModel {
    String status;
    String message;
    String transactionId;

    BalanceTransferModel({
        required this.status,
        required this.message,
        required this.transactionId,
    });

    factory BalanceTransferModel.fromJson(Map<String, dynamic> json) => BalanceTransferModel(
        status: json["status"],
        message: json["message"],
        transactionId: json["transaction_id"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "transaction_id": transactionId,
    };
}
