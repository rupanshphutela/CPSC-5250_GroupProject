import 'package:floor/floor.dart';
import 'profile.dart';

@Entity(tableName: 'favorite_activity', foreignKeys: [
  ForeignKey(
      childColumns: ['profileId'], parentColumns: ['id'], entity: Profile)
])
class FavoriteActivity {
  @primaryKey
  int? profileId;
  String? activityName;
  int? likingIndex;
  FavoriteActivity({
    this.profileId,
    this.activityName,
    this.likingIndex,
  });
}
