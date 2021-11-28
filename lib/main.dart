import 'package:flutter/material.dart';
import 'package:green_book/screens/list_data.dart';
import 'package:flutter/foundation.dart';
import 'package:green_book/screens/scanner.dart';
import 'package:green_book/screens/wallet_list.dart';
import 'package:green_book/services/qrcode_saver.dart';
import 'package:green_book/utils/common_utils.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      saveExampleData();
    }
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }

  void saveExampleData() {
    String exampleCode = '';
    QrCodeSaver.saveCodeToSecureStorageString(exampleCode);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        appBar: CommonAppBar(),
        // body: TestScreen());
        body: GreenBookList());
  }

  Container _cnt() {
    return Container(
      child: Column(
        children: [
          QrImage(
            data: "Test QR CODE with covid data",
            version: QrVersions.auto,
            size: 200.0,
          ),
          ElevatedButton(
              child: const Text("Scan"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const QrCodeScanner()),
                );
              }),
          ElevatedButton(
              child: const Text("List Certificates"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GreenBookList()),
                );
              }),
        ],
      ),
      alignment: Alignment.center,
    );
  }
}
