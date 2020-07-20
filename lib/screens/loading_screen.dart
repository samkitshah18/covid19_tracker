import 'package:covid19tracker/screens/Cases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setupNoOfCases() async {

    //{"cured":33,"deaths":0,"noOfCases":33,"state":"Andaman and Nicobar Islands"}
    Cases instance = Cases();
    await instance.getCases();
    Navigator.pushReplacementNamed(context,'/home',arguments: {
      'cured': instance.cured,
      'noOfCases': instance.noOfCases,
      'state'  : instance.state,
      'deaths' : instance.deaths,
    });

  }

  @override
  void initState() {
    super.initState();
    setupNoOfCases();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 80.0,
        ),
      ),
    );
  }
}
