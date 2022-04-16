import 'package:firebase_crud/screens/allusers.dart';
import 'package:firebase_crud/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    home: AllUser(),
    debugShowCheckedModeBanner: false,
  ));
}

