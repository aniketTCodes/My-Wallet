import 'package:flutter/material.dart';
import 'package:my_wallet/di/di.dart';
import 'package:my_wallet/domain/usecases/wallet_usecases.dart';
import 'package:my_wallet/presentation/components/create_wallet_view.dart';
import 'package:my_wallet/presentation/components/wallet_view.dart';
import 'package:my_wallet/presentation/provider/login_provider.dart';
import 'package:my_wallet/presentation/provider/wallet_provider.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  final void Function() logout;
  const HomeView({super.key, required this.logout});

  @override
  Widget build(BuildContext context) {
    final dto = context.read<LoginProvider>().getDto!;
    return ChangeNotifierProvider<WalletProvider>(
      create: (context) =>
          WalletProvider(dto: dto, usecase: getIt<WalletUsecase>())..init(),
      child: Consumer<WalletProvider>(
        builder: (context, value, child) {
          if (value.walletDto != null) {
            return const WalletView();
          }

          return CreateWalletView(logout: logout);
        },
      ),
    );
  }
}
