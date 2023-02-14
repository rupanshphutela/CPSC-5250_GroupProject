import 'package:floor/floor.dart';

import 'profile.dart';

@Entity(tableName: 'top_swipe', foreignKeys: [
  ForeignKey(
      childColumns: ['swipedProfileId'],
      parentColumns: ['id'],
      entity: Profile),
])
class TopSwipe {
  @PrimaryKey(autoGenerate: true)
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
