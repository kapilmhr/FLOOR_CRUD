import 'package:floor/floor.dart';

@entity
class Person{
  @PrimaryKey(autoGenerate: true)
  final int? id;
  String name;
  int age;

  Person({this.id, required this.name, required this.age});
}