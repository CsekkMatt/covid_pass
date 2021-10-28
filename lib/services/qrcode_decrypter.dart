import 'dart:io';

import 'package:dart_base45/dart_base45.dart';
import 'package:dart_cose/dart_cose.dart';
import 'package:green_book/model/hc1.dart';

class QrCodeDecrypt {
  String encryptedCode;

  QrCodeDecrypt(this.encryptedCode);

  Map decryptCode() {
    var base45Decoded = Base45.decode(encryptedCode.substring(4));
    var inflated = zlib.decode(base45Decoded);
    final result = Cose.decodeAndVerify(
      inflated,
      {'kid': '''pem'''},
    );
    return result.payload;
  }

  Hc1 parseCertificate() {
    return Hc1.fromMap(decryptCode());
  }

  String? getCiCode() {
    return parseCertificate().certificate!.vaccinationInfo!.ci..toString();
  }
}
