import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class Cases{

  //{"cured":33,"deaths":0,"noOfCases":33,"state":"Andaman and Nicobar Islands"}
  int cured ;
  int deaths ;
  int noOfCases ;
  String state;

  Cases();

  Future<void> getCases() async {

    try{
      Response response = await get('https://covid-india-cases.herokuapp.com/states/');
      Map data = jsonDecode(response.body);
    }
    catch(e){
      print('Caught error : $e');
      state = 'Could not get time , Sorry !';
    }



  }

}

