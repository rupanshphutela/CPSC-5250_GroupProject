import 'package:floor/floor.dart';

import 'profile.dart';

@Entity(tableName: 'top_swipe', foreignKeys: [
  ForeignKey(
      childColumns: ['profileId'], parentColumns: ['id'], entity: Profile)
])
class TopSwipe {
  @primaryKey
  int? profileId;
  int? ownerId;
  String? swipeDate;
  int? targetId;
  TopSwipe({this.profileId, this.ownerId, this.swipeDate, this.targetId});
}
