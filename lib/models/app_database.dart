import 'dart:async';
import 'package:floor/floor.dart';

import './dog_profile.dart';
import './dog_profile_dao.dart';

part 'app_database.g.dart'; // the generated code will be here

@Database(version: 1, entities: [
  DogProfile,
]) // ,views: [DigDogProfiles]
abstract class AppDatabase extends FloorDatabase {
  DogProfileDao get dogProfileDao;
}
