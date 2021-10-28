import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:green_book/model/hc1.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'qrcode_decrypter.dart';

class QrCodeSaver {
  static Future<List<Hc1>> getAndParseSavedCertificates() async {
    List<Hc1> ret = [];
    final sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.getKeys().forEach((key) async {
      String? qrCode = sharedPreference.getString(key);
      Hc1 certificate = QrCodeDecrypt(qrCode!).parseCertificate();
      ret.add(certificate);
    });
    return ret;
  }

  static Future<List<Hc1>> getAndParseSavedCertificatesSecure() async {
    return await const FlutterSecureStorage()
        .readAll()
        .asStream()
        .map((event) => event.values)
        .expand((element) => element)
        .map((qrCode) => QrCodeDecrypt(qrCode).parseCertificate())
        .toList();
  }

  static Future<List<Hc1>> getAndParseSavedCertificatesSecure1() async {
    const secureStorage = FlutterSecureStorage();
    Map<String, String> codes = await secureStorage.readAll();
    List<Hc1> ret = codes.values //
        .map((e) => QrCodeDecrypt(e).parseCertificate()) //
        .toList();
    return ret;
  }

  static Future<void> saveQrCodeToFileViaSharedPreferences(
      Barcode scannedData) async {
    String? ciCode = QrCodeDecrypt(scannedData.code).getCiCode();
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(ciCode!, scannedData.code);
  }

  static Future<void> saveCodeToSecureStorage(Barcode scannedData) async {
    String? ciCode = QrCodeDecrypt(scannedData.code).getCiCode();
    const storage = FlutterSecureStorage();
    await storage
        .write(key: ciCode!, value: scannedData.code)
        .then((value) => debugPrint("saved with success"));
  }

  static Future<String?> getQrCodeFromSecureStorage(String? cid) async {
    return await const FlutterSecureStorage().read(key: cid!);
  }
}
