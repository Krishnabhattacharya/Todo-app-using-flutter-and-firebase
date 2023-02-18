
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_first/units/units.dart';
import 'package:firebase_first/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class add_post extends StatefulWidget {
  const add_post({super.key});

  @override
  State<add_post> createState() => _add_postState();
}

class _add_postState extends State<add_post> {
  final databaseRef = FirebaseDatabase.instance.ref("post");
  bool load = false;
  TextEditingController t1 = TextEditingController();
  // TextEditingController t9 = TextEditingController();
  // List todo = [];
  // String title = "";
  // String des = "";
  // createtodo() async {
  //   DocumentReference documentReference =
  //       await FirebaseFirestore.instance.collection("todos").doc(t1.text);
  //   Map<String, String> map = {
  //     "title": t1.text,
  //     "des": t9.text,
  //   };
  //   documentReference.set(map).then((value) {
  //     unit().toastmessage("post Added");
  //     setState(() {
  //       load = false;
  //     });
  //   }).onError((error, stackTrace) {
  //     unit().toastmessage(error.toString());
  //     setState(() {
  //       load = false;
  //     });
  //   });
  // }

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
                databaseRef.child(tdata).set({
                  'title': t1.text,
                  'id': tdata.toString(),
                }).then((value) {
                  unit().toastmessage("post added");
                  setState(() {
                    load = false;
                  });
                }).onError((error, stackTrace) {
                  unit().toastmessage(error.toString());
                  setState(() {
                    load = false;
                  });
                });
              }),
        )
      ]),
    );
  }

 
}
