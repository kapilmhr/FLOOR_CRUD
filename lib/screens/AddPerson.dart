import 'package:flutter/material.dart';
import 'package:flutter_floor/database/PersonDatabase.dart';
import 'package:flutter_floor/model/Person.dart';


class AddPerson extends StatefulWidget {

  const AddPerson({Key? key}) : super(key: key);

  @override
  _AddPersonState createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All People"),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "All People",
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(
                controller: nameController,
                cursorColor: Colors.black,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        left: 15, bottom: 11, top: 11, right: 15),
                    hintText: "Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                cursorColor: Colors.black,
                keyboardType: TextInputType.number,
                maxLength: 2,
                controller: ageController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        left: 15, bottom: 11, top: 11, right: 15),
                    hintText: "Age"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter age';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addPerson();
                  }
                },
                child: Container(
                  width: 200,
                  height: 50,
                  alignment: Alignment.center,
                  color: Colors.blueAccent,
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void addPerson() async {
    var name = nameController.value.text;
    var age = ageController.value.text;
    print(age);
    Person person = Person(name: name, age: int.parse(age));
    final database =
        await $FloorPersonDatabase.databaseBuilder('app_database.db').build();

    final personDao = database.personDao;

    await personDao.insertPerson(person);
    var p = await personDao.getPersonByName(name);
    Navigator.of(context).pop(p);
  }
}
