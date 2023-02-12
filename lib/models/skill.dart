import 'package:floor/floor.dart';

import 'profile.dart';

@Entity(tableName: 'skill', foreignKeys: [
  ForeignKey(
      childColumns: ['profileId'], parentColumns: ['id'], entity: Profile)
])
class Skill {
  @primaryKey
  int? profileId;
  String? skillName;
  String? proficiency;
  String? duration;
  Skill({
    this.profileId,
    this.skillName,
    this.proficiency,
    this.duration,
  });
}
