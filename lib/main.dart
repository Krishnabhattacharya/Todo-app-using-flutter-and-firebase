import 'package:firebase_first/ui/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
     theme: ThemeData(
       // primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
    home: const MyApp(),
    ));
}
