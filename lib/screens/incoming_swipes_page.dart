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
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Icon(Icons.person_add),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: [
                Center(
                  child: ListView.builder(
                    key: const ValueKey("IncomingSwipesListViewValueKey"),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: incomingSwipesList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xff764abc),
                        ),
                        title: Text(
                          '${incomingSwipesList[index].sourceProfileFName} ${incomingSwipesList[index].sourceProfileLName}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        subtitle: Text(
                            'Breed: ${incomingSwipesList[index].sourceBreed}, \nColor: ${incomingSwipesList[index].sourceColor}, \nAction: ${incomingSwipesList[index].direction == "top" ? "Superlike" : incomingSwipesList[index].direction == "right" ? "Like" : "Invalid"}'),
                        trailing: Wrap(
                          spacing: 12,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.brown,
                              child: IconButton(
                                icon: const Icon(Icons.check_circle_outline),
                                onPressed: () async {},
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.brown,
                              child: IconButton(
                                icon: const Icon(Icons.highlight_off),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
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
