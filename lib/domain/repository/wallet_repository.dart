import 'package:dartz/dartz.dart';
import 'package:my_wallet/common/faliure.dart';
import 'package:my_wallet/data/models/airdrop_model.dart';
import 'package:my_wallet/data/models/balance_model.dart';
import 'package:my_wallet/data/models/balance_transfer_model.dart';
import 'package:my_wallet/data/models/create_wallet_model.dart';
import 'package:my_wallet/data/models/local_storage_model.dart';
import 'package:my_wallet/data/models/login_model.dart';
import 'package:my_wallet/domain/dto/login_dto.dart';
import 'package:my_wallet/domain/dto/wallet_dto.dart';

abstract class WalletRepository{

  Future<Either<Faliure,Login>> login(String username,String password);
  Future<Either<Faliure,CreateWallet>> createWallet(String walletName,String pin, String key);
  Future<Either<Faliure,BalanceModel>> getBalance(String walletAddress,String key);
  Future<Either<Faliure,BalanceTransferModel>> transferBalance(String recipientAddress,String senderAddress,int amount,String pin, String key);
  Future<Either<Faliure,AirdropModel>> requestAirdrop(String address,double amount,String key);
  Either<Faliure,LocalStorageModel> getUser();
  Either<Faliure,LoginDto> getLoggedUserData();
  Future<Either<Faliure,void>> persistLoginData(Login model);
  Future<Either<Faliure,void>> persistWalletData(CreateWallet model);
  bool isLoggedIn();
  bool isWalletCreated();
  Either<Faliure,String> getToken();
  Future<Either<Faliure,void>> clearData();
  Either<Faliure,WalletDto> getSavedWalletData();
}