import 'dart:ui';

import 'package:floor/floor.dart';
import 'favorite_activity.dart';

@dao
abstract class FavoriteActivityDao {
  @Query("SELECT * FROM favorite_activity WHERE profileId = :profileId")
  Future<FavoriteActivity?> getFavoriteActivitiesByProfileId(String profileId);

  @insert
  Future<void> insertFavoriteActivity(FavoriteActivity favoriteActivity);

  @delete
  Future<void> deleteFavoriteActivity(FavoriteActivity favoriteActivity);
}
