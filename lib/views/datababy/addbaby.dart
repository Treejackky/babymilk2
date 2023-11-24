import 'package:babymilk2/data/data.dart';
import 'package:babymilk2/database/database.dart';
import 'package:babymilk2/model/baby.dart';
import 'package:babymilk2/widget/custombutton.dart';
import 'package:babymilk2/widget/customdropdown.dart';
import 'package:flutter/material.dart';

class AddBaby extends StatefulWidget {
  const AddBaby({super.key});

  @override
  State<AddBaby> createState() => _AddBabyState();
}

class _AddBabyState extends State<AddBaby> {
  Baby baby = Baby();
  List<Baby> babies = [];

  String? _selectedDate;
  String? _selectMonth;
  String? _selectYear;
  String? _selectGender;

  static List<String> Date = List<String>.generate(31, (index) {
    return (index + 1).toString().padLeft(2, '0');
  });

  final List<dynamic> Month = [
    {'id': '01', 'th': 'มกราคม'},
    {'id': '02', 'th': 'กุมภาพันธ์'},
    {'id': '03', 'th': 'มีนาคม'},
    {'id': '04', 'th': 'เมษายน'},
    {'id': '05', 'th': 'พฤษภาคม'},
    {'id': '06', 'th': 'มิถุนายน'},
    {'id': '07', 'th': 'กรกฏาคม'},
    {'id': '08', 'th': 'สิงหาคม'},
    {'id': '09', 'th': 'กันยายน'},
    {'id': '10', 'th': 'ตุลาคม'},
    {'id': '11', 'th': 'พฤศจิกายน'},
    {'id': '12', 'th': 'ธันว่าคม'},
  ];

  final List<dynamic> gender = [
    {'id': '01', 'xx': 'ชาย'},
    {'id': '02', 'xx': 'หญิง'},
  ];

  final List<String> Year = List<String>.generate(
      100, (index) => (DateTime.now().year - index + 543).toString());

  @override
  void initState() {
    super.initState();

    //print(data['birthdate']);
    //_selectedDate = data['birthdate'];
    //_selectMonth = data['2birthmonth'];
    //_selectYear = data['birthyear'];
  }

  int daysInMonth(String? month, int year) {
    int gregorianYear = year - 543;
    switch (month) {
      case 'เมษายน':
      case 'มิถุนายน':
      case 'กันยายน':
      case 'พฤศจิกายน':
        return 30;
      case 'กุมภาพันธ์':
        if ((gregorianYear % 4 == 0 && gregorianYear % 100 != 0) ||
            gregorianYear % 400 == 0) {
          return 29;
        } else {
          return 28;
        }
      default:
        return 31;
    }
  }

  void _onMonthChanged(String? value) {
    setState(() {
      _selectMonth = value;
      int days = daysInMonth(_selectMonth,
          int.parse(_selectYear ?? DateTime.now().year.toString()));
      Date = List<String>.generate(days, (index) {
        return (index + 1).toString().padLeft(2, '0');
      });

      if (_selectedDate != null && int.parse(_selectedDate!) > days) {
        _selectedDate = days.toString().padLeft(2, '0');
        data['birthdate'] = _selectedDate;
      }
    });
  }

  void _onYearChanged(String? value) {
    setState(() {
      _selectYear = value;
      if (_selectMonth == 'กุมภาพันธ์') {
        int days = daysInMonth(_selectMonth,
            int.parse(_selectYear ?? DateTime.now().year.toString()));
        Date = List<String>.generate(days, (index) {
          return (index + 1).toString().padLeft(2, '0');
        });
        if (_selectedDate != null && int.parse(_selectedDate!) > days) {
          _selectedDate = days.toString().padLeft(2, '0');
          data['birthdate'] = _selectedDate;
        }
      }
    });
  }

  void _saveBaby() async {
    // Set the Baby object with the selected values
    baby.name = data['name_baby'];
    baby.birthdate =
        '${data['birthdate']}-${data['2birthmonth']}-${data['birthyear']}';
    baby.gender = data['gender'];
    baby.weight = data['weight_baby'];
    baby.height = data['height_baby'];
    baby.headCircumference = data['radhead_baby'];
    baby.chestCircumference = data['radbreast_baby'];

    // Insert the Baby into the database
    final insertedBaby = await NotesDatabase.instance.insertBaby(baby);

    // Print the inserted Baby information
    print('Inserted Baby: $insertedBaby');
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(
          FocusNode(),
        );
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text('สร้างข้อมูลลูก')),
        body: Center(
          child: Column(
            children: [
              _TextFromfield(
                'ชื่อเล่น',
                (value) {
                  setState(() {
                    data['name_baby'] = value;
                    print(data['name_baby']);
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'วันเกิด',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CustomDropdown(
                            value: _selectedDate,
                            items: Date,
                            onChanged: (value) {
                              data['birthdate'] = value;
                              setState(() {
                                _selectedDate = value;
                              });
                              //print(data['birthdate']);
                            },
                            hintText: 'วัน',
                          ),
                        ),
                      ),
                      Text('  '),
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CustomDropdown(
                            value: _selectMonth,
                            items: Month.map((e) => e['th'] as String).toList(),
                            onChanged: (value) {
                              data['2birthmonth'] = value;
                              setState(() {
                                _selectMonth = value;

                                data['2birthmonth'] = Month.firstWhere(
                                    (e) => e['th'] == value)['id'];
                                print(data['2birthmonth']);
                                _onMonthChanged(value);
                              });
                              //print(data['birthdate']);
                            },
                            hintText: 'เดือน',
                          ),
                        ),
                      ),
                      Text('  '),
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CustomDropdown(
                            value: _selectGender,
                            items: Year,
                            onChanged: (value) {
                              setState(() {
                                data['birthyear'] = value;
                                _onYearChanged(value);
                              });
                              //print(data['birthdate']);
                            },
                            hintText: 'พ.ศ.',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'เพศ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CustomDropdown(
                            value: _selectGender,
                            items:
                                gender.map((e) => e['xx'] as String).toList(),
                            onChanged: (value) {
                              setState(() {
                                data['gender'] = value;
                                print(data['gender']);
                              });
                            },
                            hintText: 'เพศ',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _TextFromfield(
                'น้ำหนัก',
                (value) {
                  setState(() {
                    data['weight_baby'] = value;
                    print(data['weight_baby']);
                  });
                },
              ),
              _TextFromfield(
                'ส่วนสูง',
                (value) {
                  setState(() {
                    data['height_baby'] = value;
                    print(data['height_baby']);
                  });
                },
              ),
              _TextFromfield(
                'ความยาวรอบศีรษะ',
                (value) {
                  setState(() {
                    data['radhead_baby'] = value;
                    print(data['radhead_baby']);
                  });
                },
              ),
              _TextFromfield(
                'ความยาวรอบหน้าอก',
                (value) {
                  setState(() {
                    data['radbreast_baby'] = value;
                    print(data['radbreast_baby']);
                  });
                },
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: height * 0.2,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: width * 0.9,
                            alignment: Alignment.center,
                            child: CustomButton(
                              text: 'บันทึกข้อมูล',
                              onPressed: () {
                                _saveBaby();
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/overview', (route) => false);
                              },
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _TextFromfield(String label, onChange) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 7),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                ),
              ),
            ),
            Expanded(
              flex: label.length > 12 ? 1 : 4,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: onChange,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
