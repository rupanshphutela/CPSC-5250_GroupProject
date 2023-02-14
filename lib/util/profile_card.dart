import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_dig_app/models/profile.dart';
import 'package:the_dig_app/providers/feedback_position_provider.dart';

class ProfileCard extends StatelessWidget {
  final Profile card;
  final bool isUserinFocus;

  const ProfileCard({
    required this.card,
    required this.isUserinFocus,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<FeedbackPositionProvider>(context);
    final swipingDirection = provider.swipingDirection;
    return Container(
      height: size.height * 0.8,
      width: size.width * 0.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(card.profilePicture),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(color: Colors.black12, spreadRadius: 0.5),
          ],
          gradient: const LinearGradient(
            colors: [Colors.black12, Colors.black87],
            begin: Alignment.center,
            stops: [0.4, 1],
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: 10,
              left: 10,
              bottom: 10,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildUserInfo(card: card),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 16, right: 8),
                    child: Icon(Icons.info, color: Colors.white),
                  )
                ],
              ),
            ),
            if (isUserinFocus) buildLikeBadge(swipingDirection)
          ],
        ),
      ),
    );
  }

  Widget buildLikeBadge(SwipingDirection swipingDirection) {
    final isSwipingRight = swipingDirection == SwipingDirection.right;
    final isSwipingUp = swipingDirection == SwipingDirection.up;
    final color = isSwipingRight ? Colors.green : Colors.pink;
    final angle = isSwipingRight ? -0.5 : 0.5;

    if (swipingDirection == SwipingDirection.none) {
      return Container();
    } else {
      return Positioned(
        top: isSwipingUp ? null : 20,
        right: isSwipingRight ? null : 20,
        left: isSwipingRight ? 20 : null,
        child: Transform.rotate(
          angle: angle,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: color, width: 2),
            ),
            child: Text(
              _getMessage(isSwipingUp, isSwipingRight),
              style: TextStyle(
                color: color,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }
  }

  String _getMessage(bool isSwipingUp, bool isSwipingRight) {
    if (isSwipingUp) {
      return 'SUPER DIG';
    } else if (isSwipingRight) {
      return 'DIG';
    } else {
      return 'WOOF';
    }
  }

  Widget buildUserInfo({required Profile card}) => Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${card.fName}, ${card.breed}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              card.gender,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 4),
          ],
        ),
      );
}
