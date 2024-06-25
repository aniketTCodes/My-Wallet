import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_wallet/common/painter.dart';
import 'package:my_wallet/presentation/provider/wallet_provider.dart';

class TransferFundDialogue extends StatefulWidget {
  final String walletAddress;
  final WalletProvider provider;
  const TransferFundDialogue(
      {super.key, required this.walletAddress, required this.provider});

  @override
  State<TransferFundDialogue> createState() => _TransferFundDialogueState();
}

class _TransferFundDialogueState extends State<TransferFundDialogue> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _senderAddressController =
      TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      title: const Text(
        "Funds Transfer",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            textInputAction: TextInputAction.next,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            controller: _senderAddressController,
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
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.wallet,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Recipient Address",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            controller: _amountController,
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
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.money,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Amount",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            obscureText: true,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            controller: _pinController,
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
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Pin",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: const LinearGradient(
                colors: [color1, color2, color3, color4],
              ),
            ),
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              onPressed: () async {
                final result = await widget.provider.transferFund(
                  _senderAddressController.text,
                  _pinController.text,
                  _amountController.text.isEmpty
                      ? 0
                      : int.parse(_amountController.text),
                );
                if (result != null && result.status == "success") {
                  Fluttertoast.showToast(msg: result.message);
                } else {
                  if (context.mounted && widget.provider.errorMessage != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(widget.provider.errorMessage!),
                      ),
                    );
                    Navigator.pop(context);
                  }
                }
              },
              child: const Text(
                "Transfer Funds",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
