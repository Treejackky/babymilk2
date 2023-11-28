// ignore_for_file: prefer_const_constructors

import 'package:babymilk2/widget/img.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    List<String> list = [
      'บันทึก\nข้อมูลลูก',
      'บันทึกการ\nเจริญเติบโต',
      'ปฏิทิน\nสต๊อกน้ำนม',
      'กราฟแสดงการ\nเจริญเติบโต',
      'สูตรคำนวณ\nปริมาณน้ำนม'
    ];
    List<String> list2 = [
      'girl',
      'boy',
      'bottel',
      'babylugh',
      'sleep',
    ];
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(''),
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              width: width,
              height: height * 0.7,
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: 5,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      if (index == 0) {
                        Navigator.pushNamed(context, '/overview');
                      }
                      if (index == 1) {
                        Navigator.pushNamed(context, '/viewbaby');
                      }
                      if (index == 2) {
                        Navigator.pushNamed(context, '/calendar');
                      }
                      if (index == 3) {
                        Navigator.pushNamed(context, '/graph');
                      }
                      if (index == 4) {
                        Navigator.pushNamed(context, '/overview2');
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        //add blur effect here
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                              width: width * 0.3, child: Img(list2[index])),
                          Text(
                            list[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: height * 0.02,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
