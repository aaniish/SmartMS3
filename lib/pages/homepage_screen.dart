import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:smart_ms3/pages/bluetooth/mainBluetooth.dart';
import 'package:smart_ms3/pages/charts_page.dart';
import 'package:smart_ms3/pages/userProfile.dart';
import 'package:smart_ms3/services/auth_service.dart';
import 'package:smart_ms3/widgets/provider_widget.dart';

const Color redColor = const Color(0xFFEA425C);
const Color lightRed = const Color(0xCCFF3E4D);
const Color navColor = const Color(0xFFffebef);

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/profile': (BuildContext context) => ProfileView(),
      },
      home: HomepageScreen(),
    );
  }
}

class HomepageScreen extends StatelessWidget {
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
                          "Exercises",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'HelveticaNeue',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 30,
              ),
              /*
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 300,
                    left: 32,
                    right: 32,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFFE83350),
                          const Color(0xFFE8290B)
                        ],
                      )),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: Text(
                          "YOUR NEXT WORKOUT",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'HelveticaNeue',
                              fontSize: 15,
                              color: Colors.white70),
                        ),
                      ),
                      Text(
                        "Upper Body",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'HelveticaNeue',
                            fontSize: 22,
                            color: Colors.white),
                      ),
                      Expanded(
                          child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                color: redColor,
                              ),
                              padding: const EdgeInsets.all(10),
                              child: IconButton(
                                icon: Image.asset(
                                  "assets/icons/icon1.png",
                                  color: Colors.white,
                                  width: 50,
                                  height: 50,
                                ),
                                onPressed: null,
                              )),
                          SizedBox(width: 10),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                color: redColor,
                              ),
                              padding: const EdgeInsets.all(10),
                              child: IconButton(
                                icon: Image.asset(
                                  "assets/icons/icon2.png",
                                  color: Colors.white,
                                  width: 50,
                                  height: 50,
                                ),
                                onPressed: null,
                              )),
                          SizedBox(width: 10),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                color: redColor,
                              ),
                              padding: const EdgeInsets.all(10),
                              child: IconButton(
                                icon: Image.asset(
                                  "assets/icons/icon3.png",
                                  color: Colors.white,
                                  width: 50,
                                  height: 50,
                                ),
                                onPressed: null,
                              )),
                          SizedBox(width: 10),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                color: redColor,
                              ),
                              padding: const EdgeInsets.all(10),
                              child: IconButton(
                                icon: Image.asset(
                                  "assets/icons/icon4.png",
                                  color: Colors.white,
                                  width: 50,
                                  height: 50,
                                ),
                                onPressed: null,
                              )),
                          SizedBox(width: 10),
                        ],
                      )),
                    ],
                  ),
                ),
              ),
              */
            ],
          ),
          Positioned(
            top: height * 0.61,
            left: 0,
            right: 0,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8,
                        left: 32,
                        right: 16,
                      ),
                      child: Container(
                          child: Row(
                        children: <Widget>[
                          Text(
                            "GOALS FOR TODAY",
                            style: (const TextStyle(
                                fontFamily: 'HelveticaNeue',
                                fontWeight: FontWeight.bold)),
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {},
                          ),
                        ],
                      ))),
                ],
              ),
            ),
          )
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
            "Home",
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

class _Background extends StatelessWidget {
  final double width, height;

  const _Background({Key key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)),
        child: ColoredBox(color: redColor),
      ),
    );
  }
}
