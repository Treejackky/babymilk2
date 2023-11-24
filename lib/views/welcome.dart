// ignore_for_file: prefer_const_constructors

import 'package:babymilk2/widget/custombutton.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: width * 0.5,
            height: height * 0.21,
            child: Image.asset(
              'assets/images/babymilk.png',
              //boder radius
            ),
          ),
          Container(
              width: width * 0.9,
              child: CustomButton(
                text: 'Start',
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
              )),
        ],
      )),
    );
  }
}
