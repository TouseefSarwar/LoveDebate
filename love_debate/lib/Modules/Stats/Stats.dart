import 'package:app_push_notifications/Utils/Globals/Colors.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:app_push_notifications/Utils/Globals/CustomAppBar.dart';
import 'package:pie_chart/pie_chart.dart';

class Stats extends StatefulWidget {
  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {

  Map<String,double>data=new Map();
  List<Color>colorList=[
    Colors.red,
    Colors.pink,
    Colors.redAccent,
    Colors.pinkAccent
  ];

  @override
  void initState() {
    super.initState();
    data.putIfAbsent("Forever", () => 5);
    data.putIfAbsent("Far", () => 3);
    data.putIfAbsent("Always", () => 2);
    data.putIfAbsent("Near", () => 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.setNavigation("Stats"),
      body: Container(
        child: Center(
          child: PieChart(
            dataMap: data,
            animationDuration: Duration(milliseconds: 800),
            chartLegendSpacing: 31.0,
            chartRadius: MediaQuery.of(context).size.width / 2,
            showChartValuesInPercentage: false,
            showChartValues: false,
            showChartValuesOutside: false,
            chartValueBackgroundColor: Colors.grey[200],
            colorList: colorList,
            showLegends: true,
            //legendPosition: LegendPosition.left,
            decimalPlaces: 2,
            showChartValueLabel: true,
            initialAngle: 0,
            chartValueStyle: defaultChartValueStyle.copyWith(
              color: Colors.blueGrey[900].withOpacity(0.9),
            ),
            legendStyle: TextStyle(fontSize: 25),
            chartType: ChartType.disc,
          ),
        ),
      )
    );
  }
}
class Chart extends StatefulWidget {
  @override
  _ChartState createState() => _ChartState();
}
class _ChartState extends State<Chart> {

  Map<String,double>data=new Map();
  List<Color>colorList=[
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.greenAccent
  ];
  @override
  void initState() {
    super.initState();
    data.putIfAbsent("Flutter", () => 5);
    data.putIfAbsent("React", () => 3);
    data.putIfAbsent("Xamarin", () => 2);
    data.putIfAbsent("Ionic", () => 2);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: PieChart(
            dataMap: data,
            animationDuration: Duration(milliseconds: 800),
            chartLegendSpacing: 31.0,
            chartRadius: MediaQuery.of(context).size.width / 2,
            showChartValuesInPercentage: false,
            showChartValues: false,
            showChartValuesOutside: false,
            chartValueBackgroundColor: Colors.grey[200],
            colorList: colorList,
            showLegends: true,
            //legendPosition: LegendPosition.left,
            decimalPlaces: 2,
            showChartValueLabel: true,
            initialAngle: 0,
            chartValueStyle: defaultChartValueStyle.copyWith(
              color: Colors.blueGrey[900].withOpacity(0.9),
            ),
            legendStyle: TextStyle(fontSize: 25),
            chartType: ChartType.disc,
        ),
      ),
      ));
  }
}
