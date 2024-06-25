import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_wallet/common/painter.dart';
import 'package:my_wallet/presentation/components/request_airdrop_dialogue_view.dart';
import 'package:my_wallet/presentation/components/transfer_funds_dialogue_view.dart';
import 'package:my_wallet/presentation/provider/login_provider.dart';
import 'package:my_wallet/presentation/provider/wallet_provider.dart';
import 'package:provider/provider.dart';

class WalletView extends StatefulWidget {
  const WalletView({super.key});

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  @override
  Widget build(BuildContext context) {
    final walletDto = context.read<WalletProvider>().walletDto!;
    final loginDto = context.read<WalletProvider>().loginDto;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => context.read<LoginProvider>().logout(),
              icon: const Icon(Icons.logout))
        ],
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    loginDto.profilePictureUrl,
                  ),
                ),
              ),
            ),
            Text(
              " Welcome ${loginDto.firstName}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [color1, color2, color3, color4],
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.wallet,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        walletDto.walletName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Balance :",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Consumer<WalletProvider>(
                        builder: (context, value, child) {
                          {
                            if (context.read<WalletProvider>().isLoading) {
                              return const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (context.read<WalletProvider>().balance !=
                                null) {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "${context.read<WalletProvider>().balance!}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        context
                                            .read<WalletProvider>()
                                            .getBalance(
                                                walletDto.walletAddress);
                                      },
                                      icon: const Icon(
                                        Icons.refresh,
                                        color: Colors.white,
                                      ))
                                ],
                              );
                            }
                            return RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Get Balance",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        await context
                                            .read<WalletProvider>()
                                            .getBalance(
                                                walletDto.walletAddress);

                                        if (context.mounted) {
                                          if (context
                                                  .read<WalletProvider>()
                                                  .errorMessage !=
                                              null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                backgroundColor: Colors.red,
                                                content: Text(
                                                  context
                                                      .read<WalletProvider>()
                                                      .errorMessage!,
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        "Address : ${walletDto.walletAddress.substring(0, 8)}....${walletDto.walletAddress.substring(walletDto.walletAddress.length - 2)}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await Clipboard.setData(
                              ClipboardData(text: walletDto.walletAddress));
                          Fluttertoast.showToast(msg: "Copied to clipboard");
                        },
                        icon: const Icon(
                          size: 16,
                          Icons.copy,
                          color: Colors.white,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 8, right: 8),
                  width: (MediaQuery.of(context).size.width - 64) * 0.5,
                  child: FloatingActionButton(
                    onPressed: () async {
                      await context
                          .read<WalletProvider>()
                          .getBalance(walletDto.walletAddress);
                      if (context.mounted &&
                          context.read<WalletProvider>().balance != null) {
                        final provider =
                            Provider.of<WalletProvider>(context, listen: false);
                        showDialog(
                          context: context,
                          builder: (context) {
                            return TransferFundDialogue(
                                walletAddress: walletDto.walletAddress,
                                provider: provider);
                          },
                        );
                      }
                    },
                    child: const Text('Transfer Funds'),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8, right: 8),
                  width: (MediaQuery.of(context).size.width - 64) * 0.5,
                  child: FloatingActionButton(
                    onPressed: () {
                      final provider =
                          Provider.of<WalletProvider>(context, listen: false);
                      showDialog(
                        context: context,
                        builder: (context) =>
                            RequestAirdropDialogue(provider: provider),
                      );
                    },
                    child: const Text('Request Airdrop'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
