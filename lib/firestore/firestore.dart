import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../posts/add_post.dart';
import '../ui/loginScreen.dart';
import '../units/units.dart';
import 'add_firestoredata.dart';

class fireStroreScreen extends StatefulWidget {
  const fireStroreScreen({super.key});

  @override
  State<fireStroreScreen> createState() => _fireStroreScreenState();
}

class _fireStroreScreenState extends State<fireStroreScreen> {
  final _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance.collection('user').snapshots();
  TextEditingController t2 = TextEditingController();
  TextEditingController t5 = TextEditingController();

  // final ref = FirebaseDatabase.instance.ref('post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 184, 179, 22),
        title: Text('TODOs'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                _auth.signOut().then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => loginscreen()));
                }).onError((error, stackTrace) {
                  unit().toastmessage(error.toString());
                });
              },
              icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: t2,
            onChanged: (value) {
              setState(() {});
            },
            decoration: InputDecoration(
              hintText: "Search",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // Expanded(
          //     child: StreamBuilder(
          //         stream: ref.onValue,
          //         builder: ((context, AsyncSnapshot<DatabaseEvent> snapshot) {
          //           Map<dynamic, dynamic> m =
          //               snapshot.data!.snapshot.value as dynamic;
          //           List<dynamic> l = [];
          //           l.clear();
          //           l = m.values.toList();
          //           return ListView.builder(
          //             itemCount: snapshot.data!.snapshot.children.length,
          //             itemBuilder: (context, index) {
          //               return ListTile(
          //                 title: Text(l[index]['title']),
          //                 subtitle: Text(l[index]['id']),
          //               );
          //             },
          //           );
          //         }))),
          StreamBuilder<QuerySnapshot>(
              stream: firestore,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) return Text('Somthing went wrong');

                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) {
                        return ListTile(
                          title: Text(
                              snapshot.data!.docs[index]['title'].toString()),
                          subtitle:
                              Text(snapshot.data!.docs[index]['id'].toString()),
                        );
                      })),
                );
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Addfirestore()));
        }),
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 184, 179, 22),
      ),
    );
  }

  Future<void> showdialog(String title, String id) async {
    t5.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update'),
            content: Container(
              child: TextField(
                controller: t5,
                decoration: InputDecoration(
                  hintText: 'Edit',
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Update'),
              ),
            ],
          );
        });
  }
}
