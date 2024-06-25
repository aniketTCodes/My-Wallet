import 'package:flutter/material.dart';
import 'package:my_wallet/presentation/components/home_view.dart';
import 'package:my_wallet/presentation/components/login_view.dart';
import 'package:my_wallet/presentation/provider/login_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, value, child) {
        if (value.getDto == null) {
          return LoginView(
            isLoading: value.isLoading,
            onPressed: (username, password) async {
              await value.login(username, password);
              if (value.error != null) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(value.error!),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
          );
        }

        return HomeView(
          logout: () async {
            await value.logout();
            if (value.error != null) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(value.error!),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          },
        );
      },
    );
  }
}
