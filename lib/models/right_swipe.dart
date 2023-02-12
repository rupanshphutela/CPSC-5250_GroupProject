import 'package:floor/floor.dart';

import 'profile.dart';

@Entity(tableName: 'right_swipe', foreignKeys: [
  ForeignKey(
      childColumns: ['profileId'], parentColumns: ['id'], entity: Profile)
])
class RightSwipe {
  int? profileId;
  int? ownerId;
  String? swipeDate;
  int? targetId;
  RightSwipe({this.profileId, this.ownerId, this.swipeDate, this.targetId});
}
