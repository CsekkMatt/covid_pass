import 'package:flutter/material.dart';
import 'package:green_book/model/hc1.dart';
import 'package:green_book/screens/single_certificate.dart';
import 'package:green_book/services/qrcode_saver.dart';

class GreenBookList extends StatefulWidget {
  const GreenBookList({Key? key}) : super(key: key);

  @override
  _GreenBookListState createState() => _GreenBookListState();
}

class _GreenBookListState extends State<GreenBookList> {
  List<Hc1> certificates = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Hc1>>(
        future: QrCodeSaver.getAndParseSavedCertificatesSecure(),
        builder: (context, AsyncSnapshot<List<Hc1>> snapshot) {
          if (snapshot.hasData) {
            return _certificateList(snapshot.data ?? []);
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  ListView _certificateList(List<Hc1> list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SinglePageQrCodeView(list[index]),
                  ),
                );
              },
              title: Text(_getName(list[index]) ?? 'Name'),
              subtitle: Text(
                  list[index].certificate!.vaccinationInfo!.dt ?? "Date Time"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return _removeDialog(list[index]);
                            });
                      });
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  AlertDialog _removeDialog(Hc1 hc1) {
    return AlertDialog(
      title: Text("Delete Certificate"),
      content: Text("Are you sure you want to delete?"),
      actions: [
        cancelButton(),
        deleteButton(hc1),
      ],
    );
  }

  TextButton cancelButton() {
    return TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  // set up the buttons
  TextButton deleteButton(Hc1 hc1) {
    return TextButton(
      child: Text("Delete"),
      onPressed: () {
        QrCodeSaver.deleteQrCodeFromStorage(getCiCode(hc1));
        Navigator.of(context).pop();
      },
    );
  }

  String? _getName(Hc1 hc1) {
    String? familyName = hc1.certificate!.names!.familyName;
    String? givenName = hc1.certificate!.names!.givenName;
    String composed = familyName! + " " + givenName!;
    return composed;
  }

  String? getCiCode(Hc1 hc1) {
    return hc1.certificate!.vaccinationInfo!.ci..toString();
  }
}
