import 'dart:io';

import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:smart_ms3/pages/bluetooth/mainBluetooth.dart';
import 'package:smart_ms3/pages/datadisplay_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const Color redColor = const Color(0xFFEA425C);
const Color iconBG = const Color(0x11647082);
const Color navColor = const Color(0xFFffebef);

class ChartsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/bluetooth': (BuildContext context) => FlutterBlueApp(),
        '/data': (BuildContext context) => SensorPage(),
      },
      home: ChartspageScreen(),
    );
  }
}

class ChartspageScreen extends StatelessWidget {
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
                          "Progress",
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
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(
                            bottom: 8,
                            left: 16,
                            right: 16,
                            top: 10,
                          ),
                          child: Container(
                              child: Column(
                            children: <Widget>[
                            
                              FlatButton(
                                color: Colors.white60,
                                textColor: Colors.black,
                                disabledColor: Colors.grey,
                                disabledTextColor: Colors.black,
                                padding: EdgeInsets.all(10.0),
                                splashColor: Colors.grey,
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/data');
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.red)),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "Bluetooth Graph Example",
                                      style: TextStyle(
                                          fontFamily: 'HelveticaNeue',
                                          fontSize: 15.0),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ))),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 85     , child: Container()),
              Expanded(child: new DataList())
            ],
          ),
        ],
      ),
    );
  }
}

class DataList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('Datasets').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return new ListView(
              scrollDirection: Axis.vertical,
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return new ListTile(
                  title: new Text(document['Date'], style: TextStyle(fontFamily: 'HelveticaNeue', fontWeight: FontWeight.bold, fontSize: 15),),
                  leading: Icon(Icons.show_chart, color: Colors.black),
                  contentPadding: EdgeInsets.only(left: 20, right: 20),
                  onTap: () {

                  },

                );
              }).toList(),
            );
        }
      },
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
          Text(
            "Charts",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'HelveticaNeue',
                fontSize: 40,
                fontWeight: FontWeight.bold),
          ),
          ClayContainer(
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
              child: Icon(Icons.menu, color: Colors.black, size: 25),
            ),
          ),
        ],
      ),
    );
  }
}
