import 'dart:ui';

import 'package:floor/floor.dart';
import 'picture.dart';

@dao
abstract class PictureDao {
  @Query("SELECT * FROM pictures WHERE profileId = :profileId")
  Future<Picture> getPicturesByProfileId(String profileId);

  @insert
  Future<void> insertPicture(Picture picture);

  @delete
  Future<void> deletePicture(Picture picture);
}
