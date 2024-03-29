import 'package:smart_ms3/pages/mainExercisePage.dart';
import 'package:smart_ms3/pages/navigation/animated_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:smart_ms3/pages/mainChartsPage.dart';
import 'package:smart_ms3/pages/homepage_screen.dart';
import 'package:smart_ms3/pages/questionnaire.dart';
import 'package:smart_ms3/pages/settings_page.dart';


const Color redColor = const Color(0xFFEA425C);
const Color iconBG = const Color(0x11647082);
const Color navColor = const Color(0xFFffebef);
int _selectedBarIndex = 0;

class BottomBarNavigation extends StatefulWidget {
  final List<BarItem> barItems = [
    BarItem(
      text: "Home",
      iconData: Icons.home,
      color: redColor,
    ),
    BarItem(
      text: "Charts",
      iconData: Icons.insert_chart,
      color: redColor,
    ),
    BarItem(
      text: "Exercise",
      iconData: Icons.directions_bike,
      color: redColor,
    ),
    BarItem(
      text: "Settings",
      iconData: Icons.settings,
      color: redColor,
    ),
  ];

  @override
  _BottomBarNavigationState createState() =>
      _BottomBarNavigationState();
}

class _BottomBarNavigationState
    extends State<BottomBarNavigation> {
  

  final tabs = [
    Homepage(),
    ChartsPageTwo(),
    ExercisePageTwo(),
    SettingsPage()
  ];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    //final user = Provider.of<User>(context);
    //print(user);

    return Scaffold(
      body: tabs[_selectedBarIndex],
      bottomNavigationBar: AnimatedBottomBar(
          barItems: widget.barItems,
          animationDuration: const Duration(milliseconds: 150),
          barStyle: BarStyle(
            fontSize: width * 0.04,
            iconSize: width * 0.06,
          ),
          onBarTap: (index) {
            setState(() {
              _selectedBarIndex = index;
            });
          },
          ),
    );
  }
}