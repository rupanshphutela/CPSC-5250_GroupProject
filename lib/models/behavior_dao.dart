import 'package:floor/floor.dart';
import 'behavior.dart';

@dao
abstract class BehaviorDao {
  @Query("SELECT * FROM behavior WHERE profileId = :profileId")
  Future<Behavior?> getBehaviorsByProfileId(String profileId);

  @insert
  Future<void> insertBehavior(Behavior behavior);

  @update
  Future<void> updateBehavior(Behavior behavior);

  @delete
  Future<void> deleteBehavior(Behavior behavior);
}
