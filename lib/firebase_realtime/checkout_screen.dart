import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:milkiz/screens/home_page.dart';

class CheckOut extends StatefulWidget {
  final String Ownerid;
  final int numberOfItems;
  final User user;
  final Map<dynamic, dynamic> userD;
  final Map<dynamic, dynamic> owner;
  const CheckOut(
      {Key? key,
      required this.numberOfItems,
      required this.Ownerid,
      required this.user,
      required this.userD,
      required this.owner})
      : super(key: key);

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
  }

  void updateWallet(int purchased) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref('users/' + widget.user.uid);

    final updatedmoney = widget.userD['money'] - purchased;
    await ref.update({
      "money": updatedmoney,
    });
  }

  void updateWater(int purchased) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref('Owners/' + widget.Ownerid);

    final updatedWaterAvailable = widget.owner['available_water'] - purchased;
    await ref.update({
      "available_water": updatedWaterAvailable,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text("Available Money - " + widget.userD['money'].toString()),
            Text("Number Of Litres - " + widget.numberOfItems.toString()),
            Text("Amount - " + (widget.numberOfItems * 20).toString()),
            ElevatedButton(
                onPressed: () {
                  updateWater(widget.numberOfItems);
                  updateWallet(widget.numberOfItems * 20);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(user: widget.user)));
                },
                child: Text("Place Order"))
          ],
        ),
      ),
    );
  }
}
