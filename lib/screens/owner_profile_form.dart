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
import 'package:the_dig_app/screens/login_page.dart';
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
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); //???? check why is it not working
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
  int profileId = UniqueKey().hashCode;
  int ownerId = UniqueKey().hashCode;
  String? ownerfName;
  final alphabetsPattern = RegExp(r'^[a-zA-Z]+$');
  final digitsPattern = RegExp(r'^[1-9]|10$');

  Future<String?> _selectAndUploadOwnerImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile == null) return null;

    final imageFile = File(pickedFile.path);
    final fileName = '${ownerId}_owner.jpg';
    final destination = 'images/$ownerId/$fileName';

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
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile == null) return null;

    final imageFile = File(pickedFile.path);
    final fileName =
        '${profileId}_profile.jpg';
    final destination = 'images/$profileId/$fileName';

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
    final provider = Provider.of<DigFirebaseProvider>(context);
    final profileList = provider.readProfiles(widget.email);
    bool isLoggedIn = provider.isLoggedIn;
    if (isLoggedIn) {
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
                child: FutureBuilder<List<Profile>>(
                future: profileList,
                builder: (context, snapshot) {
                if (snapshot.hasData  && snapshot.data!.isNotEmpty) {
                  var profiles = snapshot.data as List<Profile>;
                  return Form(
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
                        initialValue: profiles[0].ownerfName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          if (!alphabetsPattern.hasMatch(value)) {
                            return 'Please enter valid first name';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          ownerfName = value;
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
                          if (!alphabetsPattern.hasMatch(value)) {
                            return 'Please enter valid last name';
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
                          if (!digitsPattern.hasMatch(value)) {
                            return 'Please enter valid phone number';
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
                          if (!alphabetsPattern.hasMatch(value)) {
                            return 'Please enter valid city';
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
                          if (!alphabetsPattern.hasMatch(value)) {
                            return 'Please enter valid first name';
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
                          if (!alphabetsPattern.hasMatch(value)) {
                            return 'Please enter valid last name';
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
                      const Divider(
                        color: Colors.black,
                        height: 25,
                        thickness: 2,
                        indent: 5,
                        endIndent: 5,
                      ),
                      TextFormField(
                        controller: _bioController,
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            if (!alphabetsPattern.hasMatch(value)) {
                              return 'Please enter valid bio';
                            }
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Pets Biography',
                        ),
                      ),
                      const Text(
                        'Gender:',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      RadioListTile(
                        title: const Text('Male'),
                        value: 'male',
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value!;
                          });
                        },
                      ),
                      RadioListTile(
                        title: const Text('Female'),
                        value: 'female',
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value!;
                          });
                        },
                      ),
                      TextFormField(
                        controller: _breedController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your breed';
                          }
                          if (!alphabetsPattern.hasMatch(value)) {
                            return 'Please enter valid breed name';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Pets Breed',
                        ),
                      ),
                      TextFormField(
                        controller: _colorController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your pets color';
                          }
                          if (!alphabetsPattern.hasMatch(value)) {
                            return 'Please enter valid color';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Pets Color',
                        ),
                      ),
                      CheckboxListTile(
                        title: const Text('Is Vaccinated?'),
                        value: _isChecked,
                        onChanged: (checked) {
                          setState(() {
                            _isChecked = checked!;
                          });
                        },
                      ),
                      const Text(
                        'Date of birth:',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        onTap: () => _selectDate(context),
                        controller: TextEditingController(
                          text: _selectedDate == null
                              ? ''
                              : DateFormat('yyyy-MM-dd').format(_selectedDate),
                        ),
                        readOnly: true,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                      ),
                      const Text(
                        'Sterilization:',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      RadioListTile(
                        title: const Text('Spayed'),
                        value: 'spayed',
                        groupValue: sterilization,
                        onChanged: (value) {
                          setState(() {
                            sterilization = value!;
                          });
                        },
                      ),
                      RadioListTile(
                        title: const Text('Neutered'),
                        value: 'neutered',
                        groupValue: sterilization,
                        onChanged: (value) {
                          setState(() {
                            sterilization = value!;
                          });
                        },
                      ),
                      TextFormField(
                        controller: _sizeController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your pets size';
                          }
                          if (!alphabetsPattern.hasMatch(value)) {
                            return 'Please enter valid size';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Pets Size',
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                        height: 25,
                        thickness: 2,
                        indent: 5,
                        endIndent: 5,
                      ),
                      const Text("Behavior"),
                      TextFormField(
                        key: const ValueKey("socialHumans"),
                        maxLines: 1,
                        maxLength: 2,
                        controller: _socialHumansController,
                        inputFormatters: [LengthLimitingTextInputFormatter(20)],
                        decoration: const InputDecoration(
                          labelText: 'Rate for Socializing with humans',
                        ),
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            if (!digitsPattern.hasMatch(value)) {
                              return 'Please enter only digits between 1 to 10';
                            }
                          }
                        },
                      ),
                      TextFormField(
                        key: const ValueKey("socialDogs"),
                        maxLines: 1,
                        maxLength: 2,
                        controller: _socialDogsController,
                        inputFormatters: [LengthLimitingTextInputFormatter(20)],
                        decoration: const InputDecoration(
                          labelText: 'Rate for Socializing with dogs',
                        ),
                         validator: (value) {
                          if (value!.isNotEmpty) {
                            if (!digitsPattern.hasMatch(value)) {
                              return 'Please enter only digits between 1 to 10';
                            }
                          }
                        },
                      ),
                      DropdownButtonFormField(
                        key: const ValueKey("aggressionDropDown"),
                        value: _aggressionController.text.isNotEmpty
                            ? _aggressionController.text
                            : aggression[0],
                        decoration: const InputDecoration(
                          labelText: 'Gets aggressive when hungry',
                        ),
                        items: aggression
                            .map(((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                )))
                            .toList(),
                        onChanged: (value) {
                          _aggressionController.text = value as String;
                        },
                      ),
                      DropdownButtonFormField(
                        key: const ValueKey("humanAggressionDropDown"),
                        value: _humanAggressionController.text.isNotEmpty
                            ? _humanAggressionController.text
                            : aggression[0],
                        decoration: const InputDecoration(
                          labelText: 'Gets aggressive when meets new Humans',
                        ),
                        items: aggression
                            .map(((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                )))
                            .toList(),
                        onChanged: (value) {
                          _humanAggressionController.text = value as String;
                        },
                      ),
                      DropdownButtonFormField(
                        key: const ValueKey("dogAggressionDropDown"),
                        value: _dogAggressionController.text.isNotEmpty
                            ? _dogAggressionController.text
                            : aggression[0],
                        decoration: const InputDecoration(
                          labelText: 'Gets aggressive when meets new Dogs',
                        ),
                        items: aggression
                            .map(((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                )))
                            .toList(),
                        onChanged: (value) {
                          _dogAggressionController.text = value as String;
                        },
                      ),
                      const Divider(
                        color: Colors.black,
                        height: 25,
                        thickness: 2,
                        indent: 5,
                        endIndent: 5,
                      ),
                      const Text("Food Preference"),
                      TextFormField(
                        key: const ValueKey("Favorite Food"),
                        maxLines: 1,
                        maxLength: 20,
                        controller: _favoriteFoodController,
                        inputFormatters: [LengthLimitingTextInputFormatter(20)],
                        decoration: const InputDecoration(
                          labelText: 'Favorite Food',
                        ),
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            if (!alphabetsPattern.hasMatch(value)) {
                              return 'Please enter valid food';
                            }
                          }
                        },
                      ),
                      TextFormField(
                        key: const ValueKey(
                            "Rate the food liking on scale of 10"),
                        maxLines: 1,
                        maxLength: 2,
                        controller: _favoriteFoodRatingController,
                        inputFormatters: [LengthLimitingTextInputFormatter(20)],
                        decoration: const InputDecoration(
                          labelText: 'Favorite Food Rate',
                        ),
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            if (!digitsPattern.hasMatch(value)) {
                              return 'Please enter only digits between 1 to 10';
                            }
                          }
                        },
                      ),
                      const Divider(
                        color: Colors.black,
                        height: 25,
                        thickness: 2,
                        indent: 5,
                        endIndent: 5,
                      ),
                      const Text("Favorite Activites"),
                      TextFormField(
                        key: const ValueKey("Favorite Activity"),
                        maxLines: 1,
                        maxLength: 20,
                        controller: _favoriteActivityController,
                        inputFormatters: [LengthLimitingTextInputFormatter(20)],
                        decoration: const InputDecoration(
                          labelText: 'Favorite Activity',
                        ),
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            if (!alphabetsPattern.hasMatch(value)) {
                                return 'Please enter valid activity';
                              }
                          }
                        },
                      ),
                      TextFormField(
                        key: const ValueKey(
                            "Rate the activity liking on scale of 10"),
                        maxLines: 1,
                        maxLength: 2,
                        controller: _favoriteActivityRatingController,
                        inputFormatters: [LengthLimitingTextInputFormatter(20)],
                        decoration: const InputDecoration(
                          labelText: 'Favorite Activity Rate',
                        ),
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            if (!digitsPattern.hasMatch(value)) {
                              return 'Please enter only digits between 1 to 10';
                            }
                          }
                        },
                      ),
                      const Divider(
                        color: Colors.black,
                        height: 25,
                        thickness: 2,
                        indent: 5,
                        endIndent: 5,
                      ),
                      const Text("Skills"),
                      TextFormField(
                        key: const ValueKey("skillName"),
                        maxLines: 1,
                        maxLength: 20,
                        controller: _skillNameController,
                        inputFormatters: [LengthLimitingTextInputFormatter(20)],
                        decoration: const InputDecoration(
                          labelText: 'Skill Name',
                        ),
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            if (!alphabetsPattern.hasMatch(value)) {
                                return 'Please enter valid skill';
                              }
                          }  
                        },
                      ),
                      TextFormField(
                        key: const ValueKey("skillProficiency"),
                        maxLines: 1,
                        maxLength: 20,
                        controller: _skillProficienctController,
                        inputFormatters: [LengthLimitingTextInputFormatter(20)],
                        decoration: const InputDecoration(
                          labelText: 'Skill Proficiency',
                        ),
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            if (!alphabetsPattern.hasMatch(value)) {
                                return 'Please enter valid proficiency';
                              }
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // form is valid, do something
                              final profile = Profile(
                                id: profileId,
                                ownerId: ownerId,
                                ownerfName: _ownerfNameController.text,
                                ownerlName: _ownerlNameController.text,
                                email: widget.email,
                                phone: int.parse(_phoneController.text),
                                city: _cityController.text,
                                ownerprofilePicture:
                                    _ownerpictureController.text,
                                fName: _fNameController.text,
                                lName: _lNameController.text,
                                profilePicture: _pictureController.text,
                                gender: _gender,
                                breed: _breedController.text,
                                color: _colorController.text,
                                isVaccinated: _isChecked,
                                registrationDate: _dateController.text,
                                joiningDate: DateTime.now().toString(),
                                size: _sizeController.text,
                              );
                              provider.createProfile(
                                  profile, profileId.toString());
                              context.pop();
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    ),
              ),
            ],
          ),
        ),
      );
    } else {
      const CircularProgressIndicator();

      return const LoginScreen();
    }
  }
}
