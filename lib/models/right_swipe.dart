import 'package:floor/floor.dart';

import 'profile.dart';

@Entity(tableName: 'right_swipe', foreignKeys: [
  ForeignKey(
      childColumns: ['swipedProfileId'],
      parentColumns: ['id'],
      entity: Profile),
])
class RightSwipe {
  @PrimaryKey(autoGenerate: true)
  int? id;
  int? swiperProfileId;
  int? swiperOwnerId;
  String? swipeDate;
  int? swipedProfileId;
  RightSwipe(
      {this.id,
      this.swiperProfileId,
      this.swiperOwnerId,
      this.swipeDate,
      this.swipedProfileId});
}
