import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key, required this.email});
  String email;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late FirebaseStorage _storage;

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image List'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(_imageUrls.length, (index) {
          return Center(
            child: Image.network(_imageUrls[index]),
          );
        }),
      ),
    );
  }
}