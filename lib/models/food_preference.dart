import 'package:floor/floor.dart';

import 'profile.dart';

@Entity(tableName: 'food_preference', foreignKeys: [
  ForeignKey(
      childColumns: ['profileId'], parentColumns: ['id'], entity: Profile)
])
class FoodPreference {
  int? profileId;
  String? foodName;
  int? likingIndex;
  FoodPreference({
    this.profileId,
    this.foodName,
    this.likingIndex,
  });
}
