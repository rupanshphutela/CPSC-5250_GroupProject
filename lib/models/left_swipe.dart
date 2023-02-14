import 'package:floor/floor.dart';

import 'profile.dart';

@Entity(tableName: 'left_swipe', foreignKeys: [
  ForeignKey(
      childColumns: ['swipedProfileId'],
      parentColumns: ['id'],
      entity: Profile),
])
class LeftSwipe {
  @PrimaryKey(autoGenerate: true)
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
