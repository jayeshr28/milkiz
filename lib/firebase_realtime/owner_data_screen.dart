import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milkiz/firebase_realtime/checkout_screen.dart';

class OwnerData extends StatefulWidget {
  final User user;
  String Ownerid;
  OwnerData({Key? key, required this.Ownerid, required this.user})
      : super(key: key);

  @override
  State<OwnerData> createState() => _OwnerDataState();
}

class _OwnerDataState extends State<OwnerData> {
  void initState() {
    super.initState();
    getData();
    geUserData();
  }

  final List<bool> isSelected = [true, false, false];
  int numberOfItems = 0;
  bool isLoading = true;
  late Map<dynamic, dynamic> owner;
  late Map<dynamic, dynamic> userData;

  void getData() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('Owners/' + widget.Ownerid).get();
    owner = snapshot.value as Map;
    if (snapshot.exists) {
      print(snapshot.value);
    } else {
      print('No data available.');
    }
    setState(() {
      isLoading = false;
    });
  }

  void geUserData() async {
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

  void updateWater(int purchased) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref('Owners/' + widget.Ownerid);

    final updatedWaterAvailable = owner['available_water'] - purchased;
    await ref.update({
      "available_water": updatedWaterAvailable,
    });
  }

  void onToggleTapped(int index) {
    for (int i = 0; i < isSelected.length; i++) {
      setState(() {
        isSelected[i] = i == index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.arrow_back_ios)),
                                  Text(
                                    owner['shop_name'],
                                    style: GoogleFonts.poppins(fontSize: 20),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("₹ " + userData['money'].toString(),
                                      style:
                                          GoogleFonts.montserrat(fontSize: 20)),
                                  IconButton(
                                    onPressed: () {},
                                    icon: FaIcon(
                                      FontAwesomeIcons.wallet,
                                    ),
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                            ]),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Hi! Welcome to our Water Shop",
                          style: GoogleFonts.poppins(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 220,
                          width: 320,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              image: DecorationImage(
                                  image: AssetImage("assets/images/shop.jpg"),
                                  fit: BoxFit.fill)),
                        ),
                        Container(
                          width: 320,
                          height: 120,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Water Available \n   " +
                                    owner['available_water'].toString() +
                                    " Litres",
                                style: GoogleFonts.montserrat(fontSize: 20),
                              ),
                              Image.asset(
                                "assets/images/waterAnim.gif",
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            Container(
                              height: 150,
                              width: 320,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Colors.blueAccent,
                                        Colors.white60,
                                        Colors.white
                                      ]),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    "assets/images/price.jpg",
                                    fit: BoxFit.fill,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 100,
                                    width: 100,
                                    child: Text(
                                      "Just @\n ₹20/lt.",
                                      style:
                                          GoogleFonts.montserrat(fontSize: 20),
                                    ),
                                    decoration: BoxDecoration(
                                        // color: Colors.pinkAccent,
                                        borderRadius: BorderRadius.circular(7)),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                // color: Colors.white60,
                              ),
                              child: Center(
                                child: ToggleButtons(
                                  selectedColor: Colors.white,
                                  fillColor: Colors.blue,
                                  renderBorder: false,
                                  borderRadius: BorderRadius.circular(7),
                                  textStyle: TextStyle(fontSize: 20),
                                  children: <Widget>[
                                    SizedBox(
                                      width: 110,
                                      child: const Text(
                                        'Cool',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: const Text(
                                        'Mild',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 110,
                                      child: const Text(
                                        'Hot',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                  onPressed: (int index) {
                                    onToggleTapped(index);
                                  },
                                  isSelected: isSelected,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ])),
            ),
      bottomNavigationBar: Container(
        height: 90,
        padding: const EdgeInsets.all(12),
        color: Colors.white,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  numberOfItems.toString() +
                      " Litres | "
                          "₹" +
                      (numberOfItems * 20).toString(),
                  style: GoogleFonts.montserrat(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                CircleAvatar(
                  backgroundColor: Colors.white30,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          if (numberOfItems > 0) {
                            numberOfItems--;
                          }
                        });
                      },
                      icon: Icon(FontAwesomeIcons.minus, color: Colors.white),
                      color: Colors.white),
                ),
                CircleAvatar(
                  backgroundColor: Colors.white30,
                  child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        numberOfItems++;
                      });
                    },
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckOut(
                                    owner: owner,
                                    userD: userData,
                                    user: widget.user,
                                    numberOfItems: numberOfItems,
                                    Ownerid: widget.Ownerid,
                                  )));
                    },
                    child: Text(
                      "Check Out",
                      style: GoogleFonts.montserrat(
                          fontSize: 15, color: Colors.white),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
