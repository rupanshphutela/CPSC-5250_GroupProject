import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_dig_app/models/swipe.dart';
import 'package:the_dig_app/providers/dig_firebase_provider.dart';
import 'package:the_dig_app/util/bottom_navigation_bar.dart';

class SwipesPage extends StatelessWidget {
  final String direction;
  final String email;
  const SwipesPage({super.key, required this.email, required this.direction});

  @override
  Widget build(context) {
    final provider = Provider.of<DigFirebaseProvider>(context);
    List<Swipe> swipesList = provider.swipesList;

    if (swipesList.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Icon(Icons.swipe),
        ),
        body: SafeArea(
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Swipe Date')),
            ],
            rows: swipesList.map((swipe) {
              return DataRow(cells: [
                DataCell(Text(
                    "${swipe.sourceProfileFName} ${swipe.sourceProfileLName}")),
                DataCell(Text(swipe.swipeDate)),
              ]);
            }).toList(),
          ),
        ),
        bottomNavigationBar: DigBottomNavBar(email: email),
      );
    } else {
      provider.getSwipesList(email, direction);
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Icon(Icons.swipe),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "No $direction swipes found, but we'll keep checking...",
                style: const TextStyle(fontSize: 16),
              ),
              const Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        ),
        bottomNavigationBar: DigBottomNavBar(email: email),
      );
    }
  }
}
