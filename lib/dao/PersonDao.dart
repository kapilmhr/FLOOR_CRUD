import 'package:floor/floor.dart';
import 'package:flutter_floor/model/Person.dart';

@dao
abstract class PersonDao{
  @Query('SELECT * FROM person')
  Future<List<Person>> getAllPerson();

  @Query('SELECT * FROM person WHERE age%2 =0')
  Future<List<Person>> getAllPersonByAge();

  @insert
  Future<void> insertPerson(Person person);

  @update
  Future<void> updatePerson(Person person);

  @delete
  Future<void> deletePerson(Person person);
}