import 'package:floor/floor.dart';

@Entity(tableName: 'profile')
class Profile {
  @primaryKey
  int id;
  String fName;
  String lName;
  String? profilePicture;
  String ownerId;
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
    this.profilePicture,
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
  });
}
