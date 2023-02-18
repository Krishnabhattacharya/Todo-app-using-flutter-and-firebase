import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_first/posts/posts.dart';
import 'package:firebase_first/ui/signUp.dart';
import 'package:firebase_first/units/units.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widget/button.dart';
import 'login_with_phone.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({super.key});

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool log = false;

  void login() async {
    setState(() {
      log = true;
    });
    _auth
        .signInWithEmailAndPassword(email: c1.text, password: c2.text)
        .then((value) {
      unit().toastmessage(value.user!.toString());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => post_screen()));
      setState(() {
        log = false;
      });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      unit().toastmessage(error.toString());
      setState(() {
        log = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('Login'),
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
              onTap: () {
                if (_formkey.currentState!.validate()) {
                  login();
                }
              },
              loading: log,
              title: "Login",
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dont have an Account?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => signup()));
                    },
                    child: Text("Sign Up",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 184, 179, 22),
                        ))),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            // InkWell(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => login_with_phone()));
            //   },
            //   child: Container(
            //     height: 30,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(15),
            //         border: Border.all(
            //           color: Color.fromARGB(255, 184, 179, 22),
            //         )),
            //     child: Center(child: Text('Login with Phone')),
            //   ),
            // )
          ]),
        ),
      ),
    );
  }
}
