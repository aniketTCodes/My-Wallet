import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:my_wallet/common/faliure.dart';
import 'package:my_wallet/data/models/airdrop_model.dart';
import 'package:my_wallet/data/models/balance_transfer_model.dart';
import 'package:my_wallet/data/models/create_wallet_model.dart';
import 'package:my_wallet/data/models/login_model.dart';
import 'package:my_wallet/di/di.dart';
import 'package:my_wallet/domain/dto/login_dto.dart';
import 'package:my_wallet/domain/dto/wallet_dto.dart';
import 'package:my_wallet/domain/repository/wallet_repository.dart';

class WalletUsecase {
  final WalletRepository repo = getIt<WalletRepository>();

  bool checkLoggedInUseCase() {
    return repo.isLoggedIn();
  }

  bool checkisWalletCreatedUsecase() {
    return repo.isWalletCreated();
  }

  //Call login endpoint and persist login details
  Future<Either<Faliure, LoginDto>> loginUsecase(
      String username, String password) async {
    final result = await repo.login(username, password);
    Login? model;
    Faliure? f;
    result.fold(
      (l) {
        f = l;
      },
      (r) {
        model = r;
      },
    );
    if (model == null) {
      return Left(f!);
    }
    final persistenceResult = await repo.persistLoginData(model!);
    persistenceResult.fold((l) {
      return Left(l);
    }, (r) => null);
    return Right(
      LoginDto(
          username: username,
          firstName: model!.firstName,
          lastName: model!.lastName,
          email: model!.email,
          profilePictureUrl: model!.profilePictureUrl),
    );
  }

  //Get LoginDto from storage
  Either<Faliure, LoginDto> getLoggedUserDetailUsecase() {
    return repo.getLoggedUserData();
  }

  Future<Either<Faliure, void>> logoutUsecase() async {
    final response = await repo.clearData();
    return response.fold((l) => Left(l), (r) => Right(r));
  }

  Either<Faliure, WalletDto> getSavedWalletDetailUsecase() {
    return repo.getSavedWalletData();
  }

  Future<Either<Faliure, WalletDto>> createWallet(
      String walletName, String pin) async {
    if (walletName.isEmpty || pin.isEmpty) {
      return Left(Faliure(message: "Fill all required fields"));
    }
    final tokenResponse = repo.getToken();
    Faliure? tokenFaliure;
    String? token;
    tokenResponse.fold((l) => tokenFaliure = l, (r) => token = r);
    if (token == null) {
      return Left(tokenFaliure!);
    }
    final walletResponse = await repo.createWallet(walletName, pin, token!);
    Faliure? createWalletFaliure;
    CreateWallet? walletModel;
    walletResponse.fold((l) => createWalletFaliure = l, (r) => walletModel = r);
    if (walletModel == null) {
      return Left(createWalletFaliure!);
    }

    final persistWalletResult = await repo.persistWalletData(walletModel!);
    Faliure? persistenceFaliure;
    persistWalletResult.fold((l) => persistenceFaliure = l, (r) => null);
    if (persistenceFaliure != null) {
      return Left(persistenceFaliure!);
    }
    return getSavedWalletDetailUsecase();
  }

  Future<Either<Faliure, int>> getBalance(String walletAddress) async {
    final tokenResponse = repo.getToken();
    Faliure? tokenFaliure;
    String? token;
    tokenResponse.fold((l) => tokenFaliure = l, (r) => token = r);
    if (token == null) {
      return Left(tokenFaliure!);
    }

    final balanceResponse = await repo.getBalance(walletAddress, token!);

    return balanceResponse.fold((l) => Left(l), (r) => Right(r.balance));
  }

  Future<Either<Faliure, BalanceTransferModel>> transferBalance(
      String walletAddress,
      String senderAddress,
      String pin,
      int amount) async {
    final tokenResponse = repo.getToken();
    Faliure? tokenFaliure;
    String? token;
    tokenResponse.fold((l) => tokenFaliure = l, (r) => token = r);
    if (token == null) {
      return Left(tokenFaliure!);
    }
    final balanceTransferResponse = await repo.transferBalance(
        senderAddress, walletAddress, amount, pin, token!);
    return balanceTransferResponse.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<Faliure, AirdropModel>> requestAirdrop(
      String address, double amount) async {
    final tokenResponse = repo.getToken();
    Faliure? tokenFaliure;
    String? token;
    tokenResponse.fold((l) => tokenFaliure = l, (r) => token = r);
    if (token == null) {
      return Left(tokenFaliure!);
    }
    final requestAirDropResponse =
        await repo.requestAirdrop(address, amount, token!);
    return requestAirDropResponse.fold((l) => Left(l), (r) => Right(r));
  }
}
