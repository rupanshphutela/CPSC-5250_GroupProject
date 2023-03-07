import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_dig_app/models/swipe.dart';
import 'package:the_dig_app/providers/dig_firebase_provider.dart';
import 'package:the_dig_app/util/bottom_navigation_bar.dart';

class IncomingSwipesPage extends StatelessWidget {
  final String email;
  const IncomingSwipesPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DigFirebaseProvider>(context);
    List<Swipe> incomingSwipesList = provider.incomingSwipesList;

    if (incomingSwipesList.isNotEmpty) {
      int rowIndex = 0;
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Icon(Icons.person_add),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Action')),
                DataColumn(label: Text('')),
              ],
              rows: incomingSwipesList.map((swipe) {
                final int index = rowIndex++;
                return DataRow(cells: [
                  DataCell(Text(
                      "${swipe.sourceProfileFName} ${swipe.sourceProfileLName}")),
                  DataCell(Text(swipe.direction == 'top'
                      ? "Superlike"
                      : swipe.direction == 'right'
                          ? "Like"
                          : "Invalid operation")),
                  DataCell(
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.check_circle_outline)),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.highlight_off)),
                      ],
                    ),
                  )
                ]);
              }).toList(),
            ),
          ),
        ),
        bottomNavigationBar: DigBottomNavBar(email: email),
      );
    } else {
      provider.getIncomingSwipesList(email);
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Icon(Icons.swipe),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                "No incoming Likes/Superlikes found, but we'll keep checking...",
                style: TextStyle(fontSize: 16),
              ),
              Center(
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
