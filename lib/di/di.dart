import 'package:get_it/get_it.dart';
import 'package:my_wallet/data/datasource/local_datasource.dart';
import 'package:my_wallet/data/datasource/remote_datasource.dart';
import 'package:my_wallet/data/datasource/wallet_datasource.dart';
import 'package:my_wallet/data/repository/wallet_repository.dart';
import 'package:my_wallet/domain/repository/wallet_repository.dart';
import 'package:my_wallet/domain/usecases/wallet_usecases.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupInjection() async {
  getIt.registerLazySingleton<WalletDataSource>(
    () => RemoteDataSource(),
  );
  getIt.registerSingletonAsync<SharedPreferences>(()  {
    return SharedPreferences.getInstance();
  });
  await getIt.isReady<SharedPreferences>();
  getIt.registerLazySingleton<LocalDataSource>(
      () => LocalDataSource(prefs: getIt<SharedPreferences>()));
  getIt.registerLazySingleton<WalletRepository>(() => WalletRepositoryImpl());
  getIt.registerLazySingleton<WalletUsecase>(() => WalletUsecase());
}
