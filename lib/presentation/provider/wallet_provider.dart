import 'package:flutter/foundation.dart';
import 'package:my_wallet/data/models/airdrop_model.dart';
import 'package:my_wallet/data/models/balance_transfer_model.dart';
import 'package:my_wallet/domain/dto/login_dto.dart';
import 'package:my_wallet/domain/dto/wallet_dto.dart';
import 'package:my_wallet/domain/usecases/wallet_usecases.dart';

class WalletProvider extends ChangeNotifier {
  final LoginDto _loginDto;
  final WalletUsecase _usecase;
  String? _error;
  bool _isLoading = false;
  WalletDto? _walletDto;
  int? _balance;

  WalletProvider({required LoginDto dto, required WalletUsecase usecase})
      : _loginDto = dto,
        _usecase = usecase;

  String? get errorMessage => _error;
  bool get isLoading => _isLoading;
  LoginDto get loginDto => _loginDto;
  WalletDto? get walletDto => _walletDto;
  int? get balance => _balance;

  void _setState(
      String? errorMessage, bool isLoading, WalletDto? dto, int? balance) {
    _isLoading = isLoading;
    _walletDto = dto;
    _error = errorMessage;
    _balance = balance;

    notifyListeners();
  }

  void init() {
    _setState(null, true, walletDto, balance);
    if (_usecase.checkisWalletCreatedUsecase()) {
      final walletResponse = _usecase.getSavedWalletDetailUsecase();
      walletResponse.fold((l) => _setState(l.message, false, null, balance),
          (r) => _setState(null, false, r, balance));
    } else {
      _setState(null, false, null, balance);
    }
  }

  Future<void> createWallet(String walletName, String pin) async {
    _setState(null, true, walletDto, balance);
    final response = await _usecase.createWallet(walletName, pin);
    response.fold((l) => _setState(l.message, false, null, balance),
        (r) => _setState(null, false, r, balance));
  }

  Future<void> getBalance(String walletAddress) async {
    _setState(null, true, walletDto, balance);
    final response = await _usecase.getBalance(walletAddress);
    response.fold((l) => _setState(l.message, false, walletDto, balance),
        (r) => _setState(null, false, walletDto, r));
  }

  Future<BalanceTransferModel?> transferFund(
      String recipientAddress, String pin, int amount) async {
    if (recipientAddress.isEmpty) {
      _setState(
          "Recipient Address can not be empty", isLoading, walletDto, balance);
      return null;
    }
    if (pin.isEmpty) {
      _setState("Pin cannot be emoty", isLoading, walletDto, balance);
      return null;
    }
    if (amount > balance!) {
      _setState("Not enough funds", isLoading, walletDto, balance);
      return null;
    }
    final response = await _usecase.transferBalance(
        walletDto!.walletAddress, recipientAddress, pin, amount);
    return response.fold((l) {
      _setState(l.message, isLoading, walletDto, balance);
      return null;
    }, (r) => r);
  }

  Future<AirdropModel?> requestAirDrop(String address, String amount) async {
    _setState(null, true, walletDto, balance);
    final result = await _usecase.requestAirdrop(address, double.parse(amount));
    return result.fold((l) {
      _setState(l.message, false, walletDto, balance);
      return null;
    }, (r) {
      _setState(null, false, walletDto, balance);
      return r;
    });
  }
}
