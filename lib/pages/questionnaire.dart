import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_ms3/pages/navigation/bottom_navigation.dart';
import 'package:smart_ms3/widgets/provider_widget.dart';

const Color redColor = const Color(0xFFfcbbc5);
const Color redColor2 = const Color(0xFFEA425C);

class QuestionPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: redColor2),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => BottomBarNavigation(),
      },
      home: QuestionPage(),
    );
  }
}

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key key}) : super(key: key);
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  var _formKey = GlobalKey<FormState>();
  String genderValue = 'male';
  final gender = ['male', 'female'];
  TextEditingController name = new TextEditingController();
  TextEditingController age = new TextEditingController();
  @override
  final databaseReference = Firestore.instance;

  void createRecord() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    await databaseReference
        .collection("userData")
        .document(uid)
        .collection("userInfo")
        .add({'Name': name.text, 'Gender': genderValue, 'Age': age.text});
  }

  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Container(
              height: height,
              color: redColor,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  _AppBar(),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.error_outline,
                          color: Colors.white,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Text(
                              "If already completed click, exit this page",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'HelveticaNeue',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  textInput(name, "Name", "Full Name"),
                  textInput(age, "Age", "Age"),
                  dropDown(gender, genderValue, "gender"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                        color: Colors.white,
                        onPressed: () {
                          if (!_formKey.currentState.validate()) {
                            return;
                          }

                          _formKey.currentState.save();
                          createRecord();
                          Navigator.of(context).pushNamed('/home');
                        },
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              fontFamily: 'HelveticaNeue',
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )),
                  )
                ],
              ),
            )),
      ),
    );
  }

  Widget dropDown(List<String> values, String dropState, String purpose) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: DropdownButtonFormField(
        value: dropState,
        icon: Icon(Icons.arrow_downward),
        decoration: InputDecoration(
          labelText: "Select $purpose",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        items: values.map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: new Text(value),
          );
        }).toList(),
        onChanged: (String newValue) {
          setState(() {
            dropState = newValue;
          });
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Select $purpose';
          }
          return null;
        },
      ),
    );
  }

  Widget textInput(answer, String purpose, String hint) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: TextFormField(
        validator: (String value) {
          if (value.isEmpty) {
            return 'Please enter $purpose';
          }
        },
        controller: answer,
        decoration: InputDecoration(
          focusColor: Colors.white,
          labelText: purpose,
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
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
            "Questionnaire",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'HelveticaNeue',
                fontSize: 40,
                fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/home');
            },
          ),
        ],
      ),
    );
  }
}
