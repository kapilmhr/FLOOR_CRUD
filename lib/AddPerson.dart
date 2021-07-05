import 'package:flutter/material.dart';

import 'database/PersonDatabase.dart';
import 'model/Person.dart';

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
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Text("All People"),
            TextFormField(
              controller: nameController,
              cursorColor: Colors.black,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "Name"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              maxLength: 2,
              controller: ageController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "Age"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            MaterialButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  addPerson();
                }
              },
              child: Container(
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
    Navigator.pop(context);
  }
}
