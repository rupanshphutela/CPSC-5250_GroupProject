import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart';

import '../util/profile_card.dart';

@Entity(tableName: 'profile')
class Profile {
  List<ProfileCard>? cards;
  @primaryKey
  int id;
  String fName;
  String lName;
  String profilePicture;
  int ownerId;
  String? biography;
  String gender;
  String breed;
  String color;
  bool isVaccinated;
  String registrationDate;
  bool isSpayed;
  bool isNeutered;
  String joiningDate;
  String size;
  Profile({
    required this.id,
    required this.fName,
    required this.lName,
    required this.profilePicture,
    required this.ownerId,
    this.biography,
    required this.gender,
    required this.breed,
    required this.color,
    required this.isVaccinated,
    required this.registrationDate,
    required this.isSpayed,
    required this.isNeutered,
    required this.joiningDate,
    required this.size,
    this.cards,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fName': fName,
      'lName': lName,
      'profilePicture': profilePicture,
      'ownerId': ownerId,
      'biography': biography,
      'gender': gender,
      'breed': breed,
      'color': color,
      'isVaccinated': isVaccinated,
      'registrationDate': registrationDate,
      'isSpayed': isSpayed,
      'isNeutered': isNeutered,
      'joiningDate': joiningDate,
      'size': size,
    };
  }

  @override
  String toString() {
    return 'Dog{id: $id, fName: $fName, lName: $lName, profilePicture: $profilePicture, ownerId: $ownerId, biography: $biography, gender: $gender}';
  }

  void addCard(ProfileCard card) {
    cards!.add(card);
  }
}
