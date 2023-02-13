import 'package:floor/floor.dart';
import 'left_swipe.dart';

@dao
abstract class LeftSwipeDao {
  @Query("SELECT * FROM left_swipe WHERE swiperProfileId = :profileId")
  Future<List<LeftSwipe>> getLeftSwipesBySwiperProfileId(String profileId);

  @Query("SELECT * FROM left_swipe WHERE swipedProfileId = :profileId")
  Future<List<LeftSwipe>> getLeftSwipesBySwipedProfileId(String profileId);

  @insert
  Future<void> insertLeftSwipe(LeftSwipe leftSwipe);

  @Query("SELECT * FROM left_swipe")
  Future<List<LeftSwipe>> getAllDisLikedProfiles();

  @delete
  Future<void> deleteLeftSwipe(LeftSwipe leftSwipe);
}
