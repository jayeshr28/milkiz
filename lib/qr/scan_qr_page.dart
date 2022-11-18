import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:milkiz/firebase_realtime/owner_data_screen.dart';

class ScanQRPage extends StatefulWidget {
  final User user;
  const ScanQRPage({Key? key, required this.user}) : super(key: key);

  @override
  State<ScanQRPage> createState() => _ScanQRPageState();
}

class _ScanQRPageState extends State<ScanQRPage> {
  String qrCodeResult = "Not Yet Scanned";
  late String OwnerId;
  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      qrCodeResult = barcodeScanRes;
      OwnerId = qrCodeResult.substring(7);
      // print(OwnerId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan QR Code"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Message displayed over here
            Hero(
              tag: "scanQR image",
              child: Image.asset(
                "assets/images/scanQR.png",
              ),
            ),

            SizedBox(
              height: 20.0,
            ),

            //Button to scan QR code
            ElevatedButton(
              onPressed: () async {
                scanQR().then((value) => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OwnerData(
                              Ownerid: OwnerId,
                              user: widget.user,
                            ))));
              },
              child: Text(
                "Open Scanner",
                style: TextStyle(color: Colors.white),
              ),

              //Button having rounded rectangle border
              // shape: RoundedRectangleBorder(
              //   side: BorderSide(color: Colors.indigo[900]),
              //   borderRadius: BorderRadius.circular(20.0),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
