import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:the_dig_app/models/owner.dart';
import 'package:the_dig_app/models/profile.dart';
import 'package:the_dig_app/providers/dig_provider_firebase.dart';
// import 'package:simple_permissions/simple_permissions.dart';

enum RadioValue { Male, Female}

const List<String> aggression = ['Yes', 'No'];

class OwnerProfileForm extends StatelessWidget {
  final String email;
  OwnerProfileForm({super.key, required this.email});

  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();//???? check why is it not working
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _pictureController = TextEditingController();
  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _socialHumansController = TextEditingController();
  final TextEditingController _socialDogsController = TextEditingController();
  final TextEditingController _aggressionController = TextEditingController();
  final TextEditingController _humanAggressionController = TextEditingController();
  final TextEditingController _dogAggressionController = TextEditingController();
  final TextEditingController _favoriteFoodController = TextEditingController();
  final TextEditingController _favoriteFoodRatingController = TextEditingController();
  final TextEditingController _favoriteActivityController = TextEditingController();
  final TextEditingController _favoriteActivityRatingController = TextEditingController();
  final TextEditingController _skillNameController = TextEditingController();
  final TextEditingController _skillProficienctController = TextEditingController();
  
  String gender = "male";
  bool? isVaccinated = false;
  String sterilization = "Spayed";
  // final RadioValue radioValue;
  // final Function(RadioValue?)? onRadioValueChange;

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
                    const Divider(
                      color: Colors.black,
                      height: 25,
                      thickness: 2,
                      indent: 5,
                      endIndent: 5,
                    ),       
                    const Text("Your Profile"),
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
                   ElevatedButton(
                    onPressed: () async {
                      final results = await FilePicker.platform.pickFiles(
                        allowMultiple: false,
                        type: FileType.custom,
                        allowedExtensions: ['png', 'jpg', 'jpeg'],
                      );

                      if (results == null){
                        ScaffoldMessenger.of(context)
                        .showSnackBar(
                          const SnackBar(
                            content: Text("No file selected")
                          )
                        );
                        return;
                      }

                      final path = results.files.single.path!;
                      final fileName = results.files.single.name;

                      print(path);
                      print(fileName);
                    }, 
                    child: const Text("Upload Image")
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
                      key: const ValueKey("petName"),
                      maxLines: 1,
                      maxLength: 20,
                      controller: _petNameController,
                      inputFormatters: [LengthLimitingTextInputFormatter(20)],
                      decoration: const InputDecoration(
                        labelText: 'Pet Name',
                      ),
                    ),
                    ElevatedButton(
                    onPressed: () async {
                      final results = await FilePicker.platform.pickFiles(
                        allowMultiple: false,
                        type: FileType.custom,
                        allowedExtensions: ['png', 'jpg', 'jpeg'],
                      );

                      if (results == null){
                        ScaffoldMessenger.of(context)
                        .showSnackBar(
                          const SnackBar(
                            content: Text("No file selected")
                          )
                        );
                        return;
                      }

                      final path = results.files.single.path!;
                      final fileName = results.files.single.name;

                      print(path);
                      print(fileName);
                    }, 
                    child: const Text("Upload Image")
                    ),
                    TextFormField(
                      key: const ValueKey("biography"),
                      maxLines: 1,
                      maxLength: 20,
                      controller: _bioController,
                      inputFormatters: [LengthLimitingTextInputFormatter(20)],
                      decoration: const InputDecoration(
                        labelText: 'Biography',
                      ),
                    ),
                    const Text("Gender"),
                    Column(
                      children: [
                          RadioListTile(
                              title: const Text("Male"),
                              value: "male", 
                              groupValue: gender, 
                              onChanged: (value){
                                  gender = value.toString();
                              },
                          ),

                          RadioListTile(
                              title: const Text("Female"),
                              value: "female", 
                              groupValue: gender, 
                              onChanged: (value){
                                  gender = value.toString();
                              },
                          ),
                      ],
                    ),
                    TextFormField(
                      key: const ValueKey("breed"),
                      maxLines: 1,
                      maxLength: 20,
                      controller: _breedController,
                      inputFormatters: [LengthLimitingTextInputFormatter(20)],
                      decoration: const InputDecoration(
                        labelText: 'Breed',
                      ),
                    ),
                    TextFormField(
                      key: const ValueKey("color"),
                      maxLines: 1,
                      maxLength: 20,
                      controller: _colorController,
                      inputFormatters: [LengthLimitingTextInputFormatter(20)],
                      decoration: const InputDecoration(
                        labelText: 'Color',
                      ),
                    ),
                    const Text("Fully Vaccinated"),
                    Checkbox(
                      value: isVaccinated, 
                      tristate: true,
                      onChanged: (newBool) {
                        isVaccinated = newBool;
                      }
                    ),
                    // Column(
                    //   children: [
                    //       RadioListTile(
                    //           title: const Text("Yes"),
                    //           value: "Yes", 
                    //           groupValue: vaccine, 
                    //           onChanged: (value){
                    //               vaccine = value.toString();
                    //           },
                    //       ),

