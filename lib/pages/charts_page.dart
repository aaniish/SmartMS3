import 'dart:math';

import 'package:clay_containers/clay_containers.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smart_ms3/pages/bluetooth/mainBluetooth.dart';
import 'package:smart_ms3/pages/datadisplay_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_ms3/pages/mainChartsPage.dart';
import 'package:smart_ms3/widgets/provider_widget.dart';

const Color redColor = const Color(0xFFEA425C);
const Color iconBG = const Color(0x11647082);
const Color navColor = const Color(0xFFffebef);
List<double> emgData = [0];
List<double> emgDataAverage = [0];
List<double> emgDataOriginal = [0];
String currentData = '';

void clearEmg() {
  emgData = [0];
}

void clearDate() {
  currentData = '';
}

class DataList extends StatelessWidget {
  final String muscle;

  DataList(this.muscle);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getUsersDataStreamSnapshots(context, muscle),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Align(
              alignment: FractionalOffset.topCenter,
              child: CircularProgressIndicator(),
            );
          default:
            return new ListView(
              scrollDirection: Axis.vertical,
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return new ListTile(
                  title: new Text(
                    document['Date'],
                    style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  leading: Icon(Icons.show_chart, color: Colors.black),
                  contentPadding: EdgeInsets.only(left: 20, right: 20),
                  onTap: () {
                    emgDataOriginal = document['Data'].cast<double>();
                    emgData = emgDataOriginal;
                    currentData = document['Date'];
                    Navigator.of(context).pushNamed('/charts');
                  },
                );
              }).toList(),
            );
        }
      },
    );
  }
}

Stream<QuerySnapshot> getUsersDataStreamSnapshots(
    BuildContext context, String group) async* {
  final uid = await Provider.of(context).auth.getCurrentUID();
  yield* Firestore.instance
      .collection('userData')
      .document(uid)
      .collection(group)
      .snapshots();
}

List<EMGData> getData(List<double> x) {
  List<EMGData> values = List();
  for (int i = 0; i < x.length; i++) {
    values.add(new EMGData(i, x[i]));
  }
  return values;
}

class EMGData {
  EMGData(this.x, this.y);
  final int x;
  final double y;
}

class ChartsPage extends StatelessWidget {
  final String muscle;
  ChartsPage({Key key, @required this.muscle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: redColor, accentColor: redColorAccent),
      routes: <String, WidgetBuilder>{
        '/bluetooth': (BuildContext context) => FlutterBlueApp(),
        '/data': (BuildContext context) => SensorPage(),
        '/charts': (BuildContext context) => ChartspageScreen(muscle),
        '/charts2': (BuildContext context) => ChartsPageTwo(),
      },
      home: ChartspageScreen(muscle),
    );
  }
}

class ChartspageScreen extends StatelessWidget {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  bool showAvg = false;
  final String muscle;

