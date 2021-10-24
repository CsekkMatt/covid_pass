import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:green_book/services/qrcode_decrypt.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class Scanner extends StatefulWidget {
  const Scanner({Key? key}) : super(key: key);

  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scanner"),
      ),
      body: _composeStack(),
    );
  }

  Stack _composeStack() {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  QRView(
                    key: qrKey,
                    onQRViewCreated:
                        _onQRViewCreated, //underscore method name(== private)
                  ),
                  Center(
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.red,
                          width: 4,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Expanded(
              flex: 1,
              child: Center(
                child: Text("Scan a code"),
              ),
            ),
          ],
        )
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      if (await canLaunch(scanData.code)) {
        await launch(scanData.code);
      } else {
        _displayMessage(scanData).then((value) => controller.resumeCamera());
      }
      controller.resumeCamera();
    });
  }

  Future<dynamic> _displayMessage(Barcode scanData) {
    debugPrint("Scanned DATA: " + scanData.code);
    QrCodeDecrypt qcd = QrCodeDecrypt(scanData.code);

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Decrypted QR code:"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text('Barcode Type: ${describeEnum(scanData.format)}'),
                  Text('Data: ${qcd.decryptCode()}'),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text("ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
