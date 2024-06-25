import 'package:dartz/dartz.dart';
import 'package:my_wallet/common/exception.dart';
import 'package:my_wallet/common/faliure.dart';
import 'package:my_wallet/data/datasource/local_datasource.dart';
import 'package:my_wallet/data/datasource/wallet_datasource.dart';
import 'package:my_wallet/data/models/airdrop_model.dart';
import 'package:my_wallet/data/models/balance_model.dart';
import 'package:my_wallet/data/models/balance_transfer_model.dart';
import 'package:my_wallet/data/models/create_wallet_model.dart';
import 'package:my_wallet/data/models/local_storage_model.dart';
import 'package:my_wallet/data/models/login_model.dart';
import 'package:my_wallet/di/di.dart';
import 'package:my_wallet/domain/dto/login_dto.dart';
import 'package:my_wallet/domain/dto/wallet_dto.dart';
import 'package:my_wallet/domain/repository/wallet_repository.dart';

class WalletRepositoryImpl implements WalletRepository {
  final WalletDataSource remote = getIt<WalletDataSource>();
  final LocalDataSource local = getIt<LocalDataSource>();

  @override
  Future<Either<Faliure, Login>> login(String username, String password) async {
    try {
      return Right(await remote.login(username, password));
    } on MyException catch (e) {
      return Left(Faliure(message: e.message));
    }
  }

  @override
  Future<Either<Faliure, CreateWallet>> createWallet(
      String walletName, String pin, String key) async {
    try {
      return Right(await remote.createWallet(walletName, pin, key));
    } on MyException catch (e) {
      return Left(Faliure(message: e.message));
    }
  }

  @override
  Future<Either<Faliure, BalanceModel>> getBalance(
      String key, String walletAddress) async {
    try {
      return Right(await remote.getBalance(walletAddress, key));
    } on MyException catch (e) {
      return Left(Faliure(message: e.message));
    }
  }

  @override
  Future<Either<Faliure, AirdropModel>> requestAirdrop(
      String address, double amount, String key) async {
    try {
      return Right(await remote.requestAirdrop(address, amount, key));
    } on MyException catch (e) {
      return Left(Faliure(message: e.message));
    }
  }

  @override
  Future<Either<Faliure, BalanceTransferModel>> transferBalance(
      String recipientAddress,
      String senderAddress,
      int amount,
      String pin,
      String key) async {
    try {
      return Right(await remote.transferBalance(
          recipientAddress, senderAddress, pin, amount, key));
    } on MyException catch (e) {
      return Left(Faliure(message: e.message));
    }
  }

  @override
  Either<Faliure, LocalStorageModel> getUser() {
    try {
      return Right(local.getUser());
    } on MyException {
      return Left(Faliure(message: "No user"));
    }
  }

  @override
  bool isLoggedIn() {
    return local.isLoggedIn();
  }

  @override
  bool isWalletCreated() {
    return local.isWalletCreated();
  }

  @override
  Future<Either<Faliure, void>> persistLoginData(Login model) async {
    try {
      return Right(await local.persistLoginData(model));
    } on MyException catch (e) {
      return Left(Faliure(message: e.message));
    }
  }

  @override
  Future<Either<Faliure, void>> persistWalletData(CreateWallet model) async {
    try {
      return Right(await local.persistWalletDetails(model));
    } on MyException catch (e) {
      return Left(Faliure(message: e.message));
    }
  }

  @override
  Either<Faliure, String> getToken() {
    try {
      return Right(local.getToken());
    } on MyException catch (e) {
      return Left(Faliure(message: e.message));
    }
  }

  @override
  Either<Faliure, LoginDto> getLoggedUserData() {
    try {
      return Right(local.getLoggedUserData());
    } on MyException catch (e) {
      return Left(Faliure(message: e.message));
    }
  }

  @override
  Future<Either<Faliure, void>> clearData() async {
    try {
      return Right(await local.clearData());
    } on MyException catch (e) {
      return Left(Faliure(message: e.message));
    }
  }

  @override
  Either<Faliure, WalletDto> getSavedWalletData() {
    try {
      return Right(local.getSavedWalletData());
    } on MyException catch (e) {
      return Left(Faliure(message: e.message));
    }
  }
}
