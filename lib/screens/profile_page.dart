import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:the_dig_app/models/profile.dart';
import 'package:the_dig_app/providers/dig_firebase_provider.dart';
import 'package:the_dig_app/screens/login_page.dart';
import 'package:the_dig_app/screens/owner_profile_form.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key, required this.email});
  String email;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late FirebaseStorage _storage;
  late Profile profile;

  List<String> _imageUrls = [];
  File? _imageFile;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _storage = FirebaseStorage.instance;
    _getImagesFromFirebaseStorage();
  }

  Future<void> _getImagesFromFirebaseStorage() async {
    Reference ref = _storage.ref().child('images/');
    ListResult result = await ref.listAll();

    result.items.forEach((Reference ref) async {
      String imageUrl = await ref.getDownloadURL();
      setState(() {
        _imageUrls.add(imageUrl);
      });
    });
  }

  Future<String?> _takePhotoWithCamera(int profileId) async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.camera);
    if (pickedFile == null) return null;

    final imageFile = File(pickedFile.path);
    final fileName = '${profileId}_profile.jpg';
    final destination = 'images/$profileId/$fileName';

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .putFile(imageFile);
      final url = await firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .getDownloadURL();
      setState(() {
        _imagePath = destination;
      });
      //update profile picture path in firestore profile doc
      final DocumentReference documentReference = FirebaseFirestore.instance
          .collection('profile')
          .doc(profileId.toString());
      await documentReference.update({
        'profilePicture': url,
      }).then((value) {
        debugPrint('Update picture to main profile successful');
      }).catchError((error) {
        debugPrint('Update failed: $error');
      });
      return url;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void _showImagePicker(BuildContext context, int profileId) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Profile Picture',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _takePhotoWithCamera(profileId);
                      context.pop();
                    },
                    child: Column(
                      children:const <Widget>[
                        Icon(
                          Icons.camera_alt,
                          size: 50,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Camera',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DigFirebaseProvider>(context);
    bool isLoggedIn = provider.isLoggedIn;
    if (isLoggedIn) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          actions: [
            IconButton(
              onPressed: () {
                provider.readProfiles(widget.email);
                context.push("/add/owner/profile?email=${widget.email}");
              },
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              Center(
                child: FutureBuilder<List<Profile>>(
                    future: provider.readProfiles(widget.email),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('${snapshot.error}'),
                        );
                      } else if (snapshot.hasData &&
                          snapshot.data!.isNotEmpty) {
                        var profileList = snapshot.data as List<Profile>;
                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: profileList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Stack(
                                            children: [
                                              CircleAvatar(
                                                radius: 150,
                                                backgroundImage: NetworkImage(profileList[index].profilePicture),
                                              ),
                                              Positioned(
                                                top: 210,
                                                right: 0,
                                                child: InkWell(
                                                  child: Container(
                                                    decoration: const BoxDecoration(
                                                      color: Colors.teal,
                                                      shape: BoxShape.circle,
                                                      
                                                    ),
                                                    padding: const EdgeInsets.all(8),
                                                    child: IconButton(
                                                      onPressed: () {
                                                        _showImagePicker(context, profileList[index].id);
                                                      },
                                                      icon: const Icon(Icons.camera_alt,
                                                                      color: Colors.white,),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                                  ],
                                                ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: 25, bottom: 25),
                                            // child: Container(),
                                            child: Text(
                                              'Owner Details',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          const Divider(),
                                          ListTile(
                                            leading: const Icon(Icons.person),
                                            title: const Text('Name'),
                                            subtitle: Text(
                                                "${profileList[index].ownerfName} ${profileList[index].ownerlName}"),
                                          ),
                                          const Divider(),
                                          ListTile(
                                            leading: const Icon(Icons.email),
                                            title: const Text('Email'),
                                            subtitle:
                                                Text(profileList[index].email),
                                          ),
                                          const Divider(),
                                          ListTile(
                                            leading: const Icon(Icons.phone),
                                            title: const Text('Phone'),
                                            subtitle: Text(profileList[index]
                                                .phone
                                                .toString()),
                                          ),
                                          const Divider(),
                                          ListTile(
                                            leading:
                                                const Icon(Icons.location_city),
                                            title: const Text('City'),
                                            subtitle:
                                                Text(profileList[index].city),
                                          ),
                                          const Divider(),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: 25, bottom: 25),
                                            child: Text(
                                              'Furry Friend Details',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          const Divider(),
                                          ListTile(
                                            leading: const Icon(Icons.pets),
                                            title: const Text('Name'),
                                            subtitle: Text(
                                                "${profileList[index].fName} ${profileList[index].lName}"),
                                          ),
                                          const Divider(),
                                          ListTile(
                                            leading:
                                                profileList[index].gender ==
                                                        "male"
                                                    ? const Icon(Icons.male)
                                                    : const Icon(Icons.female),
                                            title: const Text('Gender'),
                                            subtitle:
                                                Text(profileList[index].gender),
                                          ),
                                          const Divider(),
                                          ListTile(
                                            leading: const Icon(Icons.pets),
                                            title: const Text('Breed'),
                                            subtitle:
                                                Text(profileList[index].breed),
                                          ),
                                          const Divider(),
                                          ListTile(
                                            leading:
                                                const Icon(Icons.color_lens),
                                            title: const Text('Color'),
                                            subtitle:
                                                Text(profileList[index].color),
                                          ),
                                          const Divider(),
                                          ListTile(
                                            leading: const Icon(Icons.vaccines),
                                            title: const Text('Vaccinated'),
                                            subtitle: Text(profileList[index]
                                                .isVaccinated
                                                .toString()),
                                          ),
                                          const Divider(),
                                          ListTile(
                                            leading:
                                                const Icon(Icons.date_range),
                                            title:
                                                const Text('Registration Date'),
                                            subtitle: Text(profileList[index]
                                                .registrationDate
                                                .toString()),
                                          ),
                                          const Divider(),
                                          ListTile(
                                            leading:
                                                const Icon(Icons.date_range),
                                            title: const Text('Joining Date'),
                                            subtitle: Text(profileList[index]
                                                .joiningDate
                                                .toString()
                                                .substring(0, 10)),
                                          ),
                                          const Divider(),
                                          ListTile(
                                            leading:
                                                const Icon(Icons.rule_rounded),
                                            title: const Text('Size'),
                                            subtitle:
                                                Text(profileList[index].size),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      } else {
                        return const Center(child: Text('No profile yet'));
                      }
                    }),
              ),
              ElevatedButton(
                  onPressed: () {
                    context.push("/add/owner/profile?email=${widget.email}");
                  },
                  child: const Text("Edit Profile")),
            ],
          ),
        ),
        // body: Column(children: [
        //   Expanded(
        //     child: GridView.count(
        //       crossAxisCount: 2,
        //       children: List.generate(_imageUrls.length, (index) {
        //         return Center(
        //           child: Image.network(_imageUrls[index]),
        //         );
        //       }),
        //     ),
        //   ),
        //   ElevatedButton(
        //       onPressed: () {
        //         context.push("/add/owner/profile?email=${widget.email}");
        //       },
        //       child: const Text("Edit Profile")),
        // ]),
      );
    } else {
      const CircularProgressIndicator();

      return const LoginScreen();
    }
  }
}
