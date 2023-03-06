import 'package:flutter/material.dart';
import 'package:the_dig_app/util/bottom_navigation_bar.dart';
import 'chat.dart';
import 'package:the_dig_app/providers/dig_firebase_provider.dart';
import 'package:provider/provider.dart';

class Matched extends StatelessWidget {
  static const String id = 'matched';
  final String profilePicture;
  final String userId;
  final String otherProfilePicture;
  final String otherUserId;
  final String email;

  const Matched({
    required this.userId,
    required this.profilePicture,
    required this.otherProfilePicture,
    required this.otherUserId,
    required this.email,
  });

  void sendMessagePressed(BuildContext context) async {
    final user = Provider.of<DigFirebaseProvider>(context);

    Navigator.pop(context);
    Navigator.pushNamed(
        context,
        Chat(
          chatId: '',
          otherUserId: '',
          userId: '',
          email: '',
        ) as String,
        arguments: {
          "chat_id": compareAndCombineIds(userId, otherUserId),
          "user_id": user,
          "other_user_id": otherUserId
        });
  }

  void keepSwipingPressed(BuildContext context) {
    Navigator.pop(context);
  }

  String compareAndCombineIds(String userID1, String userID2) {
    if (userID1.compareTo(userID2) < 0) {
      return userID2 + userID1;
    } else {
      return userID1 + userID2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 42.0,
            horizontal: 18.0,
          ),
          margin: const EdgeInsets.only(bottom: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // profilePicture,
                    // otherProfilePicture,
                  ],
                ),
              ),
              Column(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        sendMessagePressed(context);
                      },
                      child: const Text('SEND MESSAGE')),
                  ElevatedButton(
                    onPressed: () {
                      keepSwipingPressed(context);
                    },
                    child: const Text('KEEP SWIPING'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: DigBottomNavBar(email: email),
    );
  }
}
