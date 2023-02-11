import 'package:floor/floor.dart';

import 'dog_picture.dart';
import 'favorite_activity.dart';
import 'food_preference.dart';
import 'left_swipe.dart';
import 'other_fact.dart';
import 'right_swipe.dart';
import 'skill.dart';

@Entity(tableName: 'dog_profile')
class DogProfile {
  @primaryKey
  int id;
  String fName;
  String lName;
  String? profilePicturePath;
  List<DogPicture>? dogPictures;
  List<Skill>? skills;
  List<FoodPreference>? foodPreferences;
  List<RightSwipe>? rightSwipes;
  List<LeftSwipe>? leftSwipes;
  String ownerId;
  String? biography;
  String gender;
  String breed;
  String color;
  List<FavoriteActivity>? favoriteActivites;
  bool isVaccinated;
  String registrationDate;
  bool isSpayed;
  bool isNeutered;
  String joiningDate;
  String dogSize;
  List<OtherFact>? otherFacts;
  DogProfile(
      {required this.id,
      required this.fName,
      required this.lName,
      this.profilePicturePath,
      this.dogPictures,
      this.skills,
      this.foodPreferences,
      this.rightSwipes,
      this.leftSwipes,
      required this.ownerId,
      this.biography,
      required this.gender,
      required this.breed,
      required this.color,
      this.favoriteActivites,
      required this.isVaccinated,
      required this.registrationDate,
      required this.isSpayed,
      required this.isNeutered,
      required this.joiningDate,
      required this.dogSize,
      this.otherFacts});
}
