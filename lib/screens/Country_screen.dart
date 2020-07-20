import 'package:covid19tracker/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

class CountryScreen extends StatefulWidget {
  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {

  List countryData;

  fetchCountryData() async {
    http.Response response = await http.get(
        'https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

    @override
    void initState() {
      fetchCountryData();
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country Stats'),
      ),
      body: countryData == null
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
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(countryData[index]['country'],
                          style: TextStyle(fontWeight: FontWeight.bold),),
                        Image.network(countryData[index]['countryInfo']['flag'],
                          height: 50.0, width: 60,)
                      ],
                    ),
                  ),
                  Expanded(child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'CONFIRMED:' + countryData[index]['cases'].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red),),
                        Text(
                          'ACTIVE:' + countryData[index]['active'].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),),
                        Text('RECOVERED:' +
                            countryData[index]['recovered'].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green[700]),),
                        Text(
                          'DEATHS:' + countryData[index]['deaths'].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme
                                  .of(context)
                                  .brightness == Brightness.dark ? Colors
                                  .grey[100] : Colors.grey[700]),),
                        Text('CASES PER TEN LAKH CITIZENS:' +
                            countryData[index]['casesPerOneMillion'].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange),),

                      ],
                    ),


                  ),)


                ],
              ),
            ),
          ),
        );
      },
        itemCount: countryData == null ? 0 : countryData.length,
      ),
    );
  }
}
