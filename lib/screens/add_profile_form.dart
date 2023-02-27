import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:the_dig_app/models/owner.dart';
import 'package:the_dig_app/providers/dig_provider_firebase.dart';

class AddProfileForm extends StatelessWidget {
  final String email;
  AddProfileForm({required this.email, super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressTextController = TextEditingController();
  final TextEditingController _addressCoordindatesController =
      TextEditingController();
  final TextEditingController _pictureController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FirebaseProvider>(context);
    final googleSignIn = provider.googleSignIn;
    bool isLoggedIn = provider.isLoggedIn;
    List<Owner?> ownerProfile = provider.ownerProfiles;
    if (ownerProfile.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Add Profile'),
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
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Got this email from firebase auth: $email'),
                      Text(ownerProfile.first!.id
                          .toString()), //???? Dummy printer, remove me
                      Text(ownerProfile
                          .first!.fName), //???? Dummy printer, remove me
                      Text(ownerProfile
                          .first!.lName), //???? Dummy printer, remove me
                      Text(ownerProfile.first!.addressText
                          .toString()), //???? Dummy printer, remove me
                      Text(ownerProfile
                          .first!.email), //???? Dummy printer, remove me
                      Text(ownerProfile
                          .first!.phone), //???? Dummy printer, remove me
                      Text(ownerProfile
                          .first!.picture), //???? Dummy printer, remove me
                      TextFormField(
                        key: const ValueKey("fNameField"),
                        maxLines: 1,
                        maxLength: 20,
                        controller: _fNameController,
                        inputFormatters: [LengthLimitingTextInputFormatter(20)],
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter First Name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        key: const ValueKey("lNameField"),
                        maxLines: 1,
                        maxLength: 20,
                        controller: _lNameController,
                        inputFormatters: [LengthLimitingTextInputFormatter(20)],
                        decoration: const InputDecoration(
                          labelText: 'Last Name',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Last Name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        key: const ValueKey("emailField"),
                        maxLines: 1,
                        maxLength: 20,
                        controller: _emailController,
                        inputFormatters: [LengthLimitingTextInputFormatter(20)],
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        key: const ValueKey("phoneField"),
                        maxLines: 1,
                        maxLength: 20,
                        controller: _phoneController,
                        inputFormatters: [LengthLimitingTextInputFormatter(20)],
                        decoration: const InputDecoration(
                          labelText: 'Phone',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Phone number';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        key: const ValueKey("addressField"),
                        maxLines: 1,
                        maxLength: 20,
                        controller: _addressTextController,
                        inputFormatters: [LengthLimitingTextInputFormatter(20)],
                        decoration: const InputDecoration(
                          labelText: 'Address',
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
                    Map<String, dynamic> dataToSave = {
                      'fName': _fNameController.text,
                      'lName': _lNameController.text,
                      'phone': _phoneController.text,
                      'email': _emailController.text,
                      'addressText': _addressTextController.text,
                    };
                    // digProvider.ownerSetup(
                    //     _fNameController.text,
                    //     _lNameController.text,
                    //     _phoneController.text,
                    //     email,
                    //     addressText
                    // );
                    // final data = await FirebaseFirestore.instance.collection("owner_profiles").where('fName', isEqualTo: 'Shahrukh').get();
                    // print(data);
                    // FirebaseFirestore.instance.collection("owner_profiles").add(dataToSave);
                    // FirebaseFirestore.instance.collection('test').add(dataToSave);
                    // context.push('/dogprofile');
                  },
                  child: const Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      provider.checkFirebaseAuth();
      provider.getOwnerProfilebyId(0); // ???? dont you hardcode me
      return const Scaffold(
        body: CircularProgressIndicator(),
      );
    }
  }
}
