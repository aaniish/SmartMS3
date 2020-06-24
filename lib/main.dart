import 'package:flutter/material.dart';
import 'package:smart_ms3/pages/authentication/First_View.dart';
import 'package:smart_ms3/pages/navigation/bottom_navigation.dart';
import 'package:flutter/services.dart' ;
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
          return signedIn ? BottomBarNavigation() : FirstView();
        }
        return CircularProgressIndicator();
      },
    );
  }
}

