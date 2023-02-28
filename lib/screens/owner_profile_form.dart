import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:the_dig_app/models/owner.dart';
import 'package:the_dig_app/providers/dig_provider_firebase.dart';

class OwnerProfileForm extends StatelessWidget {
  final String email;
  OwnerProfileForm({super.key, required this.email});

  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();//???? check why is it not working
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _pictureController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var userId = UniqueKey().hashCode;
    final provider = Provider.of<FirebaseProvider>(context);
    final googleSignIn = provider.googleSignIn;
    bool isLoggedIn = provider.isLoggedIn;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Details'),
        actions: [
          if (isLoggedIn)
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  googleSignIn.signOut();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'User: ${FirebaseAuth.instance.currentUser!.email} logged out')));
                },
                icon: const Icon(Icons.power_settings_new_outlined))
        ],
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Form(
                // key: _formKey,//???? check why is it not working
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      key: const ValueKey("ownerFName"),
                      maxLines: 1,
                      maxLength: 20,
                      controller: _fNameController,
                      inputFormatters: [LengthLimitingTextInputFormatter(20)],
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                      ),
                    ),
                    TextFormField(
                      key: const ValueKey("ownerLName"),
                      maxLines: 1,
                      maxLength: 20,
                      controller: _lNameController,
                      inputFormatters: [LengthLimitingTextInputFormatter(20)],
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                      ),
                    ),
                    TextFormField(
                      key: const ValueKey("email"),
                      maxLines: 1,
                      readOnly: true,
                      style: const TextStyle(color: Colors.grey),
                      initialValue: email,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    TextFormField(
                      key: const ValueKey("phone"),
                      maxLines: 1,
                      maxLength: 20,
                      controller: _phoneController,
                      inputFormatters: [LengthLimitingTextInputFormatter(20)],
                      decoration: const InputDecoration(
                        labelText: 'Phone',
                      ),
                    ),
                    TextFormField(
                      key: const ValueKey("city"),
                      maxLines: 1,
                      maxLength: 20,
                      controller: _cityController,
                      inputFormatters: [LengthLimitingTextInputFormatter(20)],
                      decoration: const InputDecoration(
                        labelText: 'City',
                      ),
                    ),
                    TextFormField(
                      key: const ValueKey("ownerPicture"),
                      maxLines: 1,
                      maxLength: 20,
                      controller: _pictureController,
                      inputFormatters: [LengthLimitingTextInputFormatter(20)],
                      decoration: const InputDecoration(
                        labelText: 'Picture',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(
                  (MediaQuery.of(context).size.width).toDouble() * 0.07),
              child: ElevatedButton(
                onPressed: () async {
                  // if (_formKey.currentState!.validate()) { //???? check why is it not working
                  if (_fNameController.text.isNotEmpty &&
                      _lNameController.text.isNotEmpty &&
                      _phoneController.text.isNotEmpty &&
                      _cityController.text.isNotEmpty &&
                      _pictureController.text.isNotEmpty) {
                    var querySnapshot = await FirebaseFirestore.instance
                        .collection('owner_profile')
                        .where('email', isEqualTo: email)
                        .get();
                    if (querySnapshot.size <= 0) {
                      await provider.addOwnerProfile(Owner(
                          id: userId,
                          fName: _fNameController.text,
                          lName: _lNameController.text,
                          phone: _phoneController.text,
                          email: email,
                          city: _cityController.text,
                          picture: _pictureController.text));

                      querySnapshot = await FirebaseFirestore.instance
                          .collection('owner_profile')
                          .where('id', isEqualTo: userId)
                          .get();

                      if (querySnapshot.size.isFinite) {
                        context.push('/add/profile');
                      } else {
                        Exception(
                            'The profile was not saved. Please try later');
                      }
                    } else {
                      context.push('/add/profile');
                    }
                    // } //???? check why is it not working
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('All fields are mandatory')));
                  }
                },
                child: const Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
