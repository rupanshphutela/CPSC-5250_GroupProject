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
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: [
                Center(
                  child: ListView.builder(
                    key: ValueKey("${direction}_SwipesListViewValueKey"),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: swipesList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xff764abc),
                        ),
                        title: Text(
                          '${swipesList[index].destinationProfileFName} ${swipesList[index].destinationProfileLName}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        subtitle: Text(
                            '${swipesList[index].destinationBreed}, ${swipesList[index].destinationColor}'),
                      );
                    },
                  ),
                ),
              ],
            ),
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
