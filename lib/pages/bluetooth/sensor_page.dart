import 'dart:async';
import 'dart:convert' show utf8;
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:oscilloscope/oscilloscope.dart';

const Color redColor = const Color(0xFFEA425C);

class SensorPage extends StatefulWidget {
  final BluetoothDevice device;
  const SensorPage({Key key, this.device}) : super(key: key);

  @override
  _SensorPageState createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {
  final String SERVICE_UUID =
      "dd55f584-5caa-4726-8be9-6ee6621d52b9"; //needs to be changed
  final String CHARACTERISTIC_UUID =
      "6fa807df-2cf4-4e1e-915b-ad0623bf573d"; //needs to be changed
  bool isReady;
  Stream<List<int>> stream;
  List<double> emgData = List();
  final dateTime = new DateTime.now();


  @override
  void initState() {
    super.initState();
    isReady = false;
    connectToDevice();
  }

  connectToDevice() async {
    if (widget.device == null) {
      _Pop();
      return;
    }

    new Timer(const Duration(seconds: 15), () {
      if (!isReady) {
        disconnectFromDevice();
        _Pop();
      }
    });

    await widget.device.connect();
    discoverServices();
  }

  disconnectFromDevice() {
    if (widget.device == null) {
      _Pop();
      return;
    }

    widget.device.disconnect();
  }

  discoverServices() async {
    if (widget.device == null) {
      _Pop();
      return;
    }

    List<BluetoothService> services = await widget.device.discoverServices();
    services.forEach((service) {
      if (service.uuid.toString() == SERVICE_UUID) {
        service.characteristics.forEach((characteristic) {
          if (characteristic.uuid.toString() == CHARACTERISTIC_UUID) {
            characteristic.setNotifyValue(!characteristic.isNotifying);
            stream = characteristic.value;
            setState(() {
              isReady = true;
            });
          }
        });
      }
    });

    if (!isReady) {
      _Pop();
    }
  }

  Future<bool> _onWillPop() {
    return showDialog(
        context: context,
        builder: (context) =>
            new AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to disconnect device and go back?'),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text(
                      'No',
                      style: TextStyle(color: Colors.black),
                    )),
                new FlatButton(
                    onPressed: () {
                      disconnectFromDevice();
                      Navigator.of(context).pop(true);
                    },
                    child:
                        new Text('Yes', style: TextStyle(color: Colors.black))),
              ],
            ) ??
            false);
  }

  _Pop() {
    Navigator.of(context).pop(true);
  }

  String _dataParser(List<int> dataFromDevice) {
    return utf8.decode(dataFromDevice);
  }


  @override
  Widget build(BuildContext context) {
    Oscilloscope oscilloscope = Oscilloscope(
      showYAxis: true,
      yAxisColor: Colors.white,
      padding: 10.0,
      backgroundColor: Colors.black,
      traceColor: Colors.red,
      yAxisMax: 100.0,
      yAxisMin: 0.0,
      dataSet: emgData,
    );

    final databaseReference = Firestore.instance;

    void createRecord() async {
      String date = DateTimeFormat.format(dateTime, format: DateTimeFormats.american);
      await databaseReference
          .collection("Datasets")
          .document(date)
          .setData({'Data': emgData, 'Date': date, 'Time': emgData.length});
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text('EMG Sensor'),
        ),
        body: Container(
            child: !isReady
                ? Center(
                    child: Text(
                      "Waiting...",
                      style: TextStyle(fontSize: 24, color: Colors.redAccent),
                    ),
                  )
                : Container(
                    child: StreamBuilder<List<int>>(
                      stream: stream,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<int>> snapshot) {
                        if (snapshot.hasError)
                          return Text('Error: ${snapshot.error}');

                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          var currentValue = _dataParser(snapshot.data);
                          emgData.add(double.tryParse(currentValue) ?? 0);

                          return Center(
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
                                                title: Text(' successfully saved'),
                                              );
                                            });
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side: BorderSide(
                                                  color: Colors.red)),
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
                          ));
                        } else {
                          return Text('Check the stream');
                        }
                      },
                    ),
                  )),
      ),
    );
  }
}


