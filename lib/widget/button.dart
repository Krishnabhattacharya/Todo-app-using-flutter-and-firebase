
import 'package:flutter/material.dart';


class Button extends StatelessWidget {
  final String title;
  bool loading;
  final VoidCallback onTap;
  Button({required this.title, required this.onTap, this.loading = false});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 184, 179, 22),
            borderRadius: BorderRadius.circular(10)),
        child:
            Center(child: loading ? CircularProgressIndicator() : Text(title)),
      ),
    );
  }
}
