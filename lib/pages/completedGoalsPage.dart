import 'package:clay_containers/clay_containers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_ms3/pages/bluetooth/mainBluetooth.dart';
import 'package:smart_ms3/pages/homepage_screen.dart';
import 'package:smart_ms3/widgets/provider_widget.dart';

const Color redColor = const Color(0xFFEA425C);
const Color iconBG = const Color(0x11647082);
const Color navColor = const Color(0xFFffebef);

class CompletedGoalsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => Homepage(),
      },
      theme: ThemeData(primaryColor: redColor, accentColor: redColorAccent),
      home: CompletedGoalsScreen(),
    );
  }
}

class CompletedGoalsScreen extends StatefulWidget {
  @override
  _CompletedGoalsScreenState createState() => _CompletedGoalsScreenState();
}

class _CompletedGoalsScreenState extends State<CompletedGoalsScreen> {
  
  void clearGoals() async {
    final databaseReference = Firestore.instance;
    final uid = await Provider.of(context).auth.getCurrentUID();
    await databaseReference
        .collection('userData')
        .document(uid)
        .collection('completedGoals')
        .getDocuments()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents) {
        ds.reference.delete();
      }
    });
  }

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
              SizedBox(
                height: 20,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                    onPressed: () {
                      clearGoals();
                    },
                    color: Colors.white,
                    textColor: Colors.black,
                    child: Text("Clear Goals",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'HelveticaNeue',
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              Expanded(child: goalList())
            ],
          ),
        ],
      ),
    );
  }

  Widget goalList() {
    return StreamBuilder(
        stream: getUsersDataStreamSnapshots(context),
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshots.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot documentSnapshot =
                      snapshots.data.documents[index];
                  return Card(
                    elevation: 0,
                    margin:
                        EdgeInsets.only(top: 8, bottom: 8, left: 32, right: 32),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      title: Text(
                        documentSnapshot["todoTitle"],
                        style: TextStyle(
                            fontFamily: 'HelveticaNeue',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                });
          } else {
            return Align(
              alignment: FractionalOffset.bottomCenter,
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Stream<QuerySnapshot> getUsersDataStreamSnapshots(
      BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance
        .collection('userData')
        .document(uid)
        .collection('completedGoals')
        .snapshots();
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
                  Navigator.of(context).pushNamed('/home');
                },
              ),
            ),
          ),
          Text(
            "Completed Goals",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'HelveticaNeue',
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
