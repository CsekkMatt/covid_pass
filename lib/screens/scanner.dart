import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:green_book/main.dart';
import 'package:green_book/screens/wallet_list.dart';
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
            // Expanded(
            //   flex: 1,
            //   child: Center(
            //     child: TextButton(
            //         style: _defaultButtonStyle(),
            //         onPressed: () {}, //do nothing
            //         child: const Text("Do nothing?")),
            //   ),
            // ),
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
            title: Text(
              "QR CODE",
              style: _defaultTextStyle(),
            ),
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
      style: _defaultButtonStyle(),
      child: const Text("Save"),
      onPressed: () {
        QrCodeSaver.saveCodeToSecureStorage(scanData);
        NavigatorState nav = Navigator.of(context);
        nav.pop();
        nav.push(MaterialPageRoute(builder: (context) => MyHomePage()));
      },
    );
  }

  ButtonStyle _defaultButtonStyle() {
    return ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: Colors.green),
        ),
      ),
    );
  }

  Future<dynamic> _displayErrorMessage() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Failed to scan QR code",
              style: _defaultTextStyle(),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: const [
                  Text('Not a valid EU COVID PASS'),
                ],
              ),
            ),
            actions: [
              TextButton(
                style: _defaultButtonStyle(),
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  TextStyle _defaultTextStyle() {
    return TextStyle(
      color: Colors.green,
      backgroundColor: Colors.white,
    );
  }
}
