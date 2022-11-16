import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class OwnerData extends StatefulWidget {
  String Ownerid;
  OwnerData({Key? key, required this.Ownerid}) : super(key: key);

  @override
  State<OwnerData> createState() => _OwnerDataState();
}

class _OwnerDataState extends State<OwnerData> {
  void initState() {
    super.initState();
    getData();
  }

  final List<bool> isSelected = [true, false, false];
  int numberOfItems = 0;
  bool isLoading = true;
  late Map<dynamic, dynamic> owner;
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
                          height: 30,
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
                                  Text("₹ 500.0",
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
                        Container(
                          height: 150,
                          width: 320,
                          decoration: BoxDecoration(
                              // image: DecorationImage(
                              //     image: AssetImage("assets/images/bg2.jpg"),
                              //     fit: BoxFit.fill),

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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                  style: GoogleFonts.montserrat(fontSize: 20),
                                ),
                                decoration: BoxDecoration(
                                    // color: Colors.pinkAccent,
                                    borderRadius: BorderRadius.circular(7)),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ])),
            ),
      bottomNavigationBar: Container(
        height: 130,
        color: Colors.white,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      // color: Colors.white60,
                    ),
                    child: Center(
                      child: ToggleButtons(
                        selectedColor: Colors.white,
                        fillColor: Colors.black,
                        renderBorder: true,
                        borderRadius: BorderRadius.circular(7),
                        textStyle: TextStyle(fontSize: 20),
                        children: <Widget>[
                          SizedBox(
                            width: 100,
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
                            width: 100,
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
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      numberOfItems.toString() +
                          " Litres | "
                              "₹" +
                          (numberOfItems * 20).toString(),
                      style: GoogleFonts.montserrat(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            if (numberOfItems > 0) {
                              numberOfItems--;
                            }
                          });
                        },
                        icon: Icon(FontAwesomeIcons.minus, color: Colors.black),
                        color: Colors.white),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.add, color: Colors.black87),
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          numberOfItems++;
                        });
                      },
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "Check Out",
                          style: GoogleFonts.montserrat(
                              fontSize: 15, color: Colors.blueAccent),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
