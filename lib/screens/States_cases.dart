import 'package:covid19tracker/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

class StateScreen extends StatefulWidget {
  @override
  _StateScreenState createState() => _StateScreenState();
}

class _StateScreenState extends State<StateScreen> {

  Map stateData;

  fetchStateData() async {
    http.Response response = await http.get(
        //'https://covid-india-cases.herokuapp.com/states'
        //'https://disease.sh/v2/gov/india'
      'https://api.covid19india.org/data.json'
    );
    setState(() {
      stateData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchStateData();
    super.initState();
  }
  //{"cured":33,"deaths":0,"noOfCases":33,"state":"Andaman and Nicobar Islands"}
  @override
  Widget build(BuildContext context) {
    debugPrint(stateData.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text('Statewise Stats'),
      ),
      body: stateData == null
          ? Center(child: CircularProgressIndicator(),)
          : ListView.builder(itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(
              color: kInactiveChartColor,
            ),
            ],
          ),
          child: Card(
            color:kBackgroundColor,
            //shadowColor: Theme.of(context).brightness==Brightness.dark?(Colors.grey[600]):(Colors.black12),
            child: Container(
              height: 130,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 180,
                    margin: EdgeInsets.symmetric(horizontal: 10,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            text:TextSpan(
                              text:stateData['statewise'][index]['state'],
                                style: TextStyle(fontWeight: FontWeight.bold,
                                color: Colors.black87),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'CONFIRMED:' + stateData['statewise'][index]['confirmed'].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red),),
                        Text('RECOVERED:' +
                            stateData['statewise'][index]['recovered'].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green[700]),),
                        Text(
                          'DEATHS:' + stateData['statewise'][index]['deaths'].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme
                                  .of(context)
                                  .brightness == Brightness.dark ? Colors
                                  .grey[100] : Colors.grey[700]),),

                      ],
                    ),


                  ),)


                ],
              ),
            ),
          ),
        );
      },
        itemCount: stateData == null ? 0 : stateData['statewise'].length,
      ),
    );
  }
}


