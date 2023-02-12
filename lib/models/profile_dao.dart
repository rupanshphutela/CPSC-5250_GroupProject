import 'package:floor/floor.dart';
import 'profile.dart';

@dao
abstract class ProfileDao {
  @Query("SELECT * FROM profile WHERE id = :profileId")
  Future<Profile> getProfileByProfileId(String profileId);

  @insert
  Future<void> insertProfile(Profile profile);

  @update
  Future<void> updateProfile(Profile profile);

  @delete
  Future<void> deleteProfile(Profile profile);
}
