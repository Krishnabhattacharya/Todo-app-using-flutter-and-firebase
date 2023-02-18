import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_first/posts/add_post.dart';
import 'package:firebase_first/ui/loginScreen.dart';
import 'package:firebase_first/units/units.dart';
import 'package:flutter/material.dart';

class post_screen extends StatefulWidget {
  const post_screen({super.key});

  @override
  State<post_screen> createState() => _post_screenState();
}

class _post_screenState extends State<post_screen> {
  final _auth = FirebaseAuth.instance;
  TextEditingController t2 = TextEditingController();
  TextEditingController t5 = TextEditingController();

  final ref = FirebaseDatabase.instance.ref('post');
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
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                defaultChild: Text('Loading'),
                itemBuilder: ((context, snapshot, animation, index) {
                  final tit = snapshot.child('title').value.toString();
                  if (t2.text.isEmpty) {
                    return Card(
                        elevation: 4,
                        child: ListTile(
                            title: Text(
                              snapshot.child('title').value.toString(),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 255, 231, 15)),
                            ),
                            subtitle: Text(snapshot
                                .child(
                                  'id',
                                )
                                .value
                                .toString()),
                            trailing: PopupMenuButton(
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                    value: 1,
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.pop(context);
                                        showdialog(
                                            tit,
                                            snapshot
                                                .child('id')
                                                .value
                                                .toString());
                                      },
                                      leading: Icon(Icons.edit),
                                      title: Text('Edit'),
                                    )),
                                PopupMenuItem(
                                    value: 1,
                                    child: ListTile(
                                      onTap: (() {
                                        Navigator.pop(context);
                                        ref
                                            .child(snapshot
                                                .child('id')
                                                .value
                                                .toString())
                                            .remove();
                                      }),
                                      leading: Icon(Icons.edit),
                                      title: Text('Delete'),
                                    ))
                              ],
                              icon: Icon(Icons.more_vert),
                            )));
                    // } else if (tit
                    //     .toLowerCase()
                    //     .contains(t2.text.toLowerCase().toLowerCase())) {
                    //   return Card(
                    //     elevation: 4,
                    //     child: ListTile(
                    //       title: Text(snapshot.child('title').value.toString()),
                    //       subtitle: Text(snapshot.child('id').value.toString()),
                    //     ),
                    //   );
                  } else {
                    return Container();
                  }
                })),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => add_post()));
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
                onPressed: () {
                  Navigator.pop(context);
                  ref
                      .child(id)
                      .update({'title': t5.text.toLowerCase()}).then((value) {
                    unit().toastmessage("post aded");
                  }).onError((error, stackTrace) {
                    unit().toastmessage(error.toString());
                  });
                },
                child: Text('Update'),
              ),
            ],
          );
        });
  }
}
