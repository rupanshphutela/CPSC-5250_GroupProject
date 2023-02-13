import 'package:floor/floor.dart';
import 'right_swipe.dart';

@dao
abstract class RightSwipeDao {
  @Query("SELECT * FROM right_swipe WHERE profileId = :profileId")
  Future<RightSwipe?> getRightSwipesByProfileId(String profileId);

  @insert
  Future<void> insertRightSwipe(RightSwipe rightSwipe);

  @Query("SELECT * FROM right_swipe")
  Future<List<RightSwipe>> getAllLikedProfiles();

  @delete
  Future<void> deleteRightSwipe(RightSwipe rightSwipe);
}
