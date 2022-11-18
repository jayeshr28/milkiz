import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class WalletItem {
  final String uid;
  final double available_money;

  WalletItem({required this.uid, required this.available_money});
}

class Wallet with ChangeNotifier {
  final String uid;
  Map<dynamic, dynamic> walletData;
  Wallet(this.uid, this.walletData);

  Future<void> createAccount() async {
    FirebaseDatabase.instance.ref().child("users/" + uid).set({
      'money': 500,
    });
    notifyListeners();
  }

  Future<void> getWalletData() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('users/' + uid).get();
    walletData = snapshot.value as Map;
    if (snapshot.exists) {
      WalletItem(uid: uid, available_money: walletData['money']);
      print(snapshot.value);
    } else {
      print('No data available.');
      throw ('User Not Found');
    }
    notifyListeners();
  }

  Future<void> updateWallet(int moneySpend) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('users/' + uid);

    final updatedmoney = walletData['money'] - moneySpend;
    await ref.update({
      "money": updatedmoney,
    });
    notifyListeners();
  }
}
