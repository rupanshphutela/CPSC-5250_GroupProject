import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:the_dig_app/models/owner.dart';
import 'package:the_dig_app/models/profile.dart';
import 'package:the_dig_app/providers/dig_firebase_provider.dart';
import 'package:intl/intl.dart';
// import 'package:simple_permissions/simple_permissions.dart';

enum RadioValue { Male, Female }

const List<String> aggression = ['Yes', 'No'];

class OwnerProfileForm extends StatefulWidget {
  final String email;
  OwnerProfileForm({super.key, required this.email});

  @override
  createState() => _OwnerProfileForm();
}


class _OwnerProfileForm extends State<OwnerProfileForm> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();//???? check why is it not working
  final TextEditingController _ownerfNameController = TextEditingController();
  final TextEditingController _ownerlNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _ownerpictureController = TextEditingController();
  final TextEditingController _pictureController = TextEditingController();
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _socialHumansController = TextEditingController();
  final TextEditingController _socialDogsController = TextEditingController();
  final TextEditingController _aggressionController = TextEditingController();
  final TextEditingController _humanAggressionController =
      TextEditingController();
  final TextEditingController _dogAggressionController =
      TextEditingController();
  final TextEditingController _favoriteFoodController = TextEditingController();
  final TextEditingController _favoriteFoodRatingController =
      TextEditingController();
  final TextEditingController _favoriteActivityController =
      TextEditingController();
  final TextEditingController _favoriteActivityRatingController =
      TextEditingController();
  final TextEditingController _skillNameController = TextEditingController();
  final TextEditingController _skillProficienctController =
      TextEditingController();

  String _gender = 'male';
  bool? isVaccinated = false;
  String sterilization = "Spayed";
  File? _imageFile;
  bool _isChecked = false;
  DateTime _selectedDate = DateTime.now();

Future createProfile(Profile profile) async {
    final docUser = FirebaseFirestore.instance
        .collection("profile")
        .doc(_ownerfNameController.text);
    final json = profile.toJson();
    await docUser.set(json);
  }


Future<String?> _selectAndUploadOwnerImage() async {
  final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
  if (pickedFile == null) return null;

  final imageFile = File(pickedFile.path);
  final fileName = imageFile.path.split('/').last;
  final destination = 'images/$fileName';

  try {
    await firebase_storage.FirebaseStorage.instance
        .ref(destination)
        .putFile(imageFile);
    final url = await firebase_storage.FirebaseStorage.instance
        .ref(destination)
        .getDownloadURL();
    return url;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<String?> _selectAndUploadImage() async {
  final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
  if (pickedFile == null) return null;

  final imageFile = File(pickedFile.path);
  final fileName = imageFile.path.split('/').last;
  final destination = 'images/$fileName';

  try {
    await firebase_storage.FirebaseStorage.instance
        .ref(destination)
        .putFile(imageFile);
    final url = await firebase_storage.FirebaseStorage.instance
        .ref(destination)
        .getDownloadURL();
    return url;
  } catch (e) {
    print(e);
    return null;
  }
}


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      // ignore: curly_braces_in_flow_control_structures
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(_selectedDate);
      });
  }
  // final RadioValue radioValue;
  // final Function(RadioValue?)? onRadioValueChange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Details"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Divider(
                          color: Colors.black,
                          height: 25,
                          thickness: 2,
                          indent: 5,
                          endIndent: 5,
                        ),
                        const Text("Your Profile"),
                        TextFormField(
                          controller: _ownerfNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                           },
                          decoration: const InputDecoration(
                            labelText: 'Your First Name',
                            ),
                          ),
                                              TextFormField(
                          controller: _ownerlNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                           },
                          decoration: const InputDecoration(
                            labelText: 'Your Last Name',
                            ),
                          ),
                          TextFormField(
                            key: const ValueKey("email"),
                            maxLines: 1,
                            readOnly: true,
                            style: const TextStyle(color: Colors.grey),
                            initialValue: widget.email,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                            ),
                          ),
                        TextFormField(
                          controller: _phoneController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter phone number';
                            }
                            return null;
                           },
                          decoration: const InputDecoration(
                            labelText: 'Phone number',
                            ),
                        ),
                        TextFormField(
                          controller: _cityController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your city';
                            }
                            return null;
                           },
                          decoration: const InputDecoration(
                            labelText: 'City',
                            ),
                        ),
                        ElevatedButton(
                          onPressed: _selectAndUploadOwnerImage,
                          child: const Text('Upload Picture'),
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: _ownerpictureController,
                            decoration: const InputDecoration(
                              labelText: 'Selected File',
                            ),
                          ),
                          const Divider(
                          color: Colors.black,
                          height: 25,
                          thickness: 2,
                          indent: 5,
                          endIndent: 5,
                        ),
                        const Text("Pet Profile"),
                        TextFormField(
                          controller: _fNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your pets First Name';
                            }
                            return null;
                           },
                          decoration: const InputDecoration(
                            labelText: 'Pets First Name',
                            ),
                        ),
                        TextFormField(
                          controller: _lNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your pets Last Name';
                            }
                            return null;
                           },
                          decoration: const InputDecoration(
                            labelText: 'Pets Last Name',
                            ),
                        ),
                        ElevatedButton(
                          onPressed: _selectAndUploadImage,
                          child: const Text('Upload Pets Picture'),
                          ),
                          const SizedBox(height: 16.0),
                        TextFormField(
                            controller: _ownerpictureController,
                            decoration: const InputDecoration(
                              labelText: 'Selected File',
                            ),
                          ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // form is valid, do something
                         
                        }
                      },
                      child: const Text('Submit'),
                      ),
                    ),
                      ],
                    ),
                  ),
                ),
          ],
        ),
        ),
    );
  }
}
    // var userId = UniqueKey().hashCode;
    // final provider = Provider.of<DigFirebaseProvider>(context);
    // final googleSignIn = provider.googleSignIn;
    // bool isLoggedIn = provider.isLoggedIn;

    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Your Details'),
        // actions: [
        //   if (isLoggedIn)
        //     IconButton(
        //         onPressed: () {
        //           FirebaseAuth.instance.signOut();
        //           googleSignIn.signOut();
        //           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //               content: Text(
        //                   'User: ${FirebaseAuth.instance.currentUser!.email} logged out')));
        //         },
        //         icon: const Icon(Icons.power_settings_new_outlined))
        // ],
//       ),
//