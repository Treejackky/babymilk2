// ignore_for_file: prefer_const_constructors

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
      'บันทึก\nการเติบโต',
      'ปฏิทิน\nการให้นม',
      'กราฟการ\nเติบโตของลูก',
      'คำนวนสูตร\nชงนมลูก'
    ];
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
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
              //    color: Colors.blue,
              alignment: Alignment.center,
              width: width,
              height: height * 0.7,
              child: GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(0),
                itemCount: 5,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
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
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        list[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: height * 0.03,
                          color: Colors.white,
                        ),
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
