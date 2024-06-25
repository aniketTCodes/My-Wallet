import 'package:flutter/material.dart';
import 'package:my_wallet/di/di.dart';
import 'package:my_wallet/domain/usecases/wallet_usecases.dart';
import 'package:my_wallet/presentation/provider/login_provider.dart';
import 'package:my_wallet/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider<LoginProvider>(
        create: (context) =>
            LoginProvider(usecase: getIt<WalletUsecase>())..checkLogin(),
        child: const HomeScreen(),
      ),
    );
  }
}
