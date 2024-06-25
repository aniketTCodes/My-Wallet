// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  String status;
  int balance;
  String token;
  String username;
  String email;
  String firstName;
  String lastName;
  bool isVerified;
  String role;
  String ownerId;
  String walletAddress;
  bool hasWallet;
  DateTime lastLogin;
  String profilePictureUrl;

  Login({
    required this.status,
    required this.balance,
    required this.token,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.isVerified,
    required this.role,
    required this.ownerId,
    required this.walletAddress,
    required this.hasWallet,
    required this.lastLogin,
    required this.profilePictureUrl,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    status: json["status"],
    balance: json["balance"],
    token: json["token"],
    username: json["username"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    isVerified: json["isVerified"],
    role: json["role"],
    ownerId: json["owner_id"],
    walletAddress: json["wallet_address"],
    hasWallet: json["has_wallet"],
    lastLogin: DateTime.parse(json["last_login"]),
    profilePictureUrl: json["profile_picture_url"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "balance": balance,
    "token": token,
    "username": username,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "isVerified": isVerified,
    "role": role,
    "owner_id": ownerId,
    "wallet_address": walletAddress,
    "has_wallet": hasWallet,
    "last_login": lastLogin.toIso8601String(),
    "profile_picture_url": profilePictureUrl,
  };
}
