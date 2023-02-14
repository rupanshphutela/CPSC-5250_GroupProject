// GENERATED CODE - DO NOT MODIFY BY HAND

part of the_dig_app.models;

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ProfileDao? _profileDaoInstance;

  OwnerDao? _ownerProfileDaoInstance;

  PictureDao? _pictureDaoInstance;

  SkillDao? _skillDaoInstance;

  FoodPreferenceDao? _foodPreferenceDaoInstance;

  RightSwipeDao? _rightSwipeDaoInstance;

  LeftSwipeDao? _leftSwipeDaoInstance;

  TopSwipeDao? _topSwipeDaoInstance;

  BehaviorDao? _behaviorDaoInstance;

  FavoriteActivityDao? _favoriteActivityDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `profile` (`id` INTEGER NOT NULL, `fName` TEXT NOT NULL, `lName` TEXT NOT NULL, `profilePicture` TEXT NOT NULL, `ownerId` INTEGER NOT NULL, `biography` TEXT, `gender` TEXT NOT NULL, `breed` TEXT NOT NULL, `color` TEXT NOT NULL, `isVaccinated` INTEGER NOT NULL, `registrationDate` TEXT NOT NULL, `isSpayed` INTEGER NOT NULL, `isNeutered` INTEGER NOT NULL, `joiningDate` TEXT NOT NULL, `size` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `owner_profile` (`id` INTEGER NOT NULL, `fName` TEXT NOT NULL, `lName` TEXT NOT NULL, `phone` TEXT NOT NULL, `email` TEXT NOT NULL, `addressText` TEXT, `addressCoordindates` TEXT, `picture` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `picture` (`profileId` INTEGER, `ownerId` INTEGER, `picturePath` TEXT, FOREIGN KEY (`profileId`) REFERENCES `profile` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`profileId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `skill` (`profileId` INTEGER, `skillName` TEXT, `proficiency` TEXT, `duration` TEXT, FOREIGN KEY (`profileId`) REFERENCES `profile` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`profileId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `food_preference` (`profileId` INTEGER, `foodName` TEXT, `likingIndex` INTEGER, FOREIGN KEY (`profileId`) REFERENCES `profile` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`profileId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `right_swipe` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `swiperProfileId` INTEGER, `swiperOwnerId` INTEGER, `swipeDate` TEXT, `swipedProfileId` INTEGER, FOREIGN KEY (`swipedProfileId`) REFERENCES `profile` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `left_swipe` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `swiperProfileId` INTEGER, `swiperOwnerId` INTEGER, `swipeDate` TEXT, `swipedProfileId` INTEGER, FOREIGN KEY (`swipedProfileId`) REFERENCES `profile` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `top_swipe` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `swiperProfileId` INTEGER, `swiperOwnerId` INTEGER, `swipeDate` TEXT, `swipedProfileId` INTEGER, FOREIGN KEY (`swipedProfileId`) REFERENCES `profile` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `behavior` (`profileId` INTEGER, `socialIndexHumans` INTEGER, `socialIndexDogs` INTEGER, `isFoodAggressive` INTEGER, `isNewHumanAggressive` INTEGER, `isNewDogAggressive` INTEGER, FOREIGN KEY (`profileId`) REFERENCES `profile` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`profileId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `favorite_activity` (`profileId` INTEGER, `activityName` TEXT, `likingIndex` INTEGER, FOREIGN KEY (`profileId`) REFERENCES `profile` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`profileId`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ProfileDao get profileDao {
    return _profileDaoInstance ??= _$ProfileDao(database, changeListener);
  }

  @override
  OwnerDao get ownerProfileDao {
    return _ownerProfileDaoInstance ??= _$OwnerDao(database, changeListener);
  }

  @override
  PictureDao get pictureDao {
    return _pictureDaoInstance ??= _$PictureDao(database, changeListener);
  }

  @override
  SkillDao get skillDao {
    return _skillDaoInstance ??= _$SkillDao(database, changeListener);
  }

  @override
  FoodPreferenceDao get foodPreferenceDao {
    return _foodPreferenceDaoInstance ??=
        _$FoodPreferenceDao(database, changeListener);
  }

  @override
  RightSwipeDao get rightSwipeDao {
    return _rightSwipeDaoInstance ??= _$RightSwipeDao(database, changeListener);
  }

  @override
  LeftSwipeDao get leftSwipeDao {
    return _leftSwipeDaoInstance ??= _$LeftSwipeDao(database, changeListener);
  }

  @override
  TopSwipeDao get topSwipeDao {
    return _topSwipeDaoInstance ??= _$TopSwipeDao(database, changeListener);
  }

  @override
  BehaviorDao get behaviorDao {
    return _behaviorDaoInstance ??= _$BehaviorDao(database, changeListener);
  }

  @override
  FavoriteActivityDao get favoriteActivityDao {
    return _favoriteActivityDaoInstance ??=
        _$FavoriteActivityDao(database, changeListener);
  }
}

class _$ProfileDao extends ProfileDao {
  _$ProfileDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _profileInsertionAdapter = InsertionAdapter(
            database,
            'profile',
            (Profile item) => <String, Object?>{
                  'id': item.id,
                  'fName': item.fName,
                  'lName': item.lName,
                  'profilePicture': item.profilePicture,
                  'ownerId': item.ownerId,
                  'biography': item.biography,
                  'gender': item.gender,
                  'breed': item.breed,
                  'color': item.color,
                  'isVaccinated': item.isVaccinated ? 1 : 0,
                  'registrationDate': item.registrationDate,
                  'isSpayed': item.isSpayed ? 1 : 0,
                  'isNeutered': item.isNeutered ? 1 : 0,
                  'joiningDate': item.joiningDate,
                  'size': item.size
                }),
        _profileUpdateAdapter = UpdateAdapter(
            database,
            'profile',
            ['id'],
            (Profile item) => <String, Object?>{
                  'id': item.id,
                  'fName': item.fName,
                  'lName': item.lName,
                  'profilePicture': item.profilePicture,
                  'ownerId': item.ownerId,
                  'biography': item.biography,
                  'gender': item.gender,
                  'breed': item.breed,
                  'color': item.color,
                  'isVaccinated': item.isVaccinated ? 1 : 0,
                  'registrationDate': item.registrationDate,
                  'isSpayed': item.isSpayed ? 1 : 0,
                  'isNeutered': item.isNeutered ? 1 : 0,
                  'joiningDate': item.joiningDate,
                  'size': item.size
                }),
        _profileDeletionAdapter = DeletionAdapter(
            database,
            'profile',
            ['id'],
            (Profile item) => <String, Object?>{
                  'id': item.id,
                  'fName': item.fName,
                  'lName': item.lName,
                  'profilePicture': item.profilePicture,
                  'ownerId': item.ownerId,
                  'biography': item.biography,
                  'gender': item.gender,
                  'breed': item.breed,
                  'color': item.color,
                  'isVaccinated': item.isVaccinated ? 1 : 0,
                  'registrationDate': item.registrationDate,
                  'isSpayed': item.isSpayed ? 1 : 0,
                  'isNeutered': item.isNeutered ? 1 : 0,
                  'joiningDate': item.joiningDate,
                  'size': item.size
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Profile> _profileInsertionAdapter;

  final UpdateAdapter<Profile> _profileUpdateAdapter;

  final DeletionAdapter<Profile> _profileDeletionAdapter;

  @override
  Future<Profile?> getProfileByProfileId(String profileId) async {
    return _queryAdapter.query('SELECT * FROM profile WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Profile(
            id: row['id'] as int,
            fName: row['fName'] as String,
            lName: row['lName'] as String,
            profilePicture: row['profilePicture'] as String,
            ownerId: row['ownerId'] as int,
            biography: row['biography'] as String?,
            gender: row['gender'] as String,
            breed: row['breed'] as String,
            color: row['color'] as String,
            isVaccinated: (row['isVaccinated'] as int) != 0,
            registrationDate: row['registrationDate'] as String,
            isSpayed: (row['isSpayed'] as int) != 0,
            isNeutered: (row['isNeutered'] as int) != 0,
            joiningDate: row['joiningDate'] as String,
            size: row['size'] as String),
        arguments: [profileId]);
  }

  @override
  Future<List<Profile>> getAllProfiles() async {
    return _queryAdapter.queryList(
        'SELECT * FROM profile where id not in (select swipedProfileId from right_swipe union select swipedProfileId from left_swipe union select swipedProfileId from top_swipe)',
        mapper: (Map<String, Object?> row) => Profile(
            id: row['id'] as int,
            fName: row['fName'] as String,
            lName: row['lName'] as String,
            profilePicture: row['profilePicture'] as String,
            ownerId: row['ownerId'] as int,
            biography: row['biography'] as String?,
            gender: row['gender'] as String,
            breed: row['breed'] as String,
            color: row['color'] as String,
            isVaccinated: (row['isVaccinated'] as int) != 0,
            registrationDate: row['registrationDate'] as String,
            isSpayed: (row['isSpayed'] as int) != 0,
            isNeutered: (row['isNeutered'] as int) != 0,
            joiningDate: row['joiningDate'] as String,
            size: row['size'] as String));
  }

  @override
  Future<void> insertProfile(Profile profile) async {
    await _profileInsertionAdapter.insert(profile, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateProfile(Profile profile) async {
    await _profileUpdateAdapter.update(profile, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteProfile(Profile profile) async {
    await _profileDeletionAdapter.delete(profile);
  }
}

class _$OwnerDao extends OwnerDao {
  _$OwnerDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _ownerInsertionAdapter = InsertionAdapter(
            database,
            'owner_profile',
            (Owner item) => <String, Object?>{
                  'id': item.id,
                  'fName': item.fName,
                  'lName': item.lName,
                  'phone': item.phone,
                  'email': item.email,
                  'addressText': item.addressText,
                  'addressCoordindates': item.addressCoordindates,
                  'picture': item.picture
                }),
        _ownerUpdateAdapter = UpdateAdapter(
            database,
            'owner_profile',
            ['id'],
            (Owner item) => <String, Object?>{
                  'id': item.id,
                  'fName': item.fName,
                  'lName': item.lName,
                  'phone': item.phone,
                  'email': item.email,
                  'addressText': item.addressText,
                  'addressCoordindates': item.addressCoordindates,
                  'picture': item.picture
                }),
        _ownerDeletionAdapter = DeletionAdapter(
            database,
            'owner_profile',
            ['id'],
            (Owner item) => <String, Object?>{
                  'id': item.id,
                  'fName': item.fName,
                  'lName': item.lName,
                  'phone': item.phone,
                  'email': item.email,
                  'addressText': item.addressText,
                  'addressCoordindates': item.addressCoordindates,
                  'picture': item.picture
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Owner> _ownerInsertionAdapter;

  final UpdateAdapter<Owner> _ownerUpdateAdapter;

  final DeletionAdapter<Owner> _ownerDeletionAdapter;

  @override
  Future<Owner?> getOwnerByOwnerId(String ownerId) async {
    return _queryAdapter.query('SELECT * FROM owner WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Owner(
            id: row['id'] as int,
            fName: row['fName'] as String,
            lName: row['lName'] as String,
            phone: row['phone'] as String,
            email: row['email'] as String,
            addressText: row['addressText'] as String?,
            addressCoordindates: row['addressCoordindates'] as String?,
            picture: row['picture'] as String),
        arguments: [ownerId]);
  }

  @override
  Future<void> insertOwnerProfile(Owner ownerProfile) async {
    await _ownerInsertionAdapter.insert(ownerProfile, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateOwnerProfile(Owner ownerProfile) async {
    await _ownerUpdateAdapter.update(ownerProfile, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteOwnerProfile(Owner ownerProfile) async {
    await _ownerDeletionAdapter.delete(ownerProfile);
  }
}

class _$PictureDao extends PictureDao {
  _$PictureDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _pictureInsertionAdapter = InsertionAdapter(
            database,
            'picture',
            (Picture item) => <String, Object?>{
                  'profileId': item.profileId,
                  'ownerId': item.ownerId,
                  'picturePath': item.picturePath
                }),
        _pictureDeletionAdapter = DeletionAdapter(
            database,
            'picture',
            ['profileId'],
            (Picture item) => <String, Object?>{
                  'profileId': item.profileId,
                  'ownerId': item.ownerId,
                  'picturePath': item.picturePath
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Picture> _pictureInsertionAdapter;

  final DeletionAdapter<Picture> _pictureDeletionAdapter;

  @override
  Future<Picture?> getPicturesByProfileId(String profileId) async {
    return _queryAdapter.query('SELECT * FROM pictures WHERE profileId = ?1',
        mapper: (Map<String, Object?> row) => Picture(
            profileId: row['profileId'] as int?,
            ownerId: row['ownerId'] as int?,
            picturePath: row['picturePath'] as String?),
        arguments: [profileId]);
  }

  @override
  Future<void> insertPicture(Picture picture) async {
    await _pictureInsertionAdapter.insert(picture, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePicture(Picture picture) async {
    await _pictureDeletionAdapter.delete(picture);
  }
}

class _$SkillDao extends SkillDao {
  _$SkillDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _skillInsertionAdapter = InsertionAdapter(
            database,
            'skill',
            (Skill item) => <String, Object?>{
                  'profileId': item.profileId,
                  'skillName': item.skillName,
                  'proficiency': item.proficiency,
                  'duration': item.duration
                }),
        _skillUpdateAdapter = UpdateAdapter(
            database,
            'skill',
            ['profileId'],
            (Skill item) => <String, Object?>{
                  'profileId': item.profileId,
                  'skillName': item.skillName,
                  'proficiency': item.proficiency,
                  'duration': item.duration
                }),
        _skillDeletionAdapter = DeletionAdapter(
            database,
            'skill',
            ['profileId'],
            (Skill item) => <String, Object?>{
                  'profileId': item.profileId,
                  'skillName': item.skillName,
                  'proficiency': item.proficiency,
                  'duration': item.duration
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Skill> _skillInsertionAdapter;

  final UpdateAdapter<Skill> _skillUpdateAdapter;

  final DeletionAdapter<Skill> _skillDeletionAdapter;

  @override
  Future<Skill?> getSkillsByProfileId(String profileId) async {
    return _queryAdapter.query('SELECT * FROM skill WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Skill(
            profileId: row['profileId'] as int?,
            skillName: row['skillName'] as String?,
            proficiency: row['proficiency'] as String?,
            duration: row['duration'] as String?),
        arguments: [profileId]);
  }

  @override
  Future<void> insertSkill(Skill skill) async {
    await _skillInsertionAdapter.insert(skill, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateSkill(Skill skill) async {
    await _skillUpdateAdapter.update(skill, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteSkill(Skill skill) async {
    await _skillDeletionAdapter.delete(skill);
  }
}

class _$FoodPreferenceDao extends FoodPreferenceDao {
  _$FoodPreferenceDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _foodPreferenceInsertionAdapter = InsertionAdapter(
            database,
            'food_preference',
            (FoodPreference item) => <String, Object?>{
                  'profileId': item.profileId,
                  'foodName': item.foodName,
                  'likingIndex': item.likingIndex
                }),
        _foodPreferenceDeletionAdapter = DeletionAdapter(
            database,
            'food_preference',
            ['profileId'],
            (FoodPreference item) => <String, Object?>{
                  'profileId': item.profileId,
                  'foodName': item.foodName,
                  'likingIndex': item.likingIndex
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FoodPreference> _foodPreferenceInsertionAdapter;

  final DeletionAdapter<FoodPreference> _foodPreferenceDeletionAdapter;

  @override
  Future<FoodPreference?> getFoodPreferencesByProfileId(
      String profileId) async {
    return _queryAdapter.query(
        'SELECT * FROM food_preference WHERE profileId = ?1',
        mapper: (Map<String, Object?> row) => FoodPreference(
            profileId: row['profileId'] as int?,
            foodName: row['foodName'] as String?,
            likingIndex: row['likingIndex'] as int?),
        arguments: [profileId]);
  }

  @override
  Future<void> insertFoodPreference(FoodPreference foodPreference) async {
    await _foodPreferenceInsertionAdapter.insert(
        foodPreference, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteFoodPreference(FoodPreference foodPreference) async {
    await _foodPreferenceDeletionAdapter.delete(foodPreference);
  }
}

class _$RightSwipeDao extends RightSwipeDao {
  _$RightSwipeDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _rightSwipeInsertionAdapter = InsertionAdapter(
            database,
            'right_swipe',
            (RightSwipe item) => <String, Object?>{
                  'id': item.id,
                  'swiperProfileId': item.swiperProfileId,
                  'swiperOwnerId': item.swiperOwnerId,
                  'swipeDate': item.swipeDate,
                  'swipedProfileId': item.swipedProfileId
                }),
        _rightSwipeDeletionAdapter = DeletionAdapter(
            database,
            'right_swipe',
            ['id'],
            (RightSwipe item) => <String, Object?>{
                  'id': item.id,
                  'swiperProfileId': item.swiperProfileId,
                  'swiperOwnerId': item.swiperOwnerId,
                  'swipeDate': item.swipeDate,
                  'swipedProfileId': item.swipedProfileId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<RightSwipe> _rightSwipeInsertionAdapter;

  final DeletionAdapter<RightSwipe> _rightSwipeDeletionAdapter;

  @override
  Future<List<RightSwipe>> getRightSwipesBySwiperProfileId(
      String profileId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM right_swipe WHERE swiperProfileId = ?1',
        mapper: (Map<String, Object?> row) => RightSwipe(
            id: row['id'] as int?,
            swiperProfileId: row['swiperProfileId'] as int?,
            swiperOwnerId: row['swiperOwnerId'] as int?,
            swipeDate: row['swipeDate'] as String?,
            swipedProfileId: row['swipedProfileId'] as int?),
        arguments: [profileId]);
  }

  @override
  Future<List<RightSwipe>> getRightSwipesBySwipedProfileId(
      String profileId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM right_swipe WHERE swipedProfileId = ?1',
        mapper: (Map<String, Object?> row) => RightSwipe(
            id: row['id'] as int?,
            swiperProfileId: row['swiperProfileId'] as int?,
            swiperOwnerId: row['swiperOwnerId'] as int?,
            swipeDate: row['swipeDate'] as String?,
            swipedProfileId: row['swipedProfileId'] as int?),
        arguments: [profileId]);
  }

  @override
  Future<List<RightSwipe>> getAllLikedProfiles() async {
    return _queryAdapter.queryList('SELECT * FROM right_swipe',
        mapper: (Map<String, Object?> row) => RightSwipe(
            id: row['id'] as int?,
            swiperProfileId: row['swiperProfileId'] as int?,
            swiperOwnerId: row['swiperOwnerId'] as int?,
            swipeDate: row['swipeDate'] as String?,
            swipedProfileId: row['swipedProfileId'] as int?));
  }

  @override
  Future<void> insertRightSwipe(RightSwipe rightSwipe) async {
    await _rightSwipeInsertionAdapter.insert(
        rightSwipe, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteRightSwipe(RightSwipe rightSwipe) async {
    await _rightSwipeDeletionAdapter.delete(rightSwipe);
  }
}

class _$LeftSwipeDao extends LeftSwipeDao {
  _$LeftSwipeDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _leftSwipeInsertionAdapter = InsertionAdapter(
            database,
            'left_swipe',
            (LeftSwipe item) => <String, Object?>{
                  'id': item.id,
                  'swiperProfileId': item.swiperProfileId,
                  'swiperOwnerId': item.swiperOwnerId,
                  'swipeDate': item.swipeDate,
                  'swipedProfileId': item.swipedProfileId
                }),
        _leftSwipeDeletionAdapter = DeletionAdapter(
            database,
            'left_swipe',
            ['id'],
            (LeftSwipe item) => <String, Object?>{
                  'id': item.id,
                  'swiperProfileId': item.swiperProfileId,
                  'swiperOwnerId': item.swiperOwnerId,
                  'swipeDate': item.swipeDate,
                  'swipedProfileId': item.swipedProfileId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<LeftSwipe> _leftSwipeInsertionAdapter;

  final DeletionAdapter<LeftSwipe> _leftSwipeDeletionAdapter;

  @override
  Future<List<LeftSwipe>> getLeftSwipesBySwiperProfileId(
      String profileId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM left_swipe WHERE swiperProfileId = ?1',
        mapper: (Map<String, Object?> row) => LeftSwipe(
            id: row['id'] as int?,
            swiperProfileId: row['swiperProfileId'] as int?,
            swiperOwnerId: row['swiperOwnerId'] as int?,
            swipeDate: row['swipeDate'] as String?,
            swipedProfileId: row['swipedProfileId'] as int?),
        arguments: [profileId]);
  }

  @override
  Future<List<LeftSwipe>> getLeftSwipesBySwipedProfileId(
      String profileId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM left_swipe WHERE swipedProfileId = ?1',
        mapper: (Map<String, Object?> row) => LeftSwipe(
            id: row['id'] as int?,
            swiperProfileId: row['swiperProfileId'] as int?,
            swiperOwnerId: row['swiperOwnerId'] as int?,
            swipeDate: row['swipeDate'] as String?,
            swipedProfileId: row['swipedProfileId'] as int?),
        arguments: [profileId]);
  }

  @override
  Future<List<LeftSwipe>> getAllDisLikedProfiles() async {
    return _queryAdapter.queryList('SELECT * FROM left_swipe',
        mapper: (Map<String, Object?> row) => LeftSwipe(
            id: row['id'] as int?,
            swiperProfileId: row['swiperProfileId'] as int?,
            swiperOwnerId: row['swiperOwnerId'] as int?,
            swipeDate: row['swipeDate'] as String?,
            swipedProfileId: row['swipedProfileId'] as int?));
  }

  @override
  Future<void> insertLeftSwipe(LeftSwipe leftSwipe) async {
    await _leftSwipeInsertionAdapter.insert(
        leftSwipe, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteLeftSwipe(LeftSwipe leftSwipe) async {
    await _leftSwipeDeletionAdapter.delete(leftSwipe);
  }
}

class _$TopSwipeDao extends TopSwipeDao {
  _$TopSwipeDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _topSwipeInsertionAdapter = InsertionAdapter(
            database,
            'top_swipe',
            (TopSwipe item) => <String, Object?>{
                  'id': item.id,
                  'swiperProfileId': item.swiperProfileId,
                  'swiperOwnerId': item.swiperOwnerId,
                  'swipeDate': item.swipeDate,
                  'swipedProfileId': item.swipedProfileId
                }),
        _topSwipeDeletionAdapter = DeletionAdapter(
            database,
            'top_swipe',
            ['id'],
            (TopSwipe item) => <String, Object?>{
                  'id': item.id,
                  'swiperProfileId': item.swiperProfileId,
                  'swiperOwnerId': item.swiperOwnerId,
                  'swipeDate': item.swipeDate,
                  'swipedProfileId': item.swipedProfileId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TopSwipe> _topSwipeInsertionAdapter;

  final DeletionAdapter<TopSwipe> _topSwipeDeletionAdapter;

  @override
  Future<List<TopSwipe>> getTopSwipesBySwiperProfileId(String profileId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM top_swipe WHERE swiperProfileId = ?1',
        mapper: (Map<String, Object?> row) => TopSwipe(
            id: row['id'] as int?,
            swiperProfileId: row['swiperProfileId'] as int?,
            swiperOwnerId: row['swiperOwnerId'] as int?,
            swipeDate: row['swipeDate'] as String?,
            swipedProfileId: row['swipedProfileId'] as int?),
        arguments: [profileId]);
  }

  @override
  Future<List<TopSwipe>> getTopSwipesBySwipedProfileId(String profileId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM top_swipe WHERE swipedProfileId = ?1',
        mapper: (Map<String, Object?> row) => TopSwipe(
            id: row['id'] as int?,
            swiperProfileId: row['swiperProfileId'] as int?,
            swiperOwnerId: row['swiperOwnerId'] as int?,
            swipeDate: row['swipeDate'] as String?,
            swipedProfileId: row['swipedProfileId'] as int?),
        arguments: [profileId]);
  }

  @override
  Future<List<TopSwipe>> getAllSuperlikedProfiles() async {
    return _queryAdapter.queryList('SELECT * FROM top_swipe',
        mapper: (Map<String, Object?> row) => TopSwipe(
            id: row['id'] as int?,
            swiperProfileId: row['swiperProfileId'] as int?,
            swiperOwnerId: row['swiperOwnerId'] as int?,
            swipeDate: row['swipeDate'] as String?,
            swipedProfileId: row['swipedProfileId'] as int?));
  }

  @override
  Future<void> insertTopSwipe(TopSwipe topSwipe) async {
    await _topSwipeInsertionAdapter.insert(topSwipe, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTopSwipe(TopSwipe topSwipe) async {
    await _topSwipeDeletionAdapter.delete(topSwipe);
  }
}

class _$BehaviorDao extends BehaviorDao {
  _$BehaviorDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _behaviorInsertionAdapter = InsertionAdapter(
            database,
            'behavior',
            (Behavior item) => <String, Object?>{
                  'profileId': item.profileId,
                  'socialIndexHumans': item.socialIndexHumans,
                  'socialIndexDogs': item.socialIndexDogs,
                  'isFoodAggressive': item.isFoodAggressive == null
                      ? null
                      : (item.isFoodAggressive! ? 1 : 0),
                  'isNewHumanAggressive': item.isNewHumanAggressive == null
                      ? null
                      : (item.isNewHumanAggressive! ? 1 : 0),
                  'isNewDogAggressive': item.isNewDogAggressive == null
                      ? null
                      : (item.isNewDogAggressive! ? 1 : 0)
                }),
        _behaviorUpdateAdapter = UpdateAdapter(
            database,
            'behavior',
            ['profileId'],
            (Behavior item) => <String, Object?>{
                  'profileId': item.profileId,
                  'socialIndexHumans': item.socialIndexHumans,
                  'socialIndexDogs': item.socialIndexDogs,
                  'isFoodAggressive': item.isFoodAggressive == null
                      ? null
                      : (item.isFoodAggressive! ? 1 : 0),
                  'isNewHumanAggressive': item.isNewHumanAggressive == null
                      ? null
                      : (item.isNewHumanAggressive! ? 1 : 0),
                  'isNewDogAggressive': item.isNewDogAggressive == null
                      ? null
                      : (item.isNewDogAggressive! ? 1 : 0)
                }),
        _behaviorDeletionAdapter = DeletionAdapter(
            database,
            'behavior',
            ['profileId'],
            (Behavior item) => <String, Object?>{
                  'profileId': item.profileId,
                  'socialIndexHumans': item.socialIndexHumans,
                  'socialIndexDogs': item.socialIndexDogs,
                  'isFoodAggressive': item.isFoodAggressive == null
                      ? null
                      : (item.isFoodAggressive! ? 1 : 0),
                  'isNewHumanAggressive': item.isNewHumanAggressive == null
                      ? null
                      : (item.isNewHumanAggressive! ? 1 : 0),
                  'isNewDogAggressive': item.isNewDogAggressive == null
                      ? null
                      : (item.isNewDogAggressive! ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Behavior> _behaviorInsertionAdapter;

  final UpdateAdapter<Behavior> _behaviorUpdateAdapter;

  final DeletionAdapter<Behavior> _behaviorDeletionAdapter;

  @override
  Future<Behavior?> getBehaviorsByProfileId(String profileId) async {
    return _queryAdapter.query('SELECT * FROM behavior WHERE profileId = ?1',
        mapper: (Map<String, Object?> row) => Behavior(
            profileId: row['profileId'] as int?,
            socialIndexHumans: row['socialIndexHumans'] as int?,
            socialIndexDogs: row['socialIndexDogs'] as int?,
            isFoodAggressive: row['isFoodAggressive'] == null
                ? null
                : (row['isFoodAggressive'] as int) != 0,
            isNewHumanAggressive: row['isNewHumanAggressive'] == null
                ? null
                : (row['isNewHumanAggressive'] as int) != 0,
            isNewDogAggressive: row['isNewDogAggressive'] == null
                ? null
                : (row['isNewDogAggressive'] as int) != 0),
        arguments: [profileId]);
  }

  @override
  Future<void> insertBehavior(Behavior behavior) async {
    await _behaviorInsertionAdapter.insert(behavior, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateBehavior(Behavior behavior) async {
    await _behaviorUpdateAdapter.update(behavior, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteBehavior(Behavior behavior) async {
    await _behaviorDeletionAdapter.delete(behavior);
  }
}

class _$FavoriteActivityDao extends FavoriteActivityDao {
  _$FavoriteActivityDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _favoriteActivityInsertionAdapter = InsertionAdapter(
            database,
            'favorite_activity',
            (FavoriteActivity item) => <String, Object?>{
                  'profileId': item.profileId,
                  'activityName': item.activityName,
                  'likingIndex': item.likingIndex
                }),
        _favoriteActivityDeletionAdapter = DeletionAdapter(
            database,
            'favorite_activity',
            ['profileId'],
            (FavoriteActivity item) => <String, Object?>{
                  'profileId': item.profileId,
                  'activityName': item.activityName,
                  'likingIndex': item.likingIndex
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FavoriteActivity> _favoriteActivityInsertionAdapter;

  final DeletionAdapter<FavoriteActivity> _favoriteActivityDeletionAdapter;

  @override
  Future<FavoriteActivity?> getFavoriteActivitiesByProfileId(
      String profileId) async {
    return _queryAdapter.query(
        'SELECT * FROM favorite_activity WHERE profileId = ?1',
        mapper: (Map<String, Object?> row) => FavoriteActivity(
            profileId: row['profileId'] as int?,
            activityName: row['activityName'] as String?,
            likingIndex: row['likingIndex'] as int?),
        arguments: [profileId]);
  }

  @override
  Future<void> insertFavoriteActivity(FavoriteActivity favoriteActivity) async {
    await _favoriteActivityInsertionAdapter.insert(
        favoriteActivity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteFavoriteActivity(FavoriteActivity favoriteActivity) async {
    await _favoriteActivityDeletionAdapter.delete(favoriteActivity);
  }
}
