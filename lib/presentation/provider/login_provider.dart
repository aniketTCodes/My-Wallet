import 'package:flutter/foundation.dart';
import 'package:my_wallet/domain/dto/login_dto.dart';
import 'package:my_wallet/domain/usecases/wallet_usecases.dart';

class LoginProvider extends ChangeNotifier {
  final WalletUsecase _usecase;
  String? _error;
  bool _isLoading = false;
  LoginDto? _dto;

  LoginProvider({required WalletUsecase usecase}) : _usecase = usecase;

  String? get error => _error;

  bool get isLoading => _isLoading;

  LoginDto? get getDto => _dto;

  void _setState(String? error, bool isLoading, LoginDto? dto) {
    _isLoading = isLoading;
    _error = error;
    _dto = dto;
    notifyListeners();
  }

  void checkLogin() async {
    _setState(null, true, getDto);
    final response = _usecase.checkLoggedInUseCase();

    if (!response) {
      _setState(null, false, getDto);
      return;
    }

    final dtoResponse = _usecase.getLoggedUserDetailUsecase();
    dtoResponse.fold((l) => _setState(l.message, false, null),
        (r) => _setState(null, false, r));
  }

  Future<void> login(String username, String password) async {
    _setState(null, true, getDto);

    final response = await _usecase.loginUsecase(username, password);
    
    response.fold((l) => _setState(l.message, false, null),
        (r) => _setState(null, false, r));
  }

  Future<void> logout() async {
    _setState(null, true, getDto);
    final response = await _usecase.logoutUsecase();
    response.fold((l) => _setState(l.message, false, null),
        (r) => _setState(null, false, null));
  }
}