                    //       RadioListTile(
                    //           title: const Text("No"),
                    //           value: "No", 
                    //           groupValue: vaccine, 
                    //           onChanged: (value){
                    //               vaccine = value.toString();
                    //           },
                    //       ),
                    //   ],
                    // ),
                    // Add registration date
                    const Text("Sterilization"),
                    Column(
                      children: [
                          RadioListTile(
                              title: const Text("Spayed"),
                              value: "Spayed", 
                              groupValue: sterilization, 
                              onChanged: (value){
                                  sterilization = value.toString();
                              },
                          ),

                          RadioListTile(
                              title: const Text("Neutered"),
                              value: "Neutered", 
                              groupValue: sterilization, 
                              onChanged: (value){
                                  sterilization = value.toString();
                              },
                          ),
                      ],
                    ),
                    // Add joining date
                    TextFormField(
                      key: const ValueKey("size"),
                      maxLines: 1,
                      maxLength: 20,
                      controller: _sizeController,
                      inputFormatters: [LengthLimitingTextInputFormatter(20)],
                      decoration: const InputDecoration(
                        labelText: 'Size',
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
                      maxLength: 20,
                      controller: _socialHumansController,
                      inputFormatters: [LengthLimitingTextInputFormatter(20)],
                      decoration: const InputDecoration(
                        labelText: 'Rate for Socializing with humans',
                      ),
                    ),
                    TextFormField(
                      key: const ValueKey("socialDogs"),
                      maxLines: 1,
                      maxLength: 20,
                      controller: _socialDogsController,
                      inputFormatters: [LengthLimitingTextInputFormatter(20)],
                      decoration: const InputDecoration(
                        labelText: 'Rate for Socializing with dogs',
                      ),
                    ),
                    DropdownButtonFormField(
                      key: const ValueKey("aggressionDropDown"),
                      value: _aggressionController.text.isNotEmpty
                          ? _aggressionController.text
                          : aggression[0],
                      decoration: const InputDecoration(
                        labelText: 'Gets aggressive when hungry',
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'No value selected';
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value == null) {
                          return 'No value selected';
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value == null) {
                          return 'No value selected';
                        }
                        return null;
                      },
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
                    ),
                    TextFormField(
                      key: const ValueKey("Rate the food liking on scale of 10"),
                      maxLines: 1,
                      maxLength: 20,
                      controller: _favoriteFoodRatingController,
                      inputFormatters: [LengthLimitingTextInputFormatter(20)],
                      decoration: const InputDecoration(
                        labelText: 'Favorite Food Rate',
                      ),
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
                    ),
                    TextFormField(
                      key: const ValueKey("Rate the activity liking on scale of 10"),
                      maxLines: 1,
                      maxLength: 20,
                      controller: _favoriteActivityRatingController,
                      inputFormatters: [LengthLimitingTextInputFormatter(20)],
                      decoration: const InputDecoration(
                        labelText: 'Favorite Activity Rate',
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                      height: 25,
                      thickness: 2,
                      indent: 5,
                      endIndent: 5,
                    ),
                    const Text("Skill"),
                    TextFormField(
                      key: const ValueKey("skillName"),
                      maxLines: 1,
                      maxLength: 20,
                      controller: _skillNameController,
                      inputFormatters: [LengthLimitingTextInputFormatter(20)],
                      decoration: const InputDecoration(
                        labelText: 'Skill Name',
                      ),
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
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(
                  (MediaQuery.of(context).size.width).toDouble() * 0.07),
              child: ElevatedButton(
                // onPressed: () async {
                  // if (_formKey.currentState!.validate()) { //???? check why is it not working
                //   if (_fNameController.text.isNotEmpty &&
                //       _lNameController.text.isNotEmpty &&
                //       _phoneController.text.isNotEmpty &&
                //       _cityController.text.isNotEmpty &&
                //       _pictureController.text.isNotEmpty) {
                //     var querySnapshot = await FirebaseFirestore.instance
                //         .collection('owner_profile')
                //         .where('email', isEqualTo: email)
                //         .get();
                //     if (querySnapshot.size <= 0) {
                //       await provider.addOwnerProfile(Owner(
                //           id: userId,
                //           fName: _fNameController.text,
                //           lName: _lNameController.text,
                //           phone: _phoneController.text,
                //           email: email,
                //           city: _cityController.text,
                //           picture: _pictureController.text));

                //       querySnapshot = await FirebaseFirestore.instance
                //           .collection('owner_profile')
                //           .where('id', isEqualTo: userId)
                //           .get();

                //       if (querySnapshot.size.isFinite) {
                //         context.push('/add/profile');
                //       } else {
                //         Exception(
                //             'The profile was not saved. Please try later');
                //       }
                //     } else {
                //       context.push('/add/profile');
                //     }
                //     // } //???? check why is it not working
                //   } else {
                //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //         content: Text('All fields are mandatory')));
                //   }
                // },
                onPressed: (){
                  final profile = Profile(
                    id: userId, 
                    ownerId: userId, 
                    ownerfName: _fNameController.text, 
                    ownerlName: _lNameController.text, 
                    email: email, 
                    phone: int.parse(_phoneController.text), 
                    city: _cityController.text, 
                    ownerprofilePicture: "_pictureController.text", 
                    fName: _petNameController.text, 
                    profilePicture: "_pictureController.text",
                    gender: gender,
                    breed: _breedController.text, 
                    color: _colorController.text, 
                    isVaccinated: isVaccinated!, 
                    registrationDate: DateTime.now().toString(), 
                    joiningDate: DateTime.now().toString(), 
                    size: _sizeController.text,
                    );
                    createProfile(profile);
                    context.push('/add/profile');
                },
                child: const Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
    Future createProfile(Profile profile) async {
    final docUser = FirebaseFirestore.instance.collection("profile").doc(_fNameController.text);
    final json = profile.toJson();
    await docUser.set(json);
  }
}
