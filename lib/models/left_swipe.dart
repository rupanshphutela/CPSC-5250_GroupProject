import 'package:floor/floor.dart';
import 'package:the_dig_app/models/owner.dart';

import 'profile.dart';

@Entity(tableName: 'left_swipe', foreignKeys: [
  ForeignKey(
      childColumns: ['swiperProfileId'],
      parentColumns: ['id'],
      entity: Profile),
  ForeignKey(
      childColumns: ['swipedProfileId'],
      parentColumns: ['id'],
      entity: Profile),
  ForeignKey(
      childColumns: ['swiperOwnerId'],
      parentColumns: ['ownerId'],
      entity: Profile),
  ForeignKey(
      childColumns: ['swiperOwnerId'], parentColumns: ['id'], entity: Owner),
])
class LeftSwipe {
  @primaryKey
  int? id;
  int? swiperProfileId;
  int? swiperOwnerId;
  String? swipeDate;
  int? swipedProfileId;
  LeftSwipe(
      {this.id,
      this.swiperProfileId,
      this.swiperOwnerId,
      this.swipeDate,
      this.swipedProfileId});
}
