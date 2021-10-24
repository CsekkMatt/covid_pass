import 'package:flutter/material.dart';
import 'package:green_book/screens/scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: homePageAppBar(),
        body: Container(
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
                      MaterialPageRoute(builder: (context) => Scanner()),
                    );
                  }),
            ],
          ),
          alignment: Alignment.center,
        ));
  }

  AppBar homePageAppBar() {
    return AppBar(
      leading: const Icon(Icons.qr_code),
      title: const Text("Scan QR code"),
      actions: [
        IconButton(
            onPressed: () {
              debugPrint("icon pressed");
            },
            icon: const Icon(Icons.favorite)),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          // child: Icon(Icons.save),
        ),
        //Icon(Icons.move_to_inbox)
      ],
      backgroundColor: Colors.green,
    );
  }
}
