import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milkiz/qr/scan_qr_page.dart';
import 'package:milkiz/screens/wallet_page.dart';

import '../authentication/screens/login_page.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({Key? key, required this.user}) : super(key: key);

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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              await FirebaseAuth.instance.signOut();

                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 22,
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                backgroundImage: AssetImage(
                                    "assets/images/homepageWater.jpg"),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(widget.user.displayName.toString().toUpperCase(),
                              style: GoogleFonts.montserrat(fontSize: 20)),
                        ],
                      ),
                      Row(
                        children: [
                          Text("₹ 500.0",
                              style: GoogleFonts.montserrat(fontSize: 20)),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WalletPage()));
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.wallet,
                            ),
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(17.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "MILKIZ",
                    style: GoogleFonts.poppins(
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
              CarouselSlider(
                items: [
                  //1st Image of Slider
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

                  //2nd Image of Slider
                  Container(
                    alignment: Alignment.center,
                    height: 240,
                    width: 320,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.blueAccent,
                            Colors.white30,
                            // Colors.pinkAccent,
                            Colors.purpleAccent
                          ]),
                    ),
                    child: Image.asset(
                      "assets/images/bottle.gif",
                    ),
                  ),

                  //3rd Image of Slider
                  Container(
                    alignment: Alignment.center,
                    height: 240,
                    width: 320,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/images/bottle2.gif",
                            ),
                            fit: BoxFit.fill)),
                    child: Text(
                      "100% Hygienic Water",
                      style: GoogleFonts.montserrat(
                          fontSize: 45, color: Colors.lightBlue),
                    ),
                  ),
                ],

                //Slider Container properties
                options: CarouselOptions(
                  height: 220.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  // viewportFraction: 0.8,
                ),
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
