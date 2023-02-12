import 'package:floor/floor.dart';
import 'profile.dart';

@Entity(tableName: 'behavior', foreignKeys: [
  ForeignKey(
      childColumns: ['profileId'], parentColumns: ['id'], entity: Profile)
])
class Behavior {
  @primaryKey
  int? profileId;
  int? socialIndexHumans;
  int? socialIndexDogs;
  bool? isFoodAggressive;
  bool? isNewHumanAggressive;
  bool? isNewDogAggressive;

  Behavior({
    this.profileId,
    this.socialIndexHumans,
    this.socialIndexDogs,
    this.isFoodAggressive,
    this.isNewHumanAggressive,
    this.isNewDogAggressive,
  });
}
