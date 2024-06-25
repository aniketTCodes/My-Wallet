// To parse this JSON data, do
//
//     final createWallet = createWalletFromJson(jsonString);

import 'dart:convert';

CreateWallet createWalletFromJson(String str) => CreateWallet.fromJson(json.decode(str));

String createWalletToJson(CreateWallet data) => json.encode(data.toJson());

class CreateWallet {
    String status;
    String message;
    String walletName;
    String userPin;
    String network;
    String publicKey;
    String secretKey;

    CreateWallet({
        required this.status,
        required this.message,
        required this.walletName,
        required this.userPin,
        required this.network,
        required this.publicKey,
        required this.secretKey,
    });

    factory CreateWallet.fromJson(Map<String, dynamic> json) => CreateWallet(
        status: json["status"],
        message: json["message"],
        walletName: json["walletName"],
        userPin: json["userPin"],
        network: json["network"],
        publicKey: json["publicKey"],
        secretKey: json["secretKey"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "walletName": walletName,
        "userPin": userPin,
        "network": network,
        "publicKey": publicKey,
        "secretKey": secretKey,
    };
}
