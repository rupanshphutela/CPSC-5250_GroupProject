import 'package:floor/floor.dart';

import 'profile.dart';

@Entity(tableName: 'left_swipe', foreignKeys: [
  ForeignKey(
      childColumns: ['profileId'], parentColumns: ['id'], entity: Profile)
])
class LeftSwipe {
  @primaryKey
  int? profileId;
  int? ownerId;
  String? swipeDate;
  int? targetId;
  LeftSwipe({this.profileId, this.ownerId, this.swipeDate, this.targetId});
}
