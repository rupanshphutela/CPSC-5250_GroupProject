import 'package:floor/floor.dart';
import 'profile.dart';

@dao
abstract class ProfileDao {
  @Query("SELECT * FROM profile WHERE id = :profileId ")
  Future<Profile?> getProfileByProfileId(String profileId);

  @Query(
      "SELECT * FROM profile where id not in (select profileId from right_swipe union select profileId from left_swipe) ")
  Future<List<Profile>> getAllProfiles();

  @insert
  Future<void> insertProfile(Profile profile);

  @update
  Future<void> updateProfile(Profile profile);

  @delete
  Future<void> deleteProfile(Profile profile);
}
