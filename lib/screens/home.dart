import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controllername = TextEditingController();
  final controllerage = TextEditingController();
  final controllerdate = TextEditingController();

  DateTime selecteddate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Fields'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          TextField(
            decoration: decoration('Name'),
            controller: controllername,
          ),
          const SizedBox(height: 25),
          TextField(
            decoration: decoration('Age'),
            controller: controllerage,
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {
              _selectDate(context);
            },
            child: const Text("Choose Date"),
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {
              createUser(
                  name: controllername.text,
                  age: controllerage.text,
                  date: selecteddate);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
                primary: Colors.deepOrangeAccent.shade700),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Create",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future createUser(
      {required String name,
      required String age,
      required DateTime date}) async {
    //Reference to document
    final docuser = FirebaseFirestore.instance.collection('users').doc();
    final json = {
      'name': name,
      'height': age,
      'date': date,
    };
    await docuser.set(json);
  }

  InputDecoration decoration(String label) => InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      );
  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selecteddate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selecteddate) {
      setState(() {
        selecteddate = selected;
      });
    }
  }
}
