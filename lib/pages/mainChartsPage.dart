import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:smart_ms3/pages/bluetooth/mainBluetooth.dart';
import 'package:smart_ms3/pages/charts_page.dart';
import 'package:smart_ms3/pages/datadisplay_page.dart';
import 'package:smart_ms3/pages/userProfile.dart';

const Color redColor = const Color(0xFFEA425C);
const Color iconBG = const Color(0x11647082);
const Color navColor = const Color(0xFFffebef);

class ChartsPageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/bluetooth': (BuildContext context) => FlutterBlueApp(),
        '/data': (BuildContext context) => SensorPage(),
        '/charts': (BuildContext context) => ChartsPageTwo(),
        '/profile': (BuildContext context) => ProfileView(),
      },
      home: ChartspageScreenTwo(),
    );
  }
}

class ChartspageScreenTwo extends StatelessWidget {
  final CategoriesScroller categoriesScroller = CategoriesScroller();

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
                          "Pick Muscle Group",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'HelveticaNeue',
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.04,
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
              categoriesScroller,
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(
                          top: 110,
                          bottom: 8,
                          left: 32,
                          right: 16,
                        ),
                        child: Container(
                            child: Row(
                          children: <Widget>[
                            Text(
                              "Progress",
                              style: (const TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'HelveticaNeue',
                                  fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ))),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: RoundedProgressBar(
                    childLeft:
                        Text("20%", style: TextStyle(color: Colors.white)),
                    percent: 20,
                    theme: RoundedProgressBarTheme.red),
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
            "Charts/Progress",
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

class _Container extends StatelessWidget {
  final String name;
  final String image;

  _Container(this.name, this.image);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: 20),
      height: MediaQuery.of(context).size.height * 0.30 - 50,
      decoration: BoxDecoration(
          image: new DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.white.withOpacity(0.5), BlendMode.dstATop),
            image: new AssetImage(image),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              name,
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontFamily: 'HelveticaNeue',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller();

  @override
  Widget build(BuildContext context) {
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 50;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChartsPage(muscle: "Anterior Deltoid")));
                },
                child:
                    _Container("Anterior Deltoid", 'assets/icons/deltoid.jpg'),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChartsPage(muscle: "Middle Deltoid")));
                },
                child:
                    _Container("Middle\nDeltoid", 'assets/icons/deltoid.jpg'),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChartsPage(muscle: "Posterior Deltoid")));
                },
                child: _Container(
                    "Posterior\nDeltoid", 'assets/icons/deltoid.jpg'),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChartsPage(muscle: "Upper Trapezius")));
                },
                child: _Container(
                    "Upper\nTrapezius", 'assets/icons/trapezius.jpg'),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChartsPage(muscle: "Middle Trapezius")));
                },
                child: _Container(
                    "Middle\nTrapezius", 'assets/icons/trapezius.jpg'),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChartsPage(muscle: "Lower Trapezius")));
                },
                child: _Container(
                    "Lower\nTrapezius", 'assets/icons/trapezius.jpg'),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChartsPage(muscle: "Serratus Anterior")));
                },
                child: _Container(
                    "Serratus\nAnterior", 'assets/icons/serratus.jpg'),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChartsPage(muscle: "Teres Minor")));
                },
                child: _Container("Teres\nMinor", 'assets/icons/teres.png'),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChartsPage(muscle: "Upper Latissinus Dorsi")));
                },
                child: _Container(
                    "Upper Latissinus Doris", 'assets/icons/dorsi.png'),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChartsPage(muscle: "Lower Latissinus Dorsi")));
                },
                child: _Container(
                    "Lower Latissinus Doris", 'assets/icons/dorsi.png'),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChartsPage(muscle: "Upper Pectoralis Major")));
                },
                child: _Container(
                    "Upper Pectoralis Major", 'assets/icons/pecs.png'),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChartsPage(muscle: "Lower Pectoalis Major")));
                },
                child: _Container(
                    "Lower Pectoalis Major", 'assets/icons/pecs.png'),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChartsPage(muscle: "Supraspinatus")));
                },
                child: _Container(
                    "Supras-pinatus", 'assets/icons/supraspinatus.png'),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChartsPage(muscle: "Infraspinatus")));
                },
                child: _Container(
                    "Infrasp-inatus", 'assets/icons/infraspinatus.png'),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChartsPage(muscle: "Subscapularis")));
                },
                child: _Container(
                    "Subscapu-laris", 'assets/icons/subscapularis.png'),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChartsPage(muscle: "Rhomboid Major")));
                },
                child:
                    _Container("Rhomboid Major", 'assets/icons/rhomboid.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
