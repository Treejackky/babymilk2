// ignore_for_file: prefer_const_constructors

import 'package:babymilk2/widget/custombutton.dart';
import 'package:babymilk2/widget/img.dart';
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
      backgroundColor: Color(0xFF9FDBF7),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              alignment: Alignment.topLeft,
              width: width * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ยินดีต้อนรับ',
                    style: TextStyle(
                      fontSize: height * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Baby Milk',
                      style: TextStyle(
                        fontSize: height * 0.02,
                      )),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.amber[200],
                borderRadius: BorderRadius.circular(200),
              ),
              width: width * 4,
              height: height * 0.4,
              child: Stack(
                children: [
                  Positioned(
                      child: Column(
                    children: [
                      Img('bottle'),
                    ],
                  )),
                ],
              ),
            ),
            Text(
              'แอพลิเคชั่นสำหรับการบันทึกข้อมูล\nการให้นมลูกน้อย',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: height * 0.023),
            ),
            Container(
              width: width * 0.9,
              height: height * 0.08,
              child: CustomButton(
                color: Colors.blueAccent, // กำหนดสีพื้นหลังของปุ่ม
                text: 'เริ่มต้นใช้งาน',
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
