import 'package:floor/floor.dart';
import 'owner.dart';

@dao
abstract class OwnerDao {
  @Query("SELECT * FROM owner WHERE id = :ownerId")
  Future<Owner?> getOwnerByOwnerId(String ownerId);

  @insert
  Future<void> insertOwnerProfile(Owner ownerProfile);

  @update
  Future<void> updateOwnerProfile(Owner ownerProfile);

  @delete
  Future<void> deleteOwnerProfile(Owner ownerProfile);
}
