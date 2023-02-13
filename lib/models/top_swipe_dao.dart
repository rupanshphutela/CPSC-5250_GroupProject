import 'package:floor/floor.dart';
import 'top_swipe.dart';

@dao
abstract class TopSwipeDao {
  @Query("SELECT * FROM top_swipe WHERE swiperProfileId = :profileId")
  Future<List<TopSwipe>> getTopSwipesBySwiperProfileId(String profileId);

  @Query("SELECT * FROM top_swipe WHERE swipedProfileId = :profileId")
  Future<List<TopSwipe>> getTopSwipesBySwipedProfileId(String profileId);

  @insert
  Future<void> insertTopSwipe(TopSwipe topSwipe);

  @Query("SELECT * FROM top_swipe")
  Future<List<TopSwipe>> getAllSuperlikedProfiles();

  @delete
  Future<void> deleteTopSwipe(TopSwipe topSwipe);
}
