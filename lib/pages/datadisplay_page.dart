import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:oscilloscope/oscilloscope.dart';

const Color redColor = const Color(0xFFEA425C);
const Color iconBG = const Color(0x11647082);
const Color navColor = const Color(0xFFffebef);

class SensorPage extends StatefulWidget {
  const SensorPage({Key key}) : super(key: key);

  @override
  _SensorPageState createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {
  List<double> emgData = [0, 0, 0, 615, 617, 565, 619, 559, 618, 614, 619, 618, 535, 570, 609, 618, 617, 522, 587, 616, 575, 166, 0, 0, 0, 619, 618, 617, 616, 0, 0, 618, 619, 619, 400, 401, 406, 411, 410, 413, 409, 408, 403, 473
];
  final dateTime = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    Oscilloscope oscilloscope = Oscilloscope(
      showYAxis: true,
      yAxisColor: Colors.white,
      padding: 10.0,
      traceColor: Colors.red,
      yAxisMax: 800.0,
      yAxisMin: 0.0,
      dataSet: emgData,
    );

    final databaseReference = Firestore.instance;



    void createRecord() async {
      String date =
          DateTimeFormat.format(dateTime, format: DateTimeFormats.american);
      await databaseReference
          .collection("Datasets")
          .document(date)
          .setData({'Data': emgData, 'Date': date, 'Time': emgData.length});
    }



    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: Text('EMG Sensor'),
        ),
        body: Container(
            child: false
                ? Center(
                    child: Text(
                      "Waiting...",
                      style: TextStyle(fontSize: 24, color: Colors.redAccent),
                    ),
                  )
                : Container(
                    child: Container(
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('Current value from EMG Sensor',
                                      style: TextStyle(fontSize: 14)),
                                  Text('20.0',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24)),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, top: 10),
                                    child: FlatButton(
                                      color: redColor,
                                      textColor: Colors.white,
                                      disabledColor: Colors.grey,
                                      disabledTextColor: Colors.black,
                                      padding: EdgeInsets.all(10.0),
                                      splashColor: Colors.grey,
                                      onPressed: () {
                                        createRecord();
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              Future.delayed(
                                                  Duration(seconds: 1), () {
                                                Navigator.of(context).pop(true);
                                              });
                                              return AlertDialog(
                                                title:
                                                    Text(' successfully saved'),
                                              );
                                            });
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.red)),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.save,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "  Save Data",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'HelveticaNeue',
                                                fontSize: 20),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                          Expanded(
                            flex: 1,
                            child: oscilloscope,
                          )
                        ],
                      )),
                    ),
                  )),
      ),
    );
  }
}
