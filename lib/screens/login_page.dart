import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:the_dig_app/providers/dig_firebase_provider.dart';
import 'package:the_dig_app/screens/profiles_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  String? _email;
  String? _password;
  String? _errorMessage;

  StreamSubscription<User?>? _authSubscription;

  @override
  void dispose() {
    super.dispose();
    _authSubscription?.cancel();
  }

  _logIn() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email!, password: _password!);
      final provider = Provider.of<DigFirebaseProvider>(context, listen: false);
      provider.checkFirebaseAuth();
    } on FirebaseAuthException catch (e) {
      setState(() =>
          {_errorMessage = 'Incorrect email or password, error detail: $e'});
    }
  }

  @override
  Widget build(BuildContext context) {
    final disableButtons = _email == null || _password == null;
    final provider = Provider.of<DigFirebaseProvider>(context);
    bool isLoggedIn = provider.isLoggedIn;
    if (!isLoggedIn) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Icon(
            Icons.pets_outlined,
          ),
          actions: [
            if (isLoggedIn)
              IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'User: ${FirebaseAuth.instance.currentUser!.email} logged out')));
                  },
                  icon: const Icon(Icons.power_settings_new_outlined))
          ],
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      maxLines: 1,
                      maxLength: 40,
                      inputFormatters: [LengthLimitingTextInputFormatter(40)],
                      decoration: const InputDecoration(
                        labelText: 'Email address',
                        hintText: 'Enter Email address',
                      ),
                      onChanged: (email) => {
                        setState(() => {_email = email})
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      maxLines: 1,
                      maxLength: 15,
                      inputFormatters: [LengthLimitingTextInputFormatter(15)],
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter Password',
                      ),
                      onChanged: (password) => {
                        setState(() => {_password = password})
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                          (MediaQuery.of(context).size.width).toDouble() *
                              0.07),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                context.push('/register');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.blue, // set the button color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // set the button shape
                                ),
                              ),
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.white, // set the text color
                                  fontSize: 25, // set the text size
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: disableButtons ? null : _logIn,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.teal, // set the button color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // set the button shape
                                ),
                              ),
                              child: const Text(
                                'Log in',
                                style: TextStyle(
                                  color: Colors.white, // set the text color
                                  fontSize: 25, // set the text size
                                ),
                              ),
                            )
                          ]),
                    ),
                    Text(
                      _errorMessage ?? '',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      const CircularProgressIndicator();
      String email = FirebaseAuth.instance.currentUser!.email.toString();
      return ProfilesPage(
        email: email,
      );
    }
  }
}
