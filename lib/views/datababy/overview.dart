import 'package:babymilk2/data/data.dart';
import 'package:babymilk2/database/database.dart';
import 'package:babymilk2/model/baby.dart';
import 'package:babymilk2/widget/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Overview extends StatefulWidget {
  const Overview({Key? key});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  List<Baby> babies = [];
  List<Baby> babies2 = [];
  int? _selectedRow;
  bool? isSwitched = false;

  @override
  void initState() {
    super.initState();
    //print babies.id

    _loadBabies();
  }

  String convertYear(String Year) {
    Year = Year.substring(Year.length - 4, Year.length);

    int year = int.parse(Year) - 543;

    return year.toString();
  }

  String calculateAge(String? birthdate) {
    if (birthdate == null) {
      return 'No Data';
    }

    final day = int.parse(birthdate.substring(0, 2));
    final month = int.parse(birthdate.substring(3, 5));
    final year = int.parse(convertYear(birthdate)); // แปลงปีเป็น integer

    final date = DateTime(year, month, day);

    final current = DateTime.now().toLocal();

    final ageDuration = current.difference(date);

    final years = ageDuration.inDays ~/ 365;
    final months = (ageDuration.inDays % 365) ~/ 30;
    final days = (ageDuration.inDays % 365) % 30;

    if (years > 0) {
      if (months > 0) {
        if (days > 0) {
          return '$years ปี $months เดือน $days วัน';
        } else {
          return '$years ปี $months เดือน';
        }
      } else {
        if (days > 0) {
          return '$years ปี $days วัน';
        } else {
          return '$years ปี';
        }
      }
    } else {
      if (months > 0) {
        if (days > 0) {
          return '$months เดือน $days วัน';
        } else {
          return '$months เดือน';
        }
      } else {
        return '$days วัน';
      }
    }
  }

  Future<void> _deleteBaby(babyId) async {
    await NotesDatabase.instance.deleteBaby(babyId);
    _loadBabies();
  }

  Future<void> _loadBabies() async {
    final allBabies = await NotesDatabase.instance.getAllBabies2();
    setState(() {
      babies = allBabies;
    });

    final allBabies2 = await NotesDatabase.instance.getAllBabies3();
    setState(() {
      babies2 = allBabies2;
    });
  }

  Widget _header() {
    final headers = [
      'ชื่อลูก',
      'อายุ(ปี.เดือน.วัน)',
      'น้ำหนัก\n(กก.)',
      'ส่วนสูง\n(ซม.)',
    ];
    final w_headers = [
      0.2,
      0.4,
      0.15,
      0.15,
    ];
    return Row(
      children: List.generate(headers.length, (index) {
        return _buildContainer(
            headers[index],
            MediaQuery.of(context).size.width * w_headers[index],
            const Color.fromARGB(255, 230, 96, 141));
      }),
    );
  }

  Widget _dataRow(Baby baby, int index) {
    var w_headers = [
      0.2,
      0.4,
      0.15,
      0.15,
    ];
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedRow == index) {
            _selectedRow = null;
          } else {
            _selectedRow = index;
          }
          print(_selectedRow);
        });
      },
      child: Container(
        color: _selectedRow == index ? Colors.green[300] : null,
        child: Row(
          children: [
            _buildContainer(
                baby.name ?? 'No Data',
                MediaQuery.of(context).size.width * w_headers[0],
                const Color.fromARGB(0, 255, 255, 255)),
            _buildContainer(
                calculateAge(baby.birthdate),
                MediaQuery.of(context).size.width * w_headers[1],
                const Color.fromARGB(0, 255, 255, 255)),
            _buildContainer(
                babies2[index].weight ?? 'No Data',
                MediaQuery.of(context).size.width * w_headers[2],
                const Color.fromARGB(0, 255, 255, 255)),
            _buildContainer(
                babies2[index].height ?? 'No Data',
                MediaQuery.of(context).size.width * w_headers[3],
                const Color.fromARGB(0, 255, 255, 255)),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer(String text, double width, Color backgroundColor) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.05,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: Colors.black, width: 0.5),
      ),
      child: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('บันทึกข้อมูลลูก'),

        //leading
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            data['id_bb'] = '';
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: height * 0.7,
              width: width * 0.9,
              child: Column(
                children: [
                  _header(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: babies.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _dataRow(babies[index], index);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: height * 0.2,
              width: width,
              child: Column(
                children: [
                  _selectedRow != null
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: width * 0.45,
                                alignment: Alignment.center,
                                child: CustomButton(
                                    color: Colors.greenAccent,
                                    text: 'อัพเดท ',
                                    onPressed: () {
                                      if (_selectedRow != null) {
                                        Navigator.pushNamed(
                                          context,
                                          '/savegrowth',
                                        );
                                        data['name_baby'] =
                                            babies[_selectedRow!].name;
                                        data['gender'] =
                                            babies[_selectedRow!].gender;
                                        data['birthdate'] =
                                            babies[_selectedRow!].birthdate;

                                        setState(() {});
                                      }
                                    }),
                              ),
                              Container(
                                width: width * 0.45,
                                alignment: Alignment.center,
                                child: CustomButton(
                                  color: Colors.red,
                                  text: 'ลบข้อมูล',
                                  onPressed: () {
                                    if (_selectedRow != null) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text('แจ้งเตือน'),
                                          content: Text(
                                              'คุณต้องการลบ ${babies[_selectedRow!].name} ใช่หรือไม่'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text('ตกลง'),
                                              onPressed: () {
                                                _deleteBaby(
                                                    babies[_selectedRow!]
                                                        .name!);
                                                _selectedRow = null;
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: Text('ยกเลิก'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          width: width * 0.9,
                          alignment: Alignment.center,
                          child: CustomButton(
                            color: Colors.pink,
                            text: 'สร้างข้อมูลลูก',
                            onPressed: () {
                              Navigator.pushNamed(context, '/addbaby');
                              setState(() {});
                            },
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
