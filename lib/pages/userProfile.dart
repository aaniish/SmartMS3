import 'package:clay_containers/clay_containers.dart';
import 'package:clay_containers/widgets/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_ms3/pages/charts_page.dart';
import 'package:smart_ms3/services/auth_service.dart';
import 'package:smart_ms3/widgets/provider_widget.dart';

const Color redColor = const Color(0xFFEA425C);

class ProfileView extends StatelessWidget {
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
            FutureBuilder(
              future: Provider.of(context).auth.getCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return displayUserInformation(context, snapshot);
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                color: Colors.white,
                onPressed: () async {
                    clearEmg();
                    AuthService auth = Provider.of(context).auth;
                    await auth.signOut();
                    print("Signed Out!");
                  },
                child: Text(
                   "Sign out",
                        style: TextStyle(
                            fontFamily: 'HelveticaNeue', fontSize: 15, fontWeight: FontWeight.bold),
                )
              ),
            )
            
          ],
        ),
      )
    );
  }

  Widget displayUserInformation(context, snapshot) {
    final user = snapshot.data;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Name:  ${user.displayName}",
            style: TextStyle(
                fontFamily: 'HelveticaNeue',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Email:  ${user.email}",
            style: TextStyle(
                fontFamily: 'HelveticaNeue',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Created:  ${DateFormat('MM/dd/yyyy').format(user.metadata.creationTime)}",
            style: TextStyle(
                fontFamily: 'HelveticaNeue',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white),
          ),
        ),
      ],
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
                icon: Icon(Icons.arrow_back, color: Colors.black, size: 25),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Text(
            "Profile",
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
