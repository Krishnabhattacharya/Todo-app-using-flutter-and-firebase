import 'package:flutter/material.dart';


class varify extends StatefulWidget {
    String verificationId;
   varify({super.key,required this.verificationId});

  @override
  State<varify> createState() => _varifyState();
}


class _varifyState extends State<varify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Varify')),
      body: Column(children: []),
    );
  }
}
