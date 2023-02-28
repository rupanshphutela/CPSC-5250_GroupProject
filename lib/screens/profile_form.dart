import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:the_dig_app/models/owner.dart';
import 'package:the_dig_app/providers/dig_provider_firebase.dart';

class ProfileForm extends StatelessWidget {
  ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FirebaseProvider>(context);
    Owner? ownerProfile = provider.ownerProfile;
    if (ownerProfile != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Add Profile'),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.push('/addprofileform');
          },
          label: const Text("Add Profiles"),
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
