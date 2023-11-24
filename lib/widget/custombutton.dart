// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;

  const CustomButton(
      {Key? key, required this.text, required this.onPressed, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: color ?? Colors.blue,
          minimumSize: Size(
            MediaQuery.of(context).size.width * 0.9,
            MediaQuery.of(context).size.height * 0.07,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      child: Container(
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.03,
            color: Colors.white,
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
