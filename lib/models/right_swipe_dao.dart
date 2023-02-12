import 'dart:ui';

import 'package:floor/floor.dart';
import 'right_swipe.dart';

@dao
abstract class RightSwipeDao {
  @Query("SELECT * FROM right_swipe WHERE profileId = :profileId")
  Future<RightSwipe> getRightSwipesByProfileId(String profileId);

  @insert
  Future<void> insertRightSwipe(RightSwipe rightSwipe);

  @delete
  Future<void> deleteRightSwipe(RightSwipe rightSwipe);
}
