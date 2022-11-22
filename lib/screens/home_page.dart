import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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
  void initState() {
    super.initState();
    getUserData();
  }

  late Map<dynamic, dynamic> userData;
  bool isLoading = true;

  void getUserData() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('users/' + widget.user.uid).get();
    userData = snapshot.value as Map;
    if (snapshot.exists) {
      print(snapshot.value);
    } else {
      print('No data available.');
    }
    setState(() {
      isLoading = false;
    });
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            children: [
              DrawerHeader(
                  child: Image.asset("assets/images/homepageWater.jpg")),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 30,
                ),
                title: Text(
                  "Profile",
                  style: GoogleFonts.poppins(fontSize: 20),
                ),
              ),
              InkWell(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                child: ListTile(
                  leading: Icon(
                    Icons.add_to_home_screen_outlined,
                    color: Colors.black,
                    size: 30,
                  ),
                  title: Text(
                    "Log Out",
                    style: GoogleFonts.poppins(fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          title: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              scaffoldKey.currentState!.openDrawer();
                            },
                            child: CircleAvatar(
                              radius: 23,
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
                              style: GoogleFonts.montserrat(
                                  fontSize: 20, color: Colors.black)),
                        ],
                      ),
                      Row(
                        children: [
                          Text("₹ " + userData['money'].toString(),
                              style: GoogleFonts.montserrat(
                                  fontSize: 20, color: Colors.black)),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WalletPage(
                                            uid: widget.user.uid.toString(),
                                          )));
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
        backgroundColor: Colors.white,
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
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
                          child: Stack(children: [
                            Image.asset(
                              "assets/images/bottle.gif",
                            ),
                          ]),
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
                                fontSize: 45, color: Colors.greenAccent),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScanQRPage(
                                      user: widget.user,
                                    )));
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