  ChartspageScreen(this.muscle);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            height: height * 0.6,
            left: 0,
            right: 0,
            child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                    bottom: const Radius.circular(40)),
                child: Container(color: redColor)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              _AppBar(),
              SizedBox(
                height: 30,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          muscle,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'HelveticaNeue',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: FlatButton(
                            color: Colors.white,
                            textColor: Colors.black,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            padding: EdgeInsets.all(10.0),
                            splashColor: Colors.grey,
                            onPressed: () {
                              Navigator.of(context).pushNamed('/bluetooth');
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red)),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.bluetooth_searching),
                                Text(
                                  "  Connect Device",
                                  style: TextStyle(
                                      fontFamily: 'HelveticaNeue',
                                      fontSize: width * 0.03),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: new ButtonBar(
                    mainAxisSize: MainAxisSize
                        .min, // this will take space as minimum as posible(to center)
                    children: <Widget>[
                      FlatButton(
                        color: Colors.white60,
                        textColor: Colors.black,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(10.0),
                        splashColor: Colors.grey,
                        onPressed: () {
                          getAverageDataSpot(emgDataOriginal);
                          emgData = emgDataAverage;
                          Navigator.of(context).pushNamed('/charts');
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Avg",
                              style: TextStyle(
                                  fontFamily: 'HelveticaNeue', fontSize: 15.0),
                            )
                          ],
                        ),
                      ),
                      FlatButton(
                        color: Colors.white60,
                        textColor: Colors.black,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(10.0),
                        splashColor: Colors.grey,
                        onPressed: () {
                          getSDDataSpot(emgDataOriginal);
                          emgData = emgDataAverage;
                          Navigator.of(context).pushNamed('/charts');
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "SD",
                              style: TextStyle(
                                  fontFamily: 'HelveticaNeue', fontSize: 15.0),
                            )
                          ],
                        ),
                      ),
                      FlatButton(
                        color: Colors.white60,
                        textColor: Colors.black,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(10.0),
                        splashColor: Colors.grey,
                        onPressed: () {
                          emgData = emgDataOriginal;
                          Navigator.of(context).pushNamed('/charts');
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Reg",
                              style: TextStyle(
                                  fontFamily: 'HelveticaNeue', fontSize: 15.0),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AspectRatio(
                aspectRatio: 2,
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(18),
                      ),
                      color: redColor),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 18.0, left: 12.0, bottom: 12),
                    child: LineChart(
                      mainData(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.05),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(
                          top: 30,
                          bottom: 8,
                          left: 32,
                          right: 16,
                        ),
                        child: Container(
                            child: Row(
                          children: <Widget>[
                            Text(
                              "PICK DATASET / CURRENT:  $currentData",
                              style: (TextStyle(
                                  fontFamily: 'HelveticaNeue',
                                  fontWeight: FontWeight.bold,
                                  fontSize: width * 0.03)),
                            ),
                          ],
                        ))),
                  ],
                ),
              ),
              Expanded(
                child: Scrollbar(child: new DataList(muscle)),
              )
            ],
          ),
        ],
      ),
    );
  }

  List<FlSpot> getDataSpot(List<double> x) {
    List<FlSpot> values = List();
    for (int i = 0; i < x.length; i++) {
      values.add(new FlSpot(i.toDouble(), x[i]));
    }
    return values;
  }

  void getAverageDataSpot(List<double> x) {
    List<double> values = List();
    double ave = 0;
    for (int j = 0; j < x.length; j++) {
      ave += x[j];
    }
    ave = ave / x.length;
    for (int i = 0; i < x.length; i++) {
      values.add(ave);
    }
    emgDataAverage = values;
  }

  void getSDDataSpot(List<double> x) {
    List<double> values = List();
    double sum = 0;
    double sd = 0;
    int length = x.length;
    for (int j = 0; j < x.length; j++) {
      sum += x[j];
    }
    double mean = sum / length;
    for (int i = 0; i < x.length; i++) {
      sd += pow(x[i] - mean, 2);
    }
    sd = sqrt(sd / length);
    for (int n = 0; n < x.length; n++) {
      values.add(sd);
    }
    emgDataAverage = values;
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.white,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.white,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 10:
                return '10';
              case 20:
                return '20';
              case 30:
                return '30';
              case 40:
                return '40';
              case 50:
                return '50';
              case 60:
                return '60';
              case 70:
                return '70';
              case 80:
                return '80';
              case 90:
                return '90';
              case 100:
                return '100';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 200:
                return '200';
              case 400:
                return '400';
              case 600:
                return '600';
              case 800:
                return '800';
              case 1000:
                return '1000';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true, border: Border.all(color: Colors.white, width: 1)),
      minX: 0,
      maxX: 100,
      minY: 0,
      maxY: 1000,
      lineBarsData: [
        LineChartBarData(
          spots: getDataSpot(emgData),
          isCurved: false,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: () {
              clearEmg();
              clearDate();
              Navigator.of(context).pushNamed('/charts2');
            },
            child: ClayContainer(
              height: 50,
              width: 50,
              depth: 20,
              borderRadius: 25,
              parentColor: redColor,
              curveType: CurveType.concave,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white.withOpacity(0.3), width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: Icon(Icons.arrow_back, color: Colors.black, size: 25),
              ),
            ),
          ),
          Text(
            "Charts",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'HelveticaNeue',
                fontSize: 40,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
