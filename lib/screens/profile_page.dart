import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:the_dig_app/models/profile.dart';
import 'package:the_dig_app/providers/dig_firebase_provider.dart';
import 'package:the_dig_app/screens/login_page.dart';
import 'package:the_dig_app/screens/owner_profile_form.dart';

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


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DigFirebaseProvider>(context);
    bool isLoggedIn = provider.isLoggedIn;
    if (isLoggedIn) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Center(
                    child: FutureBuilder<List<Profile>>(
                      future: provider.readProfiles(widget.email),
                      builder: (context, snapshot) {
                        if(snapshot.hasError) {
                          return Center(child: Text('${snapshot.error}'),);
                        } else if(snapshot.hasData  && snapshot.data!.isNotEmpty){
                          var profileList = snapshot.data as List<Profile>;
                          return ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: profileList.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: MediaQuery.of(context).size.height,
                                      child: SingleChildScrollView(
                                      child: Card(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                 const Padding(
                                                  padding: EdgeInsets.only(top: 25, bottom: 25),
                                                  child: Text(
                                                    'Owner Details',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: const Icon(Icons.person),
                                                  title: const Text('Name'),
                                                  subtitle: Text("${profileList[index].ownerfName} ${profileList[index].ownerlName}"),
                                                ),
                                                ListTile(
                                                  leading: const Icon(Icons.email),
                                                  title: const Text('Email'),
                                                  subtitle: Text(profileList[index].email),
                                                ),
                                                ListTile(
                                                  leading: const Icon(Icons.phone),
                                                  title: const Text('Phone'),
                                                  subtitle: Text(profileList[index].phone.toString()),
                                                ),
                                                ListTile(
                                                  leading: const Icon(Icons.location_city),
                                                  title: const Text('City'),
                                                  subtitle: Text(profileList[index].city),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(top: 25, bottom: 25),
                                                  child: Text(
                                                    'Furry Friend Details',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: const Icon(Icons.pets),
                                                  title: const Text('Name'),
                                                  subtitle: Text("${profileList[index].fName} ${profileList[index].lName}"),
                                                ),
                                                ListTile(
                                                  leading: profileList[index].gender == "male"? const Icon(Icons.male): const Icon(Icons.female),
                                                  title: const Text('Gender'),
                                                  subtitle: Text(profileList[index].gender),
                                                ),
                                                ListTile(
                                                  leading: const Icon(Icons.pets),
                                                  title: const Text('Breed'),
                                                  subtitle: Text(profileList[index].breed),
                                                ),
                                                ListTile(
                                                  leading: const Icon(Icons.color_lens),
                                                  title: const Text('Color'),
                                                  subtitle: Text(profileList[index].color),
                                                ),
                                                ListTile(
                                                  leading: const Icon(Icons.vaccines),
                                                  title: const Text('Vaccinated'),
                                                  subtitle: Text(profileList[index].isVaccinated.toString()),
                                                ),
                                                ListTile(
                                                  leading: const Icon(Icons.date_range),
                                                  title: const Text('Registration Date'),
                                                  subtitle: Text(profileList[index].registrationDate.toString()),
                                                ),
                                                ListTile(
                                                  leading: const Icon(Icons.date_range),
                                                  title: const Text('Joining Date'),
                                                  subtitle: Text(profileList[index].joiningDate.toString()),
                                                ),
                                                ListTile(
                                                  leading: const Icon(Icons.rule_rounded),
                                                  title: const Text('Size'),
                                                  subtitle: Text(profileList[index].size),
                                                ),
                                                ListTile(
                                                  leading: const Icon(Icons.rule_rounded),
                                                  title: const Text('Size'),
                                                  subtitle: Text(profileList[index].size),
                                                ),
                                              ],
                                            ),
                                          ),
                                  ],
                              ),
                          ),
                           ));
                                  },
                                );
                        }
                        else {
                          return const Center(child: Text('No personal tasks yet'));
                        }
                    }
    
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

 