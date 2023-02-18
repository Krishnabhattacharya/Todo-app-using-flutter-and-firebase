import 'package:firebase_first/widget/splashservies.dart';
import 'package:flutter/material.dart';


class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  Splash myApp = Splash();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myApp.islogin(context);
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 184, 179, 22),
        child: Center(
            child: Text(
          'SCREEN',
          style: TextStyle(color: Colors.white, fontSize: 60,fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
