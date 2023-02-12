import 'dart:ui';

import 'package:floor/floor.dart';
import 'left_swipe.dart';

@dao
abstract class LeftSwipeDao {
  @Query("SELECT * FROM left_swipe WHERE profileId = :profileId")
  Future<LeftSwipe> getLeftSwipesByProfileId(String profileId);

  @insert
  Future<void> insertLeftSwipe(LeftSwipe leftSwipe);

  @delete
  Future<void> deleteLeftSwipe(LeftSwipe leftSwipe);
}
