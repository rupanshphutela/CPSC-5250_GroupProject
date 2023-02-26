import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_dig_app/screens/add_profile_form.dart';

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

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>['email', 'profile'],
  );
  bool _isLoggedIn = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  initState() {
    super.initState();
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      setState(() => {_isLoggedIn = user != null});
    });

    _googleSignIn.onCurrentUserChanged.listen((account) async {
      if (account != null) {
        final gauth = await account.authentication;
        FirebaseAuth.instance.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: gauth.idToken, accessToken: gauth.accessToken));
      }
    });
    _googleSignIn.signInSilently();
  }

  @override
  void dispose() {
    super.dispose();
    _authSubscription?.cancel();
  }

  _registrationErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered with us';
      case 'weak-password':
        return 'The password must be at least eight characters long';
      case 'invalid-email':
        return 'Invalid email address format';
      default:
        return 'Facing issues right now, please try again later';
    }
  }

  _register() async {
    try {
      final credentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email!, password: _password!);
      if (credentials.user != null && !credentials.user!.emailVerified) {
        credentials.user!.sendEmailVerification();
      }
    } on FirebaseAuthException catch (e) {
      setState(() => {_errorMessage = _registrationErrorMessage(e.code)});
    }
  }

  _logIn() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email!, password: _password!);
    } on FirebaseAuthException catch (e) {
      setState(() =>
          {_errorMessage = 'Incorrect email or password, error detail: $e'});
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the Google Sign-In flow.
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // Obtain the auth details from the Google account.
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential.
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase with the Google credential.
    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    return userCredential;
  }

  @override
  Widget build(BuildContext context) {
    final disableButtons = _email == null || _password == null;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Icon(
          Icons.pets_outlined,
        ),
        actions: [
          if (_isLoggedIn)
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  _googleSignIn.signOut();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'User: ${FirebaseAuth.instance.currentUser!.email} logged out')));
                },
                icon: const Icon(Icons.power_settings_new_outlined))
        ],
      ),
      body: Center(
        child: _isLoggedIn
            ? AddProfileForm()
            : Column(
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
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(40)
                          ],
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
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(15)
                          ],
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
                                  onPressed: disableButtons ? null : _register,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.blue, // set the button color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // set the button shape
                                    ),
                                  ),
                                  child: const Text(
                                    'Register',
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
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Text('or'),
                          ),
                        ),
                        Center(
                          child: SignInButton(Buttons.Google,
                              text: "Sign in with Google",
                              elevation: 10.0,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              padding: const EdgeInsets.only(
                                  left: 25,
                                  top: 10,
                                  bottom: 10), onPressed: () async {
                            debugPrint('signing in with Google');
                            final UserCredential userCredential =
                                await signInWithGoogle();
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
