import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/screens/home.dart';
import 'package:flutter/material.dart';

class AllUser extends StatefulWidget {
  const AllUser({Key? key}) : super(key: key);

  @override
  State<AllUser> createState() => _AllUserState();
}

class _AllUserState extends State<AllUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'All Users',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          backgroundColor: Colors.deepOrange.shade900,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const Home()));
          },
          backgroundColor: Colors.deepPurple.shade900,
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView(
                children: (snapshot.data!).docs.map((document) {
                  return Center(
                    child: Row(
                      children: [
                        Text("Name: " + document['name'] + "   "),
                        TextButton(
                            onPressed: () {
                              final docuser = FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(document.id);
                              docuser.update({'name': 'Updated data'});
                              
                            },
                            child: const Text('Update')),
                            TextButton(
                            onPressed: () {
                              final docuser = FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(document.id);
                              docuser.delete();
                              
                            },
                            child: const Text('Delete'))
                      ],
                    ),
                  );
                }).toList(),
              );
            }));
  }
}
