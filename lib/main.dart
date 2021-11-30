import 'package:flutter/material.dart';
import 'package:green_book/screens/list_data.dart';
import 'package:flutter/foundation.dart';
import 'package:green_book/screens/wallet_list.dart';
import 'package:green_book/services/qrcode_saver.dart';
import 'package:green_book/utils/common_utils.dart';

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
      home: const MyHomePage(),
    );
  }

  void saveExampleData() {
    String exampleCode = '';
    QrCodeSaver.saveCodeToSecureStorageString(exampleCode);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
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
}
