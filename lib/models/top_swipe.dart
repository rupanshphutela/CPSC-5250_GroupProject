import 'package:floor/floor.dart';
import 'package:the_dig_app/models/owner.dart';

import 'profile.dart';

@Entity(tableName: 'top_swipe', foreignKeys: [
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
class TopSwipe {
  @primaryKey
  int? id;
  int? swiperProfileId;
  int? swiperOwnerId;
  String? swipeDate;
  int? swipedProfileId;
  TopSwipe(
      {this.id,
      this.swiperProfileId,
      this.swiperOwnerId,
      this.swipeDate,
      this.swipedProfileId});
}
