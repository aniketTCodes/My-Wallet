import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:my_wallet/common/painter.dart';
import 'package:my_wallet/presentation/provider/login_provider.dart';
import 'package:my_wallet/presentation/provider/wallet_provider.dart';
import 'package:provider/provider.dart';

class CreateWalletView extends StatefulWidget {
  final void Function() logout;
  const CreateWalletView({super.key, required this.logout});

  @override
  State<CreateWalletView> createState() => _CreateWalletViewState();
}

class _CreateWalletViewState extends State<CreateWalletView> {
  final TextEditingController _walletNameController = TextEditingController();
  final TextEditingController _walletPinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 8, right: 8),
          child: Column(
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.wallet,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Create Wallet",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Buy tokens right after learning about them, send those tokens or NFT’s to a friend in DM’s. On Socialverse you get a crypto wallet to interface, collect, and hold your items as you go through the Socialverse.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: const GradientBoxBorder(
                    gradient: LinearGradient(
                      colors: [color1, color2, color3, color4],
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      controller: _walletNameController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        label: Text(
                          "Wallet's Name",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      controller: _walletPinController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        label: Text(
                          "Pin",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      width: double.infinity,
                      child: Builder(
                        builder: (context) {
                          if (context.read<WalletProvider>().isLoading) {
                            return const SizedBox(
                              height: 30,
                              width: 30,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: color1,
                                ),
                              ),
                            );
                          }
                          return FloatingActionButton(
                            onPressed: () async {
                              await context.read<WalletProvider>().createWallet(
                                  _walletNameController.text,
                                  _walletPinController.text);
                              if (context.mounted) {
                                if (context
                                        .read<WalletProvider>()
                                        .errorMessage !=
                                    null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(context
                                          .read<WalletProvider>()
                                          .errorMessage!),
                                    ),
                                  );
                                }
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(
                                  colors: [color1, color2, color3, color4],
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  "Create Wallet",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text:
                            "If you are not ${context.read<WalletProvider>().loginDto.firstName} ${context.read<WalletProvider>().loginDto.lastName}? ",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: "Logout",
                        style: const TextStyle(
                          color: color1,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.read<LoginProvider>().logout();
                          },
                      )
                    ]))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
