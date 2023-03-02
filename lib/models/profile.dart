import 'package:floor/floor.dart';

@Entity(tableName: 'profile')
class Profile {
  @primaryKey
  int id;
  String ownerfName;
  String ownerlName;
  String email;
  int phone;
  String city;
  String ownerprofilePicture;
  String fName;
  String profilePicture;
  int ownerId;
  String? biography;
  String gender;
  String breed;
  String color;
  bool isVaccinated;
  String registrationDate;
  bool? isSpayed;
  bool? isNeutered;
  String joiningDate;
  String size;
  int? socialIndexHumans;
  int? socialIndexDogs;
  bool? isFoodAggressive;
  bool? isNewHumanAggressive;
  bool? isNewDogAggressive;
  String? foodName;
  int? foodLikingIndex;
  String? activityName;
  int? activityLikingIndex;
  String? skillName;
  String? skillProficiency;


  Profile({
    required this.id,
    required this.ownerId,
    required this.ownerfName,
    required this.ownerlName,
    required this.email,
    required this.phone,
    required this.city,
    required this.ownerprofilePicture,
    required this.fName,
    required this.profilePicture,
    this.biography,
    required this.gender,
    required this.breed,
    required this.color,
    required this.isVaccinated,
    required this.registrationDate,
    this.isSpayed,
    this.isNeutered,
    required this.joiningDate,
    required this.size,
    this.socialIndexHumans,
    this.socialIndexDogs,
    this.isFoodAggressive,
    this.isNewHumanAggressive,
    this.isNewDogAggressive,
    this.foodName,
    this.foodLikingIndex,
    this.activityName,
    this.activityLikingIndex,
    this.skillName,
    this.skillProficiency,
  });

  Map<String, dynamic> toJson() => {
      'id': id,
      'ownerId': ownerId,
      'ownerfName': ownerfName,
      'lName': ownerlName,
      'ownerlName': profilePicture,
      'email': email,
      'phone': phone,
      'city': city,
      'ownerprofilePicture': ownerprofilePicture,
      'fName': fName,
      'profilePicture': profilePicture,
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
      'socialIndexHumans': socialIndexHumans,
      'socialIndexDogs': socialIndexDogs,
      'isFoodAggressive': isFoodAggressive,
      'isNewHumanAggressive': isNewHumanAggressive,
      'isNewDogAggressive': isNewDogAggressive,
      'foodName': foodName,
      'foodLikingIndex': foodLikingIndex,
      'activityName': activityName,
      'activityLikingIndex': activityLikingIndex,
      'skillName': skillName,
      'skillProficiency': skillProficiency,
  };

  // @override
  // String toString() {
  //   return 'Dog{id: $id, fName: $fName, lName: $lName, profilePicture: $profilePicture, ownerId: $ownerId, biography: $biography, gender: $gender}';
  // }
}
