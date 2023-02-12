import 'dart:ui';

import 'package:floor/floor.dart';
import 'top_swipe.dart';

@dao
abstract class TopSwipeDao {
  @Query("SELECT * FROM top_swipe WHERE profileId = :profileId")
  Future<TopSwipe?> getTopSwipesByProfileId(String profileId);

  @insert
  Future<void> insertTopSwipe(TopSwipe topSwipe);

  @delete
  Future<void> deleteTopSwipe(TopSwipe topSwipe);
}
