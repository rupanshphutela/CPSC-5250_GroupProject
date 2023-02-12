import 'dart:async';
import 'package:floor/floor.dart';
import 'package:my_dig_app/models/picture.dart';
import 'package:my_dig_app/models/pictures_dao.dart';
import 'package:my_dig_app/models/skill.dart';

import 'profile.dart';
import 'profile_dao.dart';
import 'owner.dart';
import 'owner_dao.dart';
import 'skill_dao.dart';

part 'app_database.g.dart'; // the generated code will be here

@Database(
    version: 1,
    entities: [Profile, Owner, Picture, Skill]) // ,views: [DigDogProfiles]
abstract class AppDatabase extends FloorDatabase {
  ProfileDao get dogProfileDao;
  OwnerDao get ownerProfileDao;
  PictureDao get dogPictureDao;
  SkillDao get skillDao;
}
