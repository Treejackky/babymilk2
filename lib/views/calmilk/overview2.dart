// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:babymilk2/data/data.dart';
import 'package:babymilk2/widget/custombutton.dart';
import 'package:flutter/material.dart';

class Overview2 extends StatefulWidget {
  const Overview2({super.key});

  @override
  State<Overview2> createState() => _Overview2State();
}

class _Overview2State extends State<Overview2> {
  String? selectedValue; // Variable to hold the selected dropdown value

  @override
  Widget build(BuildContext context) {
    void Calculate(double weight) {
      double value = 0.0;
      if (selectedValue == '0-30 วัน') {
        value = (weight * 150) + 30;
      } else if (selectedValue == '1-6 เดือน') {
        value = (weight * 120) + 30;
      } else if (selectedValue == '6-12 เดือน') {
        value = (weight * 110) + 30;
      }
      data['result'] = value.toString();
    }

    return GestureDetector(
      onTap: () {
        //unfocus
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('สูตรคำนวนนมลูก'),
          leading: GestureDetector(
            onTap: () {
              data['result'] = null;
              data['milkonz'] = null;
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.07,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('เลือกช่วงอายุ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                        )),
                    DropdownButton<String>(
                      value: selectedValue,
                      hint: Text('กรุณาเลือกอายุ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                          )),
                      items: <String>[
                        '0-30 วัน',
                        '1-6 เดือน',
                        '6-12 เดือน',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05,
                              )),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValue = newValue;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text('น้ำหนักลูก\n(กิโลกรัม)',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                        )),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          data['milkonz'] = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('ปริมาณนมที่ควรได้รับต่อวัน',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                          )),
                      Text(
                          data['result'] != null
                              ? data['result'] + ' ออนซ์/วัน'
                              : '',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.03,
                          )),
                    ],
                  )),
              //ปุ่ม
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: CustomButton(
                      onPressed: () {
                        if (data['milkonz'] != null &&
                            selectedValue != null &&
                            data['milkonz'] != '' &&
                            selectedValue != '') {
                          Calculate(double.parse(data['milkonz']!));
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('กรุณากรอกข้อมูล'),
                              content: Text('กรุณากรอกข้อมูลให้ครบ'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('ตกลง'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      text: 'คำนวน',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
