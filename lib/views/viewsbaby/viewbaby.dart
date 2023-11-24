import 'package:babymilk2/data/data.dart';
import 'package:babymilk2/database/database.dart';
import 'package:babymilk2/model/baby.dart';
import 'package:flutter/material.dart';

class ViewBaby extends StatefulWidget {
  const ViewBaby({super.key});

  @override
  State<ViewBaby> createState() => _ViewBabyState();
}

class _ViewBabyState extends State<ViewBaby> {
  List<Baby> babies = [];

  @override
  void initState() {
    super.initState();

    _loadBabies();
  }

  Future<void> _loadBabies() async {
    final allBabies = await NotesDatabase.instance.getAllBabies2();
    setState(() {
      babies = allBabies;
    });
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
    final year = int.parse(convertYear(birthdate));

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

  void haha(hd, hh, wd, wh) {
    if (double.parse(data['weight']) < wd) {
      //print('ผอม');
      data['status_w'] = 'ผอม';
    } else if (double.parse(data['weight']) > wh) {
      //print('อ้วน');
      data['status_w'] = 'อ้วน';
    } else {
      //print('ปกติ');
      data['status_w'] = 'ปกติ';
    }
    if (double.parse(data['height']) < hd) {
      //print('เตี้ย');
      data['status_h'] = 'เตี้ย';
    } else if (double.parse(data['height']) > hh) {
      //print('ค่อนข้างสูง');
      data['status_h'] = 'ค่อนข้างสูง';
    } else {
      //print('ปกติ');
      data['status_h'] = 'ปกติ';
    }
  }

  String calculatewh(String? birthdate, String? gender) {
    calculateAge(birthdate);
    setState(() {
      if (calculateAge(birthdate).contains('ปี')) {
        //print('อิแก้');
      } else {
        if (calculateAge(birthdate).contains('เดือน')) {
          //print('อายุ 1 - 12 เดือน');
          var date = int.parse(calculateAge(birthdate).substring(0, 2));
          if (gender == 'ชาย') {
            if (date == 1) {
              haha(50.4, 56.2, 3.4, 4.7);
            } else if (date == 2) {
              haha(53.2, 59.1, 4.2, 5.5);
            } else if (date == 3) {
              haha(55.7, 61.9, 4.8, 6.4);
            } else if (date == 4) {
              haha(58.1, 64.6, 5.3, 7.1);
            } else if (date == 5) {
              haha(60.4, 67.1, 5.8, 7.8);
            } else if (date == 6) {
              haha(62.4, 69.2, 6.3, 8.4);
            } else if (date == 7) {
              haha(64.2, 71.3, 6.8, 9.0);
            } else if (date == 8) {
              haha(65.9, 73.2, 7.2, 9.5);
            } else if (date == 9) {
              haha(67.4, 75.0, 7.6, 9.9);
            } else if (date == 10) {
              haha(68.9, 76.7, 7.9, 10.3);
            } else if (date == 11) {
              haha(70.2, 78.2, 8.11, 10.6);
            } else if (date == 12) {
              haha(71.5, 79.7, 8.30, 11.0);
            }
          } else {
            if (date == 1) {
              haha(49.4, 56.0, 3.3, 4.4);
            } else if (date == 2) {
              haha(52.0, 59.0, 3.8, 5.2);
            } else if (date == 3) {
              haha(54.4, 61.8, 4.4, 6.0);
            } else if (date == 4) {
              haha(56.8, 64.5, 4.9, 6.7);
            } else if (date == 5) {
              haha(58.9, 66.9, 5.3, 7.3);
            } else if (date == 6) {
              haha(60.9, 69.1, 5.8, 7.9);
            } else if (date == 7) {
              haha(62.6, 71.1, 6.2, 8.5);
            } else if (date == 8) {
              haha(64.2, 72.8, 6.6, 9.0);
            } else if (date == 9) {
              haha(65.5, 74.5, 6.9, 9.3);
            } else if (date == 10) {
              haha(66.7, 76.1, 7.2, 9.8);
            } else if (date == 11) {
              haha(67.7, 77.6, 7.5, 10.2);
            } else if (date == 12) {
              haha(68.8, 78.9, 7.7, 10.5);
            }
          }
        } else {
          //print(calculateAge(birthdate));
          //print('อายุแรกเกิด');
          if (gender == 'ชาย') {
            if (double.parse(data['weight']) < 2.8) {
              // print('ผอม');
              data['status_w'] = 'ผอม';
            } else if (double.parse(data['weight']) > 3.9) {
              // print('อ้วน');
              data['status_w'] = 'อ้วน';
            } else {
              //print('ปกติ');
              data['status_w'] = 'ปกติ';
            }
            if (double.parse(data['height']) < 47.6) {
              //print('เตี้ย');
              data['status_h'] = 'เตี้ย';
            } else if (double.parse(data['height']) > 53.31) {
              //print('ค่อนข้างสูง');
              data['status_h'] = 'ค่อนข้างสูง';
            } else {
              //print('ปกติ');
              data['status_h'] = 'ปกติ';
            }
          } else {
            if (double.parse(data['weight']) < 2.7) {
              //print('ผอม');
              data['status_w'] = 'ผอม';
            } else if (double.parse(data['weight']) > 3.7) {
              //print('อ้วน');
              data['status_w'] = 'อ้วน';
            } else {
              //print('ปกติ');
              data['status_w'] = 'ปกติ';
            }
            if (double.parse(data['height']) < 46.8) {
              //print('เตี้ย');
              data['status_h'] = 'เตี้ย';
            } else if (double.parse(data['height']) > 52.9) {
              //print('ค่อนข้างสูง');
              data['status_h'] = 'ค่อนข้างสูง';
            } else {
              //print('ปกติ');
              data['status_h'] = 'ปกติ';
            }
          }
        }
      }
    });

    return calculateAge(birthdate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ประวัติน้อง'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: babies.length,
              itemBuilder: (context, index) {
                final baby = babies[index];
                return ListTile(
                  title: Text(baby.name ?? ''),
                  subtitle: Text('Birthdate: ${baby.birthdate ?? ''}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BabyHistoryScreen(baby: baby),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BabyHistoryScreen extends StatelessWidget {
  final Baby baby;

  const BabyHistoryScreen({required this.baby});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ประวัติน้อง${baby.name}'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        color: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ประวัติน้อง ${baby.name}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'อายุ ${calculateAge(baby.birthdate)}  ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            //fetch data from database with same name as baby.name
            FutureBuilder<List<Baby>>(
              future: NotesDatabase.instance.getAllBabies4('${baby.name}'),
              builder: (context, snapshot) {
                final growth = snapshot.data ?? [];

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: growth.length,
                  itemBuilder: (context, index) {
                    final growthItem = growth[index];
                    return Card(
                      child: ListTile(
                        title: Text('วันที่: ${growthItem.birthdate}'),
                        subtitle: Text(
                            'น้ำหนัก: ${growthItem.weight} ส่วนสูง: ${growthItem.height}'),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
