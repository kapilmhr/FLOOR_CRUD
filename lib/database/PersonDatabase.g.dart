// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PersonDatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorPersonDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$PersonDatabaseBuilder databaseBuilder(String name) =>
      _$PersonDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$PersonDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$PersonDatabaseBuilder(null);
}

class _$PersonDatabaseBuilder {
  _$PersonDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$PersonDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$PersonDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<PersonDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$PersonDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$PersonDatabase extends PersonDatabase {
  _$PersonDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PersonDao? _personDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
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
            'CREATE TABLE IF NOT EXISTS `Person` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `age` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PersonDao get personDao {
    return _personDaoInstance ??= _$PersonDao(database, changeListener);
  }
}

class _$PersonDao extends PersonDao {
  _$PersonDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _personInsertionAdapter = InsertionAdapter(
            database,
            'Person',
            (Person item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'age': item.age
                }),
        _personUpdateAdapter = UpdateAdapter(
            database,
            'Person',
            ['id'],
            (Person item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'age': item.age
                }),
        _personDeletionAdapter = DeletionAdapter(
            database,
            'Person',
            ['id'],
            (Person item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'age': item.age
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Person> _personInsertionAdapter;

  final UpdateAdapter<Person> _personUpdateAdapter;

  final DeletionAdapter<Person> _personDeletionAdapter;

  @override
  Future<List<Person>> getAllPerson() async {
    return _queryAdapter.queryList('SELECT * FROM person',
        mapper: (Map<String, Object?> row) => Person(
            id: row['id'] as int?,
            name: row['name'] as String,
            age: row['age'] as int));
  }

  @override
  Future<List<Person>> getAllPersonByAge() async {
    return _queryAdapter.queryList('SELECT * FROM person WHERE age%2 =0',
        mapper: (Map<String, Object?> row) => Person(
            id: row['id'] as int?,
            name: row['name'] as String,
            age: row['age'] as int));
  }

  @override
  Future<void> insertPerson(Person person) async {
    await _personInsertionAdapter.insert(person, OnConflictStrategy.abort);
  }

  @override
  Future<void> updatePerson(Person person) async {
    await _personUpdateAdapter.update(person, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePerson(Person person) async {
    await _personDeletionAdapter.delete(person);
  }
}
