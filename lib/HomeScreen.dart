import 'package:flutter/material.dart';
import 'package:flutter_floor/AddPerson.dart';

import 'database/PersonDatabase.dart';
import 'model/Person.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getAllPeople();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All People"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPerson()),
              );
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [Text("All People")],
        ),
      ),
    );
  }

  void getAllPeople() async{
    final database = await $FloorPersonDatabase.databaseBuilder('app_database.db').build();

    final personDao = database.personDao;

    // List<Person> people= await personDao.getAllPerson();
    List<Person> people= await personDao.getAllPersonByAge();
    people.forEach((element) {
      print(element.name);
      print(element.age);
    });
  }
}
