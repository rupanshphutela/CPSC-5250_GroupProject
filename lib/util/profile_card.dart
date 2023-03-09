import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:the_dig_app/models/profile.dart';

class ProfileCard extends StatelessWidget {
  final Profile card;

  const ProfileCard({
    required this.card,
    Key? key,
  }) : super(key: key);

  get direction => null;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 0.8,
        width: size.width * 0.95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(card.profilePicture == ""
                ? "assets/images/sample_image.jpg"
                : card.profilePicture),
            fit: BoxFit.fitWidth,
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
                    buildLikeBadge(direction: direction),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16, right: 8),
                      child: Icon(Icons.info, color: Colors.white),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildLikeBadge({required CardSwiperDirection? direction}) {
    if (direction?.name == 'right') {
      return Positioned(
          child: Transform.rotate(
        angle: 0.5,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green, width: 2),
          ),
          child: const Text(
            'DIG',
            style: TextStyle(
              color: Colors.green,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ));
    } else if (direction?.name == 'left') {
      return Positioned(
          child: Transform.rotate(
        angle: 0.5,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.pink, width: 2),
          ),
          child: const Text(
            'WOOF',
            style: TextStyle(
              color: Colors.pink,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ));
    } else if (direction?.name == 'top') {
      return Positioned(
          child: Transform.rotate(
        angle: 0.5,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.pink, width: 2),
          ),
          child: const Text(
            'SUPER DIG',
            style: TextStyle(
              color: Colors.pink,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ));
    } else {
      return Visibility(
        visible: false,
        child: Container(),
      );
    }
  }

  Widget buildUserInfo({required Profile card}) => Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              card.fName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${card.breed}, ${card.gender}',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 4),
          ],
        ),
      );
}
