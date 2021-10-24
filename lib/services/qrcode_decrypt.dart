import 'dart:io';

import 'package:dart_base45/dart_base45.dart';
import 'package:dart_cose/dart_cose.dart';

class QrCodeDecrypt {
  String encryptedCode;

  QrCodeDecrypt(this.encryptedCode);

  Map decryptCode() {
    // String cryptedData = encryptedCode.replaceFirst("HC1:", "");
    var base45Decoded = Base45.decode(encryptedCode.substring(4));
    var inflated = zlib.decode(base45Decoded);

    final result = Cose.decodeAndVerify(
      inflated,
      {'kid': '''pem'''},
    );
    return result.payload;
  }
}
