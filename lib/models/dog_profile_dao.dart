import 'package:floor/floor.dart';
import './dog_profile.dart';

@dao
abstract class DogProfileDao {
  @Query("SELECT * FROM dog_profile WHERE id = :dogProfileId")
  Future<DogProfile> getDogProfileById(String dogProfileId);

  @insert
  Future<void> insertDogProfile(DogProfile dogProfile);

  @update
  Future<void> updateDogProfile(DogProfile dogProfile);

  @delete
  Future<void> deleteDogProfile(DogProfile dogProfile);
}
