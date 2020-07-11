import 'package:auto_size_text/auto_size_text.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_ms3/pages/bluetooth/mainBluetooth.dart';
import 'package:smart_ms3/pages/mainExercisePage.dart';
import 'package:smart_ms3/pages/userProfile.dart';

const Color redColor = const Color(0xFFEA425C);
const Color iconBG = const Color(0x11647082);
const Color navColor = const Color(0xFFffebef);

class DataList extends StatelessWidget {
  final String injury;

  DataList(this.injury);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('exercises')
          .document(injury)
          .collection('exerciseSets')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data == null) return Align(
              alignment: FractionalOffset.bottomCenter,
              child: CircularProgressIndicator(),
            );

        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        else {
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot mypost = snapshot.data.documents[index];
              return Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40.0),
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 400.0,
                              color: Colors.white,
                              child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Material(
                                      color: Colors.white,
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 200.0,
                                                child: Image.network(
                                                    '${mypost['image']}',
                                                    fit: BoxFit.fill),
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Text(
                                                '${mypost['title']}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'HelveticaNeue',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              SizedBox(
                                                height: 80.0,
                                                child: AutoSizeText(
                                                  '${mypost['subtitle']}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily:
                                                          'HelveticaNeue',
                                                      fontSize: 25.0),
                                                  minFontSize: 5,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              SizedBox(
                                                height: 30.0,
                                                child: AutoSizeText(
                                                  'muscle groups: ${mypost['muscles']}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily:
                                                          'HelveticaNeue',
                                                      fontSize: 15.0),
                                                  minFontSize: 5,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )))),
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
          );
        }
      },
    );
  }
}

class ExercisePage extends StatelessWidget {
  final String injury;
  ExercisePage({Key key, @required this.injury}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: redColor, accentColor: redColorAccent),
      routes: <String, WidgetBuilder>{
        '/exercise2': (BuildContext context) => ExercisePageTwo(),
      },
      home: ExercisePageScreen(injury),
    );
  }
}

class ExercisePageScreen extends StatelessWidget {
  final String injury;

  ExercisePageScreen(this.injury);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            height: height,
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
                          injury,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'HelveticaNeue',
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.04,
                          ),
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Scrollbar(child: new DataList(injury)),
              )
            ],
          ),
        ],
      ),
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
              Navigator.of(context).pushNamed('/exercise2');
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
            "Exercises",
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
