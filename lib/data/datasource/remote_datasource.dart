import 'dart:convert';
import 'dart:io';
import 'package:my_wallet/common/api_endpoints.dart';
import 'package:my_wallet/common/exception.dart';
import 'package:my_wallet/data/datasource/wallet_datasource.dart';
import 'package:my_wallet/data/models/airdrop_model.dart';
import 'package:my_wallet/data/models/balance_model.dart';
import 'package:my_wallet/data/models/balance_transfer_model.dart';
import 'package:my_wallet/data/models/create_wallet_model.dart';
import 'package:my_wallet/data/models/login_model.dart';
import 'package:http/http.dart' as http;
import "dart:developer" as dev show log;

class RemoteDataSource implements WalletDataSource {
  static const unknownErrorMessage = "Something went wrong";
  @override
  Future<CreateWallet> createWallet(
      String walletName, String pin, String key) async {
    try {
      final response = await http.post(
          Uri.parse(baseUrl + createWalletEndpoint),
          headers: <String, String>{
            HttpHeaders.contentTypeHeader: "application/json",
            "Flic-Token": key
          },
          body: jsonEncode(<String, String>{
            "wallet_name": walletName,
            "network": "devnet",
            "user_pin": pin
          }));
      dev.log(response.body);

      final decodedValue = jsonDecode(response.body) as Map<String, dynamic>;
      if (decodedValue['status'] == "error") {
        throw MyException(message: decodedValue["message"]);
      }
      return CreateWallet.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } on MyException {
      rethrow;
    } on Exception {
      throw const MyException(message: unknownErrorMessage);
    }
  }

  @override
  Future<BalanceModel> getBalance(String key, String walletAddress) async {
    try {
      final queryParameters = <String, String>{
        "network": "devnet",
        "wallet_address": walletAddress
      };
      final response = await http.get(
        Uri.parse(
            "$baseUrl$getBalanceEndpoint?network=devnet&wallet_address=$walletAddress"),
        headers: {"Flic-Token": key},
      );

      dev.log(response.body);

      final decodedValue = jsonDecode(response.body) as Map<String, dynamic>;
      if (decodedValue['status'] == "error") {
        throw MyException(message: decodedValue["message"]);
      }
      return BalanceModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } on MyException {
      rethrow;
    } on Exception {
      throw const MyException(message: unknownErrorMessage);
    }
  }

  @override
  Future<Login> login(String username, String password) async {
    try {
      final response = await http.post(Uri.parse(baseUrl + loginEndpoint),
          headers: {HttpHeaders.contentTypeHeader: "application/json"},
          body: jsonEncode(
              <String, String>{"mixed": username, "password": password}));
      dev.log(response.body);
      if (response.statusCode != 200) {
        throw MyException(message: "Request error code ${response.statusCode}");
      }

      final decodedValue = jsonDecode(response.body) as Map<String, dynamic>;
      if (decodedValue['status'] == "error") {
        throw MyException(message: decodedValue["message"]);
      }
      return Login.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } on MyException {
      rethrow;
    } on Exception {
      throw const MyException(message: unknownErrorMessage);
    }
  }

  @override
  Future<BalanceTransferModel> transferBalance(String recipientAddress,
      String senderAddress, String pin, int amount, String key) async {
    try {
      final response = await http.post(
          Uri.parse(baseUrl + balanceTransferEndpoint),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            "Flic-Token": key
          },
          body: jsonEncode(<String, dynamic>{
            "recipient_address": recipientAddress,
            "network": "devnet",
            "sender_address": senderAddress,
            "amount": amount,
            "user_pin": pin
          }));
      dev.log(response.body);

      final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (decodedResponse["success"] != null &&
          decodedResponse["success"] == "failed") {
        throw MyException(message: decodedResponse["message"]);
      }
      return BalanceTransferModel.fromJson(decodedResponse);
    } on MyException {
      rethrow;
    } on Exception {
      throw const MyException(message: unknownErrorMessage);
    }
  }

  @override
  Future<AirdropModel> requestAirdrop(
      String address, double amount, String key) async {
    try {
      final response = await http.post(
          Uri.parse(baseUrl + requestAirDropEndpoint),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            "Flic-Token": key,
          },
          body: jsonEncode(<String, dynamic>{
            "wallet_address": address,
            "network": "devnet",
            "amount": amount
          }));
      dev.log(response.body);

      return airdropModelFromJson(response.body);
    } on MyException {
      rethrow;
    } on Exception {
      throw const MyException(message: unknownErrorMessage);
    }
  }
}
