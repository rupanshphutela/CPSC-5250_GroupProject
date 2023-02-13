import 'package:floor/floor.dart';
import 'food_preference.dart';

@dao
abstract class FoodPreferenceDao {
  @Query("SELECT * FROM food_preference WHERE profileId = :profileId")
  Future<FoodPreference?> getFoodPreferencesByProfileId(String profileId);

  @insert
  Future<void> insertFoodPreference(FoodPreference foodPreference);

  @delete
  Future<void> deleteFoodPreference(FoodPreference foodPreference);
}
