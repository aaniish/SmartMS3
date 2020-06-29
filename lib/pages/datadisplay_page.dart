import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:oscilloscope/oscilloscope.dart';
import 'package:smart_ms3/widgets/provider_widget.dart';

const Color redColor = const Color(0xFFEA425C);
const Color iconBG = const Color(0x11647082);
const Color navColor = const Color(0xFFffebef);
final databaseReference = Firestore.instance;

class SensorPage extends StatefulWidget {
  const SensorPage({Key key}) : super(key: key);

  @override
  _SensorPageState createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {
  List<double> emgData = [619, 620, 619, 620, 619, 619, 620, 619, 620, 619, 619, 620, 619, 619, 620, 619, 620, 619, 619, 620, 617, 616, 619, 617, 619, 610, 619, 612, 616, 616, 616, 613, 616, 618, 429, 435, 422, 424, 411, 384, 374, 317, 387, 423];
  List<int> test = [462];
  final dateTime = new DateTime.now();

  String _dataParser(List<int> dataFromDevice) {
    return utf8.decode(dataFromDevice);
  }

  final myController = TextEditingController();
  final shoulder = [
    'Anterior Deltoid',
    'Middle Deltoid',
    'Posterior Deltoid',
    'Upper Trapezius',
    'Middle Trapezius',
    'Lower Trapezius',
    'Serratus Anterior',
    'Teres Minor',
    'Upper Latissinus Doris',
    'Lower Latissinus Doris',
    'Upper Pectoralis Major',
    'Lower Pectoalis Major',
    'Supraspinatus',
    'Infraspinatus',
    'Subscapularis',
    'Rhomboid Major'
  ];
  String dropdownValue = 'Anterior Deltoid';

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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

    void createRecord(String muscleGroup) async {
      final uid = await Provider.of(context).auth.getCurrentUID();
      String date =
          DateTimeFormat.format(dateTime, format: DateTimeFormats.american);
      await databaseReference
          .collection("userData")
          .document(uid)
          .collection(muscleGroup)
          .add({
        'Data': emgData,
        'Date': date,
        'Time': emgData.length,
        'Muscle Group': muscleGroup
      });
    }

    var currentValue = (test).toString();

    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                                  Text('${currentValue}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24)),
                                  /*
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: TextField(
                                    controller: myController,
                                    decoration: new InputDecoration(
                                        border: new OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(10.0),
                                          ),
                                        ),
                                        filled: true,
                                        hintStyle: new TextStyle(
                                            color: Colors.grey[800]),
                                        hintText: "Enter Muscle Group",
                                        fillColor: Colors.white70),
                                  ),
                                  ),
                                  */
                                  Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: DropdownButtonFormField(
                                      value: dropdownValue,
                                      icon: Icon(Icons.arrow_downward),
                                      decoration: InputDecoration(
                                        labelText: "Select Muscle Group",
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      items: shoulder.map((String value) {
                                        return new DropdownMenuItem<String>(
                                          value: value,
                                          child: new Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          dropdownValue = newValue;
                                        });
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Select Muscle Group';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
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
                                        createRecord(dropdownValue);
                                        myController.clear();
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              Future.delayed(
                                                  Duration(seconds: 1), () {
                                                Navigator.of(context).pop(true);
                                              });
                                              return AlertDialog(
                                                title:
                                                    Text('successfully saved'),
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
                          Container(
                            height: height * 0.15,
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
