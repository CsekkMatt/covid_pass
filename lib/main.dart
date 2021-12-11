import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:green_book/screens/wallet_list.dart';
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
    String exampleCode =
        r'HC1:NCFOXN%TSMAHN-HBUKN8N2A709SZ%K0II/P3 437PG/EB2QINOUA4DNK92J5D8N:UC*GPXS40 LHZA KEJ*G%9DJ6K1AD1WMN+I HKKDIQ-I7IK XGX6IZHHTVN9 IPVNAZK4ZK:BGJ3E4$KS 854FXBIK7B-JELHQC K1U7C KPLI8J4RK46YB+MALK9FQ5CVU2+PFQ51C5EWAC1A.GUQ$9WC5499Q$95:UENEUW6646C46$T6V467PPDFPVX1R270:6NEQ0R6$46UF5LDCPF5RBQ746B46O1N646RM93O5RF6$T61R63B0 %PPRAAUICO18 919GIFT9GJ/9TL4T.B9NVPC2F JEBJ7%-OR95X/58EP SPZBP1A6+Y54P4 75UEU*IJZ0K+B0G%5TW5A 6+O67N6+AE:081L9/1BBZP YNYP6B6M NF1UFR-HL%ML/M$OF3FVT4W025P8JITEJS0OO144ON43DQQ*6L *H*QCK5QTIV4NF.4WZK8 QJIOFDO3I8MSEF';
    //QrCodeSaver.saveCodeToSecureStorageString(exampleCode);
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
