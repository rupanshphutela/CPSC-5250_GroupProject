import 'package:floor/floor.dart';
import 'profile.dart';

@Entity(tableName: 'picture', foreignKeys: [
  ForeignKey(
      childColumns: ['profileId'], parentColumns: ['id'], entity: Profile)
])
class Picture {
  int? profileId;
  int? ownerId;
  String? picturePath;
  Picture({this.profileId, this.ownerId, this.picturePath});
}
