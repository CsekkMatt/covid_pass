import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ticketview/ticketview.dart';

class TestScreen extends StatefulWidget {
  TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation colorAnimation;
  late Animation sizeAnimation;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    colorAnimation =
        ColorTween(begin: Colors.blue, end: Colors.yellow).animate(controller);
    sizeAnimation = Tween<double>(begin: 100.0, end: 200.0).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: TicketView(
        backgroundPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        backgroundColor: Color(0xFF8F1299),
        contentPadding: EdgeInsets.symmetric(vertical: 24, horizontal: 0),
        drawArc: false,
        triangleAxis: Axis.vertical,
        borderRadius: 6,
        drawDivider: true,
        trianglePos: .5,
        // child: Padding(
        //   padding: const EdgeInsets.all(10.0),
        //   child: containerHomePage(context),
        // ),
        child: Container(
          height: height,
          width: width,
          child: Text("Szia"),
        ),
      ),
    );
  }

  Dialog _returnDialog() {
    return Dialog(
      insetPadding: const EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Align(
        alignment: Alignment.center,
        child: _dialogContent(context),
      ),
    );
  }

  Container containerHomePage(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(32),
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*2*/
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: const Center(
                  child: Text(
                    'Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Some other data',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ),
              Text(
                'Identification key',
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
              Container(
                // decoration: BoxDecoration(
                //   border: Border.all(width: 10.0, style: BorderStyle.none),
                //   color: Colors.white,
                // ),
                alignment: Alignment.center,
                //padding: const EdgeInsets.fromLTRB(0, 100.0, 0, 0),
                child: Container(
                  // decoration: BoxDecoration(
                  //   border: Border.all(
                  //       color: Colors.green, style: BorderStyle.none),
                  // ),
                  child: Center(
                    child: QrImage(
                      data: "akortssselma",
                      version: QrVersions.auto,
                      size: 300,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Stack homePage() {
    return Stack(
      children: [
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 250,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "Name",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
              ),
              Text("Other data"),
            ],
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QrImage(
                data: "data",
                version: QrVersions.auto,
                size: 200.0,
              )
            ],
          ),
        ),
      ],
    );
  }

  _dialogContent(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height * 0.6,
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.green, width: 10.0, style: BorderStyle.solid),
        color: Colors.white,
      ),
      child: containerHomePage(context),
    );
  }
}
