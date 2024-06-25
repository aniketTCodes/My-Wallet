import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_wallet/common/painter.dart';
import 'package:my_wallet/presentation/provider/wallet_provider.dart';

class RequestAirdropDialogue extends StatefulWidget {
  final WalletProvider provider;
  const RequestAirdropDialogue({super.key, required this.provider});

  @override
  State<RequestAirdropDialogue> createState() => _RequestAirdropDialogueState();
}

class _RequestAirdropDialogueState extends State<RequestAirdropDialogue> {
  final _addressController = TextEditingController();
  final _amountController = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    _addressController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      title: const Text(
        "Request Airdrop",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            textInputAction: TextInputAction.next,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            controller: _addressController,
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
                    "Address",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          TextField(
            textInputAction: TextInputAction.done,
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
            height: 16,
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
                if (!_isLoading) {
                  setState(() {
                    _isLoading = true;
                  });
                  final result = await widget.provider.requestAirDrop(
                      _addressController.text, _amountController.text);
                  setState(() {
                    _isLoading = false;
                  });
                  if (context.mounted && result != null) {
                    Fluttertoast.showToast(msg: result.message);
                  }
                  if (context.mounted && widget.provider.errorMessage != null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(widget.provider.errorMessage!),
                      backgroundColor: Colors.red,
                    ));
                  }
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                }
              },
              child: Builder(builder: (context) {
                if (_isLoading) {
                  return const SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(),
                  );
                }
                return const Text(
                  "Request",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
