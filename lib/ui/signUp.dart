import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_first/ui/loginScreen.dart';
import 'package:firebase_first/units/units.dart';
import 'package:flutter/material.dart';

import '../widget/button.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signup();
}

class _signup extends State<signup> {
  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();
  bool loding = false;
  final _formkey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Signup'),
        backgroundColor: Color.fromARGB(255, 184, 179, 22),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: "Email", prefixIcon: Icon(Icons.email)),
                    controller: c1,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Email";
                      } else
                        return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Password", prefixIcon: Icon(Icons.lock)),
                    controller: c2,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Password";
                      } else
                        return null;
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              )),
          Button(
            loading: loding,
            onTap: () {
              if (_formkey.currentState!.validate()) {
                setState(() {
                  loding = true;
                });
                _auth
                    .createUserWithEmailAndPassword(
                        email: c1.text, password: c2.text)
                    .then((value) {
                  setState(() {
                    loding = false;
                  });
                }).onError((error, stackTrace) {
                  unit().toastmessage(error.toString());
                  setState(() {
                    loding = false;
                  });
                });
              }
            },
            title: "sign up",
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Already have an Account?"),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => loginscreen()));
                  },
                  child: Text("Log in",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 184, 179, 22),
                      ))),
            ],
          )
        ]),
      ),
    );
  }
}
