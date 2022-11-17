import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                ],
              ),
              Text(
                "Balance Available",
                style: GoogleFonts.poppins(fontSize: 20),
              ),
              Text(
                "₹ 500",
                style: GoogleFonts.poppins(fontSize: 40),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {},
                      child: Text("Add Money +", style: GoogleFonts.poppins())),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {},
                      child: Text(
                        "Withdraw >",
                        style: GoogleFonts.poppins(),
                      ))
                ],
              ),
              Container(
                margin: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width * 0.9,
                height: 2,
                color: Colors.black38,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Transactions",
                      style: GoogleFonts.poppins(),
                    ),
                    Icon(Icons.pie_chart)
                  ],
                ),
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shrinkWrap: true,
                  itemCount: 17,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/transaction.jpg"),
                        radius: 30,
                      ),
                      trailing: Text(
                        "-₹40",
                        style: GoogleFonts.poppins(color: Colors.red),
                      ),
                      title: Text("2 Litres"),
                      subtitle: Text("To Shop Name"),
                    );
                  }),

              // Container(
              //   margin: const EdgeInsets.all(10),
              //   decoration: BoxDecoration(
              //     color: Colors.white60,
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   child: Row(
              //     children: [
              //       CircleAvatar(
              //         backgroundImage:
              //             AssetImage("assets/images/transaction.jpg"),
              //         radius: 30,
              //       ),
              //       Column(
              //         children: [Text("2 Litres"), Text("To Shop Name")],
              //       ),
              //       Column(
              //         children: [Text("₹40"), Text("To Shop Name")],
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
