
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


class AddProfile extends StatelessWidget {
  AddProfile(
      {super.key});

  @override
  Widget build(BuildContext context) {
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
  }
}
