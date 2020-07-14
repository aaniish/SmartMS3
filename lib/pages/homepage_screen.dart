import 'package:auto_size_text/auto_size_text.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_ms3/pages/completedGoalsPage.dart';
import 'package:smart_ms3/pages/bluetooth/mainBluetooth.dart';
import 'package:smart_ms3/pages/navigation/bottom_navigation.dart';
import 'package:smart_ms3/pages/userProfile.dart';
import 'package:smart_ms3/widgets/provider_widget.dart';

const Color redColor = const Color(0xFFEA425C);
const Color lightRed = const Color(0xFFf2f2f2);
const Color navColor = const Color(0xFFffebef);

class ExerciseList extends StatelessWidget {
  final String injury;

  ExerciseList(this.injury);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('exercises')
          .document(injury)
          .collection('exerciseSets')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data == null)
          return Align(
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
                        padding: const EdgeInsets.only(top:8.0,bottom:8.0,left:32,right:32),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 100.0,
                              color: Colors.white,
                              child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Material(
                                      color: Colors.white,
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                width: 100.0,
                                                child: Image.network(
                                                    '${mypost['image']}',
                                                    fit: BoxFit.fill),
                                              ),
                                              SizedBox(
                                                width: 20.0,
                                              ),
                                              SizedBox(
                                                width: 100.0,
                                                child: AutoSizeText(
                                                  '${mypost['title']}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily:
                                                          'HelveticaNeue',
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.bold),
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

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/profile': (BuildContext context) => ProfileView(),
        '/goals': (BuildContext context) => CompletedGoalsPage(),
      },
      theme: ThemeData(primaryColor: redColor, accentColor: redColorAccent),
      home: HomepageScreen(),
    );
  }
}

class HomepageScreen extends StatefulWidget {
  @override
  _HomepageScreenState createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  String todoTitle = "";

  void createTodos() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    DocumentReference documentReference = Firestore.instance
        .collection("userData")
        .document(uid)
        .collection('goalList')
        .document(todoTitle);

    //Map
    Map<String, String> todos = {"todoTitle": todoTitle};

    documentReference.setData(todos).whenComplete(() {
      print("$todoTitle created");
    });
  }

  void createCompletedGoals(String goal) async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    DocumentReference documentReference = Firestore.instance
        .collection("userData")
        .document(uid)
        .collection('completedGoals')
        .document(goal);

    Map<String, String> todos = {"todoTitle": goal};

    documentReference.setData(todos).whenComplete(() {
      print("$todoTitle created");
    });
  }

  void deleteTodos(item) async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    DocumentReference documentReference = Firestore.instance
        .collection("userData")
        .document(uid)
        .collection('goalList')
        .document(item);

    documentReference.delete().whenComplete(() {
      print("$item deleted");
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0.0,
            height: height,
            left: 0.0,
            right: 0.0,
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                ),
                            onPressed: () {
                              setState(() {
                              });
                            },
                            color: Colors.white,
                            textColor: Colors.black,
                            child: Text("View all exercises",
                                style: TextStyle(
                                    fontSize: width * 0.046,
                                    fontFamily: 'HelveticaNeue',
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: height * 0.30,
                child: Padding(
                  padding: const EdgeInsets.only(left:16.0,right:16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                                    child: Container(
                      color: lightRed,
                      child: ExerciseList('Bursitis'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(
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
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                          ),
                          IconButton(
                            icon: Icon(Icons.add, color: Colors.white,),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      title: Text(
                                        "Add Goal",
                                        style: TextStyle(
                                            fontFamily: 'HelveticaNeue',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      content: TextField(
                                        onChanged: (String value) {
                                          todoTitle = value;
                                        },
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                            onPressed: () {
                                              createTodos();

                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "Add",
                                              style: TextStyle(
                                                  fontFamily: 'HelveticaNeue',
                                                  fontWeight: FontWeight.bold),
                                            ))
                                      ],
                                    );
                                  });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.check_box, color: Colors.white,),
                            onPressed: () {
                              Navigator.of(context).pushNamed('/goals');
                            },
                          ),
                        ],
                      ))),
                ],
              ),
            ),
            Expanded(
              child: goalList(),
            )
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
                  return Dismissible(
                      onDismissed: (direction) {
                        createCompletedGoals(documentSnapshot["todoTitle"]);
                        deleteTodos(documentSnapshot["todoTitle"]);
                      },
                      key: Key(documentSnapshot["todoTitle"]),
                      child: Card(
                        elevation: 0,
                        margin: EdgeInsets.only(
                            top: 8, bottom: 8, left: 32, right: 32),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: ListTile(
                          title: Text(
                            documentSnapshot["todoTitle"],
                            style: TextStyle(
                                fontFamily: 'HelveticaNeue',
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: IconButton(
                              icon: Icon(
                                Icons.check,
                                color: redColor,
                              ),
                              onPressed: () {
                                createCompletedGoals(
                                    documentSnapshot["todoTitle"]);
                                deleteTodos(documentSnapshot["todoTitle"]);
                              }),
                        ),
                      ));
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
        .collection('goalList')
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
