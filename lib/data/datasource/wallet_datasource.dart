import 'package:my_wallet/data/models/airdrop_model.dart';
import 'package:my_wallet/data/models/balance_model.dart';
import 'package:my_wallet/data/models/balance_transfer_model.dart';
import 'package:my_wallet/data/models/create_wallet_model.dart';
import 'package:my_wallet/data/models/login_model.dart';

abstract class WalletDataSource{
Future<Login> login(String username,String password);
Future<CreateWallet> createWallet(String walletName,String pin,String key);
Future<BalanceModel> getBalance(String key,String walletAddress);
Future<BalanceTransferModel> transferBalance(String recipientAddress,String senderAddress,String pin, int amount, String key);
Future<AirdropModel> requestAirdrop(String address, double amount, String key);
}