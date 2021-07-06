# flutter_floor

A new Flutter project which uses FLOOR to perform database CRUD Operations

# Getting Started with it

## Setup Dependencies

Add the runtime dependency `floor` as well as the generator `floor_generator` to your `pubspec.yaml`.
The third dependency is `build_runner` which has to be included as a dev dependency just like the generator.

- `floor` holds all the code you are going to use in your application.
- `floor_generator` includes the code for generating the database classes.
- `build_runner` enables a concrete way of generating source code files.

```yaml
dependencies:
  flutter:
    sdk: flutter
  floor: ^1.1.0

dev_dependencies:
  floor_generator: ^1.1.0
  build_runner: ^2.0.0
```

## Create a Model class

```dart
@entity
class Person{
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final int age;

  Person({this.id, required this.name, required this.age});
}
```

## Create a DAO class
- a class that performs all database actions

```dart
@dao
abstract class PersonDao{
  @Query('SELECT * FROM person')
  Future<List<Person>> getAllPerson();

  @Query('SELECT * FROM person WHERE age%2 =0')
  Future<List<Person>> getAllPersonByAge();

 @Query('SELECT * FROM person WHERE name LIKE :name')
  Future<Person?> getPersonByName(String name);

  @insert
  Future<void> insertPerson(Person person);

  @update
  Future<void> updatePerson(Person person);

  @delete
  Future<void> deletePerson(Person person);
}
```

## Create a database class

```dart
@Database(version: 1, entities: [Person])
abstract class PersonDatabase extends FloorDatabase{
  PersonDao get personDao;
}
```

## Autogenrated class
- after following methods, we need to run a builder command which auto generates the necessary class to perform our operations

```
flutter pub run build_runner build
```

other build commands which comes in handy

```
flutter pub run build_runner clean

flutter pub run build_runner build --delete-conflicting-outputs
```