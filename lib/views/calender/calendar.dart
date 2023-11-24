// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables

import 'package:babymilk2/database/database.dart';
import 'package:babymilk2/model/baby.dart';
import 'package:babymilk2/widget/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarEntry {
  String milkAmount;
  String fridgeType;

  CalendarEntry({required this.milkAmount, required this.fridgeType});
}

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late final ValueNotifier<DateTime> _selectedDay;
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  bool _showForm = false;
  Map<DateTime, CalendarEntry> _calendarData = {};
  TextEditingController _milkAmountController = TextEditingController();
  TextEditingController _fridgeTypeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDay = ValueNotifier(DateTime.now());
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _fridgeTypeController.text = 'ช่องฟรีส';
    _loadCalendarData();
  }

  void _loadCalendarData() async {
    List<Mom> moms = await NotesDatabase.instance.getAllMoms();
    setState(() {
      for (var mom in moms) {
        DateTime date = DateTime.parse(mom.startdate!);
        _calendarData[date] = CalendarEntry(
          milkAmount: mom.bottlemilk.toString(),
          fridgeType: mom.typefreze!,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ปฏิทิน'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          setState(() {
            _showForm = false;
          });
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    if (_calendarData.containsKey(day) &&
                        int.parse(_calendarData[day]!.milkAmount) > 0) {
                      return Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          day.day.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                    return null;
                  },
                ),
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay.value, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  _loadDataForSelectedDay(selectedDay);
                  setState(() {
                    _selectedDay.value = selectedDay;
                    _focusedDay = focusedDay;
                    _showForm = true;
                  });
                },
                onPageChanged: (focusedDay) {
                  setState(() {
                    _focusedDay = focusedDay;
                  });
                },
                headerStyle: HeaderStyle(
                  formatButtonTextStyle:
                      TextStyle().copyWith(color: Colors.white),
                  formatButtonDecoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  markerDecoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  outsideDaysVisible: false,
                ),
              ),
              if (_showForm)
                Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: _buildForm()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    String expirationDate = _calculateExpirationDate();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('จำนวนนม'),
              Text(_milkAmountController.text.isNotEmpty
                  ? _milkAmountController.text
                  : '0'),
              Row(
                children: [
                  IconButton(
                    onPressed: _incrementMilkAmount,
                    icon: Icon(Icons.add),
                  ),
                  IconButton(
                    onPressed: _decrementMilkAmount,
                    icon: Icon(Icons.remove),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Text('ประเภทตู้เย็น'),
              ),
              Text('ช่องฟรีส'),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Text('วันหมดอายุ'),
              ),
              Text(expirationDate),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: CustomButton(
                      text: 'บันทึก',
                      onPressed: _saveFormData,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  String _calculateExpirationDate() {
    DateTime selectedDate = _selectedDay.value;
    DateTime expirationDate = selectedDate.add(Duration(days: 14));

    String formattedExpirationDate =
        '${expirationDate.day}/${expirationDate.month}/${expirationDate.year}';

    return formattedExpirationDate;
  }

  void _incrementMilkAmount() {
    var value = int.tryParse(_milkAmountController.text) ?? 0;
    value++;
    _updateMilkAmount(value);
  }

  void _decrementMilkAmount() {
    var value = int.tryParse(_milkAmountController.text) ?? 0;
    if (value > 0) {
      value--;
      _updateMilkAmount(value);
    }
  }

  void _updateMilkAmount(int value) {
    setState(() {
      _milkAmountController.text = value.toString();
    });
  }

  void _loadDataForSelectedDay(DateTime day) {
    CalendarEntry? entry = _calendarData[day];
    _fridgeTypeController.text = 'ช่องฟรีส';
    if (entry != null) {
      _milkAmountController.text = entry.milkAmount;
      _fridgeTypeController.text = entry.fridgeType;
    } else {
      _milkAmountController.clear();
      _fridgeTypeController.clear();
    }
  }

  void _saveFormData() {
    String milkAmount = _milkAmountController.text;
    String fridgeType = 'ช่องฟรีส';
    DateTime selectedDate = _selectedDay.value;

    if (milkAmount.isNotEmpty && fridgeType.isNotEmpty) {
      _calendarData[selectedDate] = CalendarEntry(
        milkAmount: milkAmount,
        fridgeType: fridgeType,
      );
      setState(() {
        _showForm = false;
        print(_calendarData);

        final mom = Mom(
          bottlemilk: int.tryParse(milkAmount) ?? 0,
          startdate: selectedDate.toString(),
          expdate: _calculateExpirationDate(),
          typefreze: 'ช่องฟรีส',
        );
        NotesDatabase.instance.insertMom(mom);
      });
    }
  }

  @override
  void dispose() {
    _selectedDay.dispose();
    _milkAmountController.dispose();
    _fridgeTypeController.dispose();
    super.dispose();
  }
}
