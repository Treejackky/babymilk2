import 'package:babymilk2/data/data.dart';
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.07,
                child: DropdownButton<String>(
                  value: selectedValue,
                  hint: Text('เลือกช่วงอายุ',
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
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                          )),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue;
                    });
                  },
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text('น้ำหนักลูก',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                    )),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  ),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    Calculate(double.parse(value));
                  });
                },
              ),
              Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('ผลลัพธ์',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                          )),
                      Text(data['result'] != null ? data['result'] : '',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                          )),
                      Text('ออนซ์/วัน ',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                          ))
                    ],
                  )),
              //ปุ่ม
            ],
          ),
        ),
      ),
    );
  }
}
