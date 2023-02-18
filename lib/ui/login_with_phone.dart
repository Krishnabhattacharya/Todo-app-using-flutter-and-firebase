import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_first/ui/varified_code.dart';
import 'package:firebase_first/units/units.dart';
import 'package:firebase_first/widget/button.dart';
import 'package:flutter/material.dart';


class login_with_phone extends StatefulWidget {
  const login_with_phone({super.key});

  @override
  State<login_with_phone> createState() => _login_with_phoneState();
}

class _login_with_phoneState extends State<login_with_phone> {
  TextEditingController t = TextEditingController();
  bool load = false;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Color.fromARGB(255, 43, 120, 89),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(children: [
          SizedBox(
            height: 50,
          ),
          TextFormField(
            controller: t,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(hintText: "91+"),
          ),
          SizedBox(
            height: 50,
          ),
          Button(
              title: "Login",
              onTap: () {
                _auth.verifyPhoneNumber(
                  phoneNumber: t.text,
                    verificationCompleted: (_) {},
                    verificationFailed: (e) {
                      unit().toastmessage(e.toString());
                    },
                    codeSent: (String verification, int? token) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => varify(verificationId: verification,)));
                    },
                    codeAutoRetrievalTimeout: (e) {
                      unit().toastmessage(e.toString());
                    });
              }),
        ]),
      ),
    );
  }
}
