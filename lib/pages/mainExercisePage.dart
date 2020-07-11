import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:smart_ms3/pages/bluetooth/mainBluetooth.dart';
import 'package:smart_ms3/pages/datadisplay_page.dart';
import 'package:smart_ms3/pages/exercise_page.dart';
import 'package:smart_ms3/pages/userProfile.dart';

const Color redColor = const Color(0xFFEA425C);
const Color iconBG = const Color(0x11647082);
const Color navColor = const Color(0xFFffebef);

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

class ExercisePageScreenTwo extends StatelessWidget {
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
              Expanded(
                child: ListView.builder(
                  itemCount: titles.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                         Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ExercisePage(injury: titles[index])));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top:8.0,bottom:8.0,left:16,right:16),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
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
          Text(
            "Exercise Sets",
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
