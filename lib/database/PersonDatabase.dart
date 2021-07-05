import 'dart:async';

import 'package:floor/floor.dart';
import 'package:flutter_floor/dao/PersonDao.dart';
import 'package:flutter_floor/model/Person.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';
part 'PersonDatabase.g.dart';

@Database(version: 1, entities: [Person])
abstract class PersonDatabase extends FloorDatabase{
  PersonDao get personDao;
}