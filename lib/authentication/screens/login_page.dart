import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milkiz/authentication/screens/register_page.dart';
import 'package:milkiz/screens/home_page.dart';

import '../utils/fire_auth.dart';
import '../utils/validator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  var errorMessage = 'Authentication failed';
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  bool _isObsecureText = true;
  bool _isProcessing = false;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(
            user: user,
          ),
        ),
      );
    }

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: _initializeFirebase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Login to your Registered Account",
                        style: GoogleFonts.cabin(fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Image.asset(
                            "assets/images/signup.jpg",
                          ),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: _emailTextController,
                              focusNode: _focusEmail,
                              validator: (value) => Validator.validateEmail(
                                email: value,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Email',
                                suffixIcon: Icon(Icons.email_outlined),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.black12),
                                    borderRadius: BorderRadius.circular(5)),
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 8.0),
                            TextFormField(
                              controller: _passwordTextController,
                              focusNode: _focusPassword,
                              obscureText: _isObsecureText,
                              validator: (value) => Validator.validatePassword(
                                password: value,
                              ),
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: _isObsecureText
                                      ? Icon(Icons.lock)
                                      : Icon(Icons.lock_open),
                                  onPressed: () {
                                    setState(() {
                                      _isObsecureText = !_isObsecureText;
                                    });
                                  },
                                ),
                                hintText: 'Password',
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.black12),
                                    borderRadius: BorderRadius.circular(5)),
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 24.0),
                            _isProcessing
                                ? CircularProgressIndicator()
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blueAccent,
                                            elevation: 0,
                                          ),
                                          onPressed: () async {
                                            _focusEmail.unfocus();
                                            _focusPassword.unfocus();

                                            if (_formKey.currentState!
                                                .validate()) {
                                              setState(() {
                                                _isProcessing = true;
                                              });

                                              User? user =
                                                  await FireAuth
                                                      .signInUsingEmailPassword(
                                                          email:
                                                              _emailTextController
                                                                  .text,
                                                          password:
                                                              _passwordTextController
                                                                  .text,
                                                          errorMessage:
                                                              errorMessage);

                                              setState(() {
                                                _isProcessing = false;
                                              });

                                              if (user != null) {
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomePage(user: user),
                                                  ),
                                                );
                                              } else {
                                                showDialog(
                                                  context: context,
                                                  builder: (ctx) => AlertDialog(
                                                    title: Text(
                                                        'An Error Occurred!'),
                                                    content: Text(errorMessage),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: Text('Okay'),
                                                        onPressed: () {
                                                          Navigator.of(ctx)
                                                              .pop();
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }
                                            }
                                          },
                                          child: Text(
                                            'Sign In',
                                            style: GoogleFonts.montserrat(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 24.0),
                                      Expanded(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blueAccent,
                                            elevation: 0,
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    RegisterPage(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Register',
                                            style: GoogleFonts.montserrat(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "OR",
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Continue with"),
                          IconButton(
                            onPressed: () {},
                            icon: FaIcon(FontAwesomeIcons.google),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: FaIcon(FontAwesomeIcons.facebook),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: FaIcon(FontAwesomeIcons.twitter),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
