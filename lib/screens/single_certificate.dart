import 'package:flutter/material.dart';
import 'package:green_book/model/hc1.dart';
import 'package:green_book/utils/common_utils.dart';
import 'package:green_book/services/qrcode_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';

// ignore: must_be_immutable
class SinglePageQrCodeView extends StatefulWidget {
  Hc1 hc1;

  SinglePageQrCodeView(this.hc1);

  @override
  _SinglePageQrCodeViewState createState() => _SinglePageQrCodeViewState(hc1);
}

class _SinglePageQrCodeViewState extends State<SinglePageQrCodeView> {
  Hc1 hc1;

  _SinglePageQrCodeViewState(this.hc1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(),
      body: FutureBuilder<String?>(
          future: QrCodeSaver.getQrCodeFromSecureStorage(getCid()),
          builder: (context, AsyncSnapshot<String?> snapshot) {
            if (snapshot.hasData) {
              return _qrCodeView(snapshot.data ?? "");
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }

  Stack _qrCodeView(String? code) {
    return Stack(
      children: [
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImage(
              data: code!,
              version: QrVersions.auto,
              size: 300.0,
            ),
          ],
        ))
      ],
    );
  }

  String? getCid() {
    return hc1.certificate!.vaccinationInfo!.ci..toString();
  }
}
