import 'package:flutter/material.dart';
import 'package:green_book/screens/scanner.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Icon(Icons.qr_code),
      title: const Text("Covid Pass Wallet"),
      actions: [
        IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () {
              debugPrint("start scanning");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QrCodeScanner(),
                ),
              );
            }),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
