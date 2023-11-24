import 'package:babymilk2/data/data.dart';
import 'package:babymilk2/database/database.dart';
import 'package:babymilk2/model/baby.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Graph extends StatefulWidget {
  const Graph({Key? key}) : super(key: key);

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
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

  // ... existing methods ...

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
            FutureBuilder<List<Baby>>(
              future: NotesDatabase.instance.getAllBabies4('${baby.name}'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No data available');
                } else {
                  return Column(
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width,
                          child: Text('ส่วนสูง',
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.03))),
                      _buildHeightChart(snapshot.data!),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width,
                          child: Text('น้ำหนัก',
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.03))),
                      _buildWeightChart(snapshot.data!),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeightChart(List<Baby> growthData) {
    List<BarChartGroupData> barGroups = [];
    for (var i = 0; i < growthData.length; i++) {
      var height = double.tryParse(growthData[i].height ?? '0') ?? 0.0;
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              width: 16,
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(8),
              toY: height,
            ),
          ],
        ),
      );
    }

    return Container(
      height: 300,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 100,
          barTouchData: BarTouchData(
            enabled: false,
          ),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: barGroups,
        ),
      ),
    );
  }

  Widget _buildWeightChart(List<Baby> growthData) {
    List<BarChartGroupData> barGroups = [];
    for (var i = 0; i < growthData.length; i++) {
      var weight = double.tryParse(growthData[i].weight ?? '0') ?? 0.0;
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              width: 16,
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(8),
              toY: weight,
            ),
          ],
        ),
      );
    }

    return Container(
      height: 300,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 100,
          barTouchData: BarTouchData(
            enabled: false,
          ),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: barGroups,
        ),
      ),
    );
  }
}
