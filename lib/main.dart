import 'package:covid19tracker/screens/home_screen.dart';
import 'package:covid19tracker/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:covid19tracker/constants.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /*return MaterialApp(
    initialRoute: '/',

    routes: {
    '/':(context) => Loading() ,
    '/home':(context) => HomeScreen() ,
    //'/location':(context) => ChooseLocation()

    },
    );*/
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid-19 App',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),
      ),
      home: HomeScreen(),
    );
  }
}


