import 'package:my_wallet/common/exception.dart';
import 'package:my_wallet/common/storage_keys.dart';
import 'package:my_wallet/data/models/create_wallet_model.dart';
import 'package:my_wallet/data/models/local_storage_model.dart';
import 'package:my_wallet/data/models/login_model.dart';
import 'package:my_wallet/di/di.dart';
import 'package:my_wallet/domain/dto/login_dto.dart';
import 'package:my_wallet/domain/dto/wallet_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  final SharedPreferences prefs;

  LocalDataSource({required this.prefs});

  Future<void> persistLoginData(Login model) async {
    try {
      await prefs.setString(usernameKey, model.username);
      await prefs.setString(firstNameKey, model.firstName);
      await prefs.setString(lastNameKey, model.lastName);
      await prefs.setString(emailKey, model.email);
      await prefs.setString(tokenKey, model.token);
      await prefs.setBool(isVerifiedKey, model.isVerified);
      await prefs.setString(profilePictureKey, model.profilePictureUrl);
      await prefs.setBool(isLoggedInKey, true);
    } on Exception {
      throw const MyException(message: "Persistence Error");
    }
  }

  bool isLoggedIn() {
    return prefs.getBool(isLoggedInKey) ?? false;
  }

  bool isWalletCreated() => prefs.getBool(isWalletCreatedKey) ?? false;

  Future<void> persistWalletDetails(CreateWallet model) async {
    try {
      await prefs.setString(walletNameKey, model.walletName);
      await prefs.setString(publicKey, model.publicKey);
      await prefs.setString(secretKey, model.secretKey);
      await prefs.setBool(isWalletCreatedKey, true);
    } on Exception {
      throw const MyException(message: "Persistence Error");
    }
  }

  LocalStorageModel getUser() {
    try {
      final username = prefs.getString(usernameKey);
      final firstName = prefs.getString(firstNameKey);
      final lastName = prefs.getString(lastNameKey);
      final email = prefs.getString(emailKey);
      final token = prefs.getString(tokenKey);
      final isVerified = prefs.getBool(isVerifiedKey);
      final walletName = prefs.getString(walletNameKey);
      final prefpublicKey = prefs.getString(publicKey);
      final prefsecretKey = prefs.getString(secretKey);
      final profilePictureUrl = prefs.getString(profilePictureKey);

      return LocalStorageModel(
          username: username!,
          firstName: firstName!,
          lastName: lastName!,
          email: email!,
          token: token!,
          isVerified: isVerified!,
          walletName: walletName!,
          publicKey: prefpublicKey!,
          secretKey: prefsecretKey!,
          profilePictureUrl: profilePictureUrl!);
    } catch (e) {
      throw MyException(message: e.runtimeType.toString());
    }
  }

  String getToken() {
    try {
      return prefs.getString(tokenKey)!;
    } on Exception {
      throw const MyException(message: "User Not logged In");
    }
  }

  LoginDto getLoggedUserData() {
    try {
      return LoginDto(
          username: prefs.getString(usernameKey)!,
          firstName: prefs.getString(firstNameKey)!,
          lastName: prefs.getString(lastNameKey)!,
          email: prefs.getString(emailKey)!,
          profilePictureUrl: prefs.getString(profilePictureKey)!);
    } on Exception {
      throw const MyException(message: "Error reading Login Data");
    }
  }

  WalletDto getSavedWalletData() {
    try {
      return WalletDto(
        walletAddress: prefs.getString(publicKey)!,
        walletName: prefs.getString(walletNameKey)!,
      );
    } on Exception {
      throw const MyException(message: "Error reading wallet data");
    }
  }

  Future<void> clearData() async {
    try {
      await prefs.remove(usernameKey);
      await prefs.remove(firstNameKey);
      await prefs.remove(lastNameKey);
      await prefs.remove(emailKey);
      await prefs.remove(tokenKey);
      await prefs.remove(isVerifiedKey);
      await prefs.remove(profilePictureKey);
      await prefs.remove(walletNameKey);
      await prefs.remove(publicKey);
      await prefs.remove(secretKey);
      await prefs.setBool(isWalletCreatedKey, false);
      await prefs.setBool(isLoggedInKey, false);
    } on Exception {
      throw const MyException(message: "Persistence Error");
    }
  }
}
