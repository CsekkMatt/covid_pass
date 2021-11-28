import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:green_book/services/qrcode_saver.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({Key? key}) : super(key: key);

  @override
  _QrCodeScannerState createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
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
      body: _composeBodyStack(),
    );
  }

  Stack _composeBodyStack() {
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
              child: const Text("Save"),
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
      if (scanData.code.substring(0, 4) == "HC1:") {
        _displayMessage(scanData);
      } else {
        _displayErrorMessage();
      }
      controller.resumeCamera();
    });
  }

  Future<dynamic> _displayMessage(Barcode scanData) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("QR CODE"),
            content: SingleChildScrollView(
              child: ListBody(
                children: const [
                  Text("Succesful read"),
                  // Text('Barcode Type: ${describeEnum(scanData.format)}'),
                  // Text('Data: ${qcd.parseCertificate()}'),
                ],
              ),
            ),
            actions: [
              saveQrCode(scanData, context),
            ],
          );
        });
  }

  TextButton saveQrCode(Barcode scanData, BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide(color: Colors.green),
          ),
        ),
      ),
      child: const Text("Save"),
      onPressed: () {
        QrCodeSaver.saveCodeToSecureStorage(scanData);
        Navigator.of(context).pop();
      },
    );
  }

  Future<dynamic> _displayErrorMessage() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Failed to scan QR code"),
            content: SingleChildScrollView(
              child: ListBody(
                children: const [
                  Text('Not a valid EU COVID PASS'),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
