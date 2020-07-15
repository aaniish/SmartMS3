import 'package:auto_size_text/auto_size_text.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:smart_ms3/pages/bluetooth/mainBluetooth.dart';
import 'package:smart_ms3/pages/datadisplay_page.dart';
import 'package:smart_ms3/pages/exercise_page.dart';
import 'package:smart_ms3/pages/userProfile.dart';
import 'package:smart_ms3/widgets/provider_widget.dart';

const Color redColor = const Color(0xFFEA425C);
const Color iconBG = const Color(0x11647082);
const Color recommendColor = const Color(0xFF75daff);

String theInjury;
String thelowestAveMuscle;

class ExercisePageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/bluetooth': (BuildContext context) => FlutterBlueApp(),
        '/data': (BuildContext context) => SensorPage(),
        '/profile': (BuildContext context) => ProfileView(),
      },
      theme: ThemeData(primaryColor: redColor, accentColor: redColorAccent),
      home: ExercisePageScreenTwo(),
    );
  }
}

class ExercisePageScreenTwo extends StatefulWidget {
  @override
  _ExercisePageScreenTwoState createState() => _ExercisePageScreenTwoState();
}

class _ExercisePageScreenTwoState extends State<ExercisePageScreenTwo> {
  String theTargetMuscle;

  @override
  Widget build(BuildContext context) {
    final titles = [
      'Bursitis',
      'Tendinitis',
      'Frozen Shoulder',
      'Impingement',
      'Rotator Cuff Tear',
      'Shoulder Arthritis',
      'Shoulder Instability',
      'Shoulder Dislocation',
      'Shoulder Separation'
    ];

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    Future<String> getInjury() async {
      final uid = await Provider.of(context).auth.getCurrentUID();
      var injury;
      await Firestore.instance
          .collection("userData")
          .document(uid)
          .collection("userInfo")
          .getDocuments()
          .then((event) {
        if (event.documents.isNotEmpty) {
          Map<String, dynamic> documentData =
              event.documents.single.data; //if it is a single document
          injury = documentData["Curent shoulder injury"];
        }
      }).catchError((e) => print("error fetching data: $e"));
      return injury;
    }

    Future<List<double>> getAverage(x) async {
      List<double> averages = List();
      final uid = await Provider.of(context).auth.getCurrentUID();
      for (int i = 0; i < x.length; i++) {
        double counter = 0;
        double total = 0;
        CollectionReference _documentRef = Firestore.instance
            .collection("userData")
            .document(uid)
            .collection(x[i]);

        await _documentRef.getDocuments().then((ds) {
          if (ds != null) {
            ds.documents.forEach((value) {
              total += value.data["Average"].toDouble();
              counter++;
            });
            if (total == 0 && counter == 0) {
              averages.add(null);
            } else {
              averages.add(total / counter);
            }
          }
        });
      }
      return averages;
    }

    Future<String> findLowAverage() async {
      String injury = await getInjury();
      var muscleGroups;
      await Firestore.instance
          .collection("exercises")
          .document(injury)
          .collection("affectedMuscleGroups")
          .getDocuments()
          .then((event) {
        if (event.documents.isNotEmpty) {
          Map<String, dynamic> documentData =
              event.documents.single.data; //if it is a single document
          muscleGroups = documentData["muscle groups"];
          //print(muscleGroups);
        }
      }).catchError((e) => print("error fetching data: $e"));

      var finalAverages = await getAverage(muscleGroups);
      String lowest = '';
      for (int i = 0; i < muscleGroups.length; i++) {
        if (finalAverages[i]==0) {
          finalAverages.removeAt(i);
          muscleGroups.removeAt(i);
          i--;
        }
        if (finalAverages[i]==null) {
          finalAverages.removeAt(i);
          muscleGroups.removeAt(i);
          i--;
        }
      }
      for (int j = 0; j < muscleGroups.length - 1; j++) {
        if (finalAverages[j] != null &&
            finalAverages[j + 1] != null &&
            finalAverages[j] < finalAverages[j + 1]) {
          lowest = muscleGroups[j];
        } else { 
          lowest = muscleGroups[j+1];
        }
        
      }
      
      return lowest;
    }

    void setMuscle() async {
      theTargetMuscle = await findLowAverage();
    }

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
                          "Common Shoulder Injuries",
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
              SizedBox(
                height: height * 0.20,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Container(
                      color: const Color(0xFFf2f2f2),
                      child: ListView.builder(
                        itemCount: titles.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ExercisePage(injury: titles[index], route: '/exercise2',)));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, bottom: 8.0, left: 32, right: 32),
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: ListTile(
                                  title: Text(
                                    titles[index],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'HelveticaNeue',
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * 0.04,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: FutureBuilder(
                    future: getInjury(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (!snapshot.hasData)
                        return Align(
                          child: CircularProgressIndicator(),
                        ); // still loading
                      // alternatively use snapshot.connectionState != ConnectionState.done
                      final String injuryExercise = snapshot.data;
                      return Column(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Weekly Exercise Set: $injuryExercise",
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
                        ],
                      );
                      // return a widget here (you have to return a widget to the builder)
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: FutureBuilder(
                    future: findLowAverage(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (!snapshot.hasData)
                        return Align(
                          child: CircularProgressIndicator(),
                        ); // still loading
                      // alternatively use snapshot.connectionState != ConnectionState.done
                      final String targetMuscle = snapshot.data;
                      return Column(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Target Muscle: $targetMuscle",
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
                        ],
                      );
                      // return a widget here (you have to return a widget to the builder)
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: height * 0.2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Container(
                      color: const Color(0xFFf2f2f2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, 
                        children: <Widget>[
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Center(
                               child: Text(
                                          "Recommended Exercises In Blue",
                                          style: TextStyle(
                                            color: recommendColor,
                                            fontFamily: 'HelveticaNeue',
                                            fontWeight: FontWeight.bold,
                                            fontSize: width * 0.04,
                                          ),
                                        ),
                             ),
                           ),
                          Expanded(
                                                      child: FutureBuilder(
                                future: getInjury(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<String> snapshot) {
                                  if (!snapshot.hasData)
                                    return Align(
                                      child: CircularProgressIndicator(),
                                    ); // still loading
                                  // alternatively use snapshot.connectionState != ConnectionState.done
                                  final String injury = snapshot.data;
                                  return FutureBuilder(
                                      future: findLowAverage(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<String> snapshot) {
                                        if (!snapshot.hasData)
                                          return Align(
                                            child: CircularProgressIndicator(),
                                          ); // still loading
                                        // alternatively use snapshot.connectionState != ConnectionState.done
                                        final String targetMuscle = snapshot.data;
                                        return StreamBuilder(
                                          stream: Firestore.instance
                                              .collection('exercises')
                                              .document(injury)
                                              .collection('exerciseSets')
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.data == null)
                                              return Align(
                                                alignment:
                                                    FractionalOffset.bottomCenter,
                                                child: CircularProgressIndicator(),
                                              );

                                            if (snapshot.hasError)
                                              return new Text(
                                                  'Error: ${snapshot.error}');
                                            else {
                                              return ListView.builder(
                                                itemCount:
                                                    snapshot.data.documents.length,
                                                itemBuilder: (context, index) {
                                                  DocumentSnapshot mypost =
                                                      snapshot.data.documents[index];
                                                  if (targetMuscle != "" && targetMuscle !=null && mypost["muscles"] != null &&
                                                      mypost["muscles"].toLowerCase().contains(
                                                          targetMuscle.toLowerCase())) {
                                                    return Stack(
                                                      children: <Widget>[
                                                        Column(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 8.0,
                                                                      bottom: 8.0,
                                                                      left: 32,
                                                                      right: 32),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30.0),
                                                                child: Container(
                                                                    width:
                                                                        MediaQuery.of(
                                                                                context)
                                                                            .size
                                                                            .width,
                                                                    height: 100.0,
                                                                    color:
                                                                        Colors.white,
                                                                    child: Padding(
                                                                        padding:
                                                                            EdgeInsets
                                                                                .all(
                                                                                    8),
                                                                        child: Material(
                                                                            color: Colors.white,
                                                                            child: Center(
                                                                              child:
                                                                                  Padding(
                                                                                padding:
                                                                                    EdgeInsets.all(8.0),
                                                                                child:
                                                                                    Row(
                                                                                  children: <Widget>[
                                                                                    Container(
                                                                                      height: MediaQuery.of(context).size.width,
                                                                                      width: 100.0,
                                                                                      child: Image.network('${mypost['image']}', fit: BoxFit.fill),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 20.0,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 100.0,
                                                                                      child: AutoSizeText(
                                                                                        '${mypost['title']}',
                                                                                        style: TextStyle(color: recommendColor, fontFamily: 'HelveticaNeue', fontSize: 15.0, fontWeight: FontWeight.bold),
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
                                                  } else {
                                                    return Stack(
                                                      children: <Widget>[
                                                        Column(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 8.0,
                                                                      bottom: 8.0,
                                                                      left: 32,
                                                                      right: 32),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30.0),
                                                                child: Container(
                                                                    width:
                                                                        MediaQuery.of(
                                                                                context)
                                                                            .size
                                                                            .width,
                                                                    height: 100.0,
                                                                    color:
                                                                        Colors.white,
                                                                    child: Padding(
                                                                        padding:
                                                                            EdgeInsets
                                                                                .all(
                                                                                    8),
                                                                        child: Material(
                                                                            color: Colors.white,
                                                                            child: Center(
                                                                              child:
                                                                                  Padding(
                                                                                padding:
                                                                                    EdgeInsets.all(8.0),
                                                                                child:
                                                                                    Row(
                                                                                  children: <Widget>[
                                                                                    Container(
                                                                                      height: MediaQuery.of(context).size.width,
                                                                                      width: 100.0,
                                                                                      child: Image.network('${mypost['image']}', fit: BoxFit.fill),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 20.0,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 100.0,
                                                                                      child: AutoSizeText(
                                                                                        '${mypost['title']}',
                                                                                        style: TextStyle(color: Colors.black, fontFamily: 'HelveticaNeue', fontSize: 15.0, fontWeight: FontWeight.bold),
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
                                                  }
                                                },
                                              );
                                            }
                                          },
                                        );
                                        // return a widget here (you have to return a widget to the builder)
                                      });
                                  // return a widget here (you have to return a widget to the builder)
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
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
          Text(
            "Exercise",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'HelveticaNeue',
                fontSize: 30,
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
              child: IconButton(
                icon: Icon(Icons.person, color: Colors.black, size: 25),
                onPressed: () {
                  Navigator.of(context).pushNamed('/profile');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
