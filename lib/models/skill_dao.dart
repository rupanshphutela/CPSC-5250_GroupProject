import 'package:floor/floor.dart';
import './skill.dart';

@dao
abstract class SkillDao {
  @Query("SELECT * FROM skill WHERE id = :profileId")
  Future<Skill> getSkillByProfileId(String profileId);

  @insert
  Future<void> insertSkill(Skill skill);

  @update
  Future<void> updateSkill(Skill skill);

  @delete
  Future<void> deleteSkill(Skill skill);
}
