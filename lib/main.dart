import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:milkiz/authentication/auth.dart';
import 'package:milkiz/screens/home_page.dart';
import 'package:milkiz/screens/main_page.dart';
import 'package:provider/provider.dart';

import 'authentication/login_screen.dart';
import 'authentication/signup.dart';
import 'firebase_options.dart';

Future<void> main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Auth()),
        ],
        child: Consumer<Auth>(
          builder: (
            ctx,
            auth,
            _,
          ) =>
              MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: MainPage(),
            routes: {
              '/login_screen': (context) => SignIn(),
              '/signup_screen': (context) => SignUp(),
              '/home_page': (context) => HomePage()
            },
          ),
        ));
  }
}
