import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_first/firestore/firestore.dart';
import 'package:firebase_first/posts/posts.dart';
import 'package:flutter/material.dart';

import '../ui/loginScreen.dart';

class Splash {
  void islogin(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    if(user!=null)
    {
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const post_screen())));
    }
    else{
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const loginscreen())));
    }

  }
}
