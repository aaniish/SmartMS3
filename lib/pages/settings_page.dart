import 'package:clay_containers/clay_containers.dart';
import 'package:clay_containers/widgets/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:smart_ms3/pages/bluetooth/mainBluetooth.dart';
import 'package:smart_ms3/pages/userProfile.dart';
import 'package:smart_ms3/pages/questionnaire.dart';


const Color redColor = const Color(0xFFEA425C);

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/profile': (BuildContext context) => ProfileView(),
        '/questionnaire': (BuildContext context) => QuestionPageScreen(),

      },
      theme: ThemeData(primaryColor: redColor, accentColor: redColorAccent),
      home: SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: height,
        color: redColor,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            _AppBar(),
            SizedBox(
              height: 50,
            ),
            Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/questionnaire');                                               
                    },
                    color: Colors.white,
                    textColor: Colors.black,
                    child: Text("Questionnaire",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'HelveticaNeue',
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
          ],
        ),
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
            "Settings",
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
