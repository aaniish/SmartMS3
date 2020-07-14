import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:smart_ms3/pages/authentication/First_View.dart';
import 'package:smart_ms3/pages/navigation/bottom_navigation.dart';
import 'package:flutter/services.dart' ;
import 'package:smart_ms3/pages/questionnaire.dart';
import 'package:smart_ms3/services/auth_service.dart';
import 'package:smart_ms3/widgets/provider_widget.dart';
import 'package:smart_ms3/pages/authentication/sign_up_view.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
     return Provider(
      auth: AuthService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Smart MS3",
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: HomeController(),
        routes: <String, WidgetBuilder>{
          '/signUp': (BuildContext context) => SignUpView(authFormType: AuthFormType.signUp),
          '/signIn': (BuildContext context) => SignUpView(authFormType: AuthFormType.signIn),
          '/home': (BuildContext context) => HomeController(),
        },
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? QuestionnaireController() : FirstView();
        }
        return CircularProgressIndicator();
      },
    );
  }

  
  Widget displayUserInformation(context, snapshot) {
    final user = snapshot.data;
    if(user.metadata.creationTime==user.metadata.lastSignInTime) {
      return QuestionPageScreen();
    } else {
      return BottomBarNavigation();
    }
  }
}

class QuestionnaireController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
              future: Provider.of(context).auth.getCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return displayUserInformation(context, snapshot);
                } else {
                  return CircularProgressIndicator();
                }
              },
            );
  }
Widget displayUserInformation(context, snapshot) {
    final user = snapshot.data;
    if(user.metadata.creationTime==user.metadata.lastSignInTime) {
      return QuestionPageScreen();
    } else {
      return BottomBarNavigation();
    }
  }
}