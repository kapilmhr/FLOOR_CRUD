import 'package:flutter/material.dart';
import 'package:flutter_floor/screens/UpdatePersonScreen.dart';

import '../database/PersonDatabase.dart';
import '../model/Person.dart';
import 'AddPerson.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Person> personList = [];
  late PersonDatabase database;

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
            onPressed: () async {
              var p = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPerson()),
              );
              setState(() {
                personList.add(p);
              });
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        child: personList.length > 0
            ? ListView.builder(
                itemBuilder: (context, index) {
                  var person = personList[index];
                  return Card(
                    margin: EdgeInsets.all(10),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                person.name,
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("${person.age}"),
                            ],
                          ),
                          PopupMenuButton(
                              elevation: 20,
                              onSelected: (value) {
                                print(value);
                                if (value == 1) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UpdatePersonScreen(person, (p) {
                                              setState(() {
                                                personList[index] = p;
                                              });
                                            })),
                                  );
                                } else if (value == 2) {
                                  database.personDao.deletePerson(person);
                                  setState(() {
                                    personList.remove(person);
                                  });
                                }
                              },
                              itemBuilder: (context) => [
                                    PopupMenuItem(
                                      child: Text("Update"),
                                      value: 1,
                                    ),
                                    PopupMenuItem(
                                      child: Text("Delete"),
                                      value: 2,
                                    ),
                                  ])
                        ],
                      ),
                    ),
                  );
                },
                itemCount: personList.length,
              )
            : Center(
                child: Text("No any data"),
              ),
      ),
    );
  }

  void getAllPeople() async {
    database =
        await $FloorPersonDatabase.databaseBuilder('app_database.db').build();
    final personDao = database.personDao;

    List<Person> people = await personDao.getAllPerson();
    setState(() {
      personList.addAll(people);
    });
  }
}
