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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  subtitle: Text('วันเกิด: ${baby.birthdate ?? ''}'),
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          color: Colors.white,
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
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width,
                            child: Text('ส่วนสูง',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.03))),
                        _buildHeightChart(snapshot.data!),
                        Text('\n'),
                        Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width,
                            child: Text('น้ำหนัก',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
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
      ),
    );
  }

  Widget _buildHeightChart(List<Baby> growthData) {
    List<BarChartGroupData> barGroups = [];
    Map<int, String> indexToDateMap = {};

    for (var i = 0; i < growthData.length; i++) {
      var height = double.tryParse(growthData[i].height ?? '0') ?? 0.0;

      // Parsing the birthdate
      var birthdateParts = growthData[i].birthdate?.split('-') ?? [];
      var formattedDate = '';
      if (birthdateParts.length == 3) {
        formattedDate =
            '${birthdateParts[2].substring(2, 4)}-${birthdateParts[1]}-${birthdateParts[0]}';
      }
      indexToDateMap[i] = formattedDate;

      barGroups.add(
        BarChartGroupData(
          x: i,
          //show value above bar
          showingTooltipIndicators: [0],
          barRods: [
            BarChartRodData(
              width: 16,
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(0),
              toY: height,
            ),
          ],
        ),
      );
    }
    double chartWidth = growthData.length * 100.0;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: 300,
        width: growthData.length > 3 ? chartWidth : 300,
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
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    var date = indexToDateMap[value.toInt()] ?? '';
                    return SideTitleWidget(
                      child: Text(date),
                      axisSide: meta.axisSide,
                    );
                  },
                ),
              ),
            ),
            barGroups: barGroups,
          ),
        ),
      ),
    );
  }

  Widget _buildWeightChart(List<Baby> growthData) {
    List<BarChartGroupData> barGroups = [];
    Map<int, String> indexToDateMap = {};

    for (var i = 0; i < growthData.length; i++) {
      var weight = double.tryParse(growthData[i].weight ?? '0') ?? 0.0;

      // Parsing the birthdate
      var birthdateParts = growthData[i].birthdate?.split('-') ?? [];
      var formattedDate = '';
      if (birthdateParts.length == 3) {
        formattedDate =
            '${birthdateParts[2].substring(2, 4)}-${birthdateParts[1]}-${birthdateParts[0]}';
      }
      indexToDateMap[i] = formattedDate;

      barGroups.add(
        BarChartGroupData(
          x: i,
          showingTooltipIndicators: [0],
          barRods: [
            BarChartRodData(
              width: 16,
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(0),
              toY: weight,
            ),
          ],
        ),
      );
    }
    double chartWidth = growthData.length * 100.0;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: 300,
        width: growthData.length > 3 ? chartWidth : 300,
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
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    var date = indexToDateMap[value.toInt()] ?? '';
                    return SideTitleWidget(
                      child: Text(date),
                      axisSide: meta.axisSide,
                    );
                  },
                ),
              ),
            ),
            barGroups: barGroups,
          ),
        ),
      ),
    );
  }
}
