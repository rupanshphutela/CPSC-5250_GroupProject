import 'dart:ui';

import 'package:floor/floor.dart';
import 'picture.dart';

@dao
abstract class PictureDao {
  @Query("SELECT * FROM pictures WHERE dogId = :dogId")
  Future<Picture> getPicturesById(String dogId);

  @insert
  Future<void> insertPicture(Picture picture);

  @delete
  Future<void> deletePicture(Picture picture);
}
