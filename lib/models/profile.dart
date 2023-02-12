import 'package:floor/floor.dart';

import 'picture.dart';
import 'favorite_activity.dart';
import 'food_preference.dart';
import 'left_swipe.dart';
import 'other_fact.dart';
import 'right_swipe.dart';
import 'skill.dart';

@Entity(tableName: 'profile')
class Profile {
  @primaryKey
  int id;
  String fName;
  String lName;
  String? profilePicture;
  List<Picture>? picture;
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
  String size;
  List<OtherFact>? otherFacts;
  Profile(
      {required this.id,
      required this.fName,
      required this.lName,
      this.profilePicture,
      this.picture,
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
      required this.size,
      this.otherFacts});
}
