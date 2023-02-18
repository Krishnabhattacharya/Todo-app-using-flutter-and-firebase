import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_first/units/units.dart';
import 'package:firebase_first/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Addfirestore extends StatefulWidget {
  const Addfirestore({super.key});

  @override
  State<Addfirestore> createState() => _Addfirestore();
}

class _Addfirestore extends State<Addfirestore> {
  // final databaseRef = FirebaseDatabase.instance.ref("post");
  bool load = false;
  TextEditingController t1 = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection('user');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADD TODOs'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 184, 179, 22),
      ),
      body: Column(children: [
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            height: 30,
            child: Container(
              height: 20,
              child: TextFormField(
                  controller: t1,
                  decoration: InputDecoration(
                    hintText: "Task",
                  )),
            ),
          ),
        ),
        // SizedBox(
        //   height: 30,
        // ),
        // Padding(
        //   padding: const EdgeInsets.all(18.0),
        //   child: SizedBox(
        //     height: 30,
        //     child: TextFormField(
        //         controller: t9,
        //         // ignore: prefer_const_constructors
        //         decoration: InputDecoration(
        //           hintText: "Description",
        //         )),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Button(
              title: "ADD",
              loading: load,
              onTap: () {
                setState(() {
                  load = true;
                });
                //createtodo();
                String tdata = DateFormat("hh:mm:ss a").format(DateTime.now());
                firestore.doc(tdata).set({
                  'title': t1.text,
                  'id': tdata,
                }).then((value) {
                  setState(() {
                    load = false;
                  });
                  unit().toastmessage("done");
                }).onError((error, stackTrace) {
                  setState(() {
                    load = false;
                  });
                  unit().toastmessage(error.toString());
                });
              }),
        )
      ]),
    );
  }
}
