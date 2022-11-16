import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milkiz/qr/scan_qr_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 35,
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("₹ 500.0",
                        style: GoogleFonts.montserrat(fontSize: 20)),
                    IconButton(
                      onPressed: () {},
                      icon: FaIcon(
                        FontAwesomeIcons.wallet,
                      ),
                      color: Colors.blue,
                    ),
                  ]),
              Padding(
                padding: const EdgeInsets.all(17.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Water Shop",
                    style: GoogleFonts.poppins(
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 240,
                width: 320,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/pic.jpg",
                        ),
                        fit: BoxFit.fill)),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ScanQRPage()));
                },
                child: Container(
                  height: 120,
                  width: 320,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/bg.jpg"),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(7)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Hero(
                        tag: "scanQR image",
                        child: Image.asset(
                          "assets/images/scanQR.png",
                          height: 100,
                        ),
                      ),
                      Text(
                        "Scan QR to get water",
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
