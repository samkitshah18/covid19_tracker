import 'package:covid19tracker/constants.dart';
import 'package:covid19tracker/screens/Country_screen.dart';
import 'package:covid19tracker/screens/States_cases.dart';
import 'package:covid19tracker/widgets/info_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Map worldData;

  fetchWorldWideData()async{
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData = json.decode(response.body);
    });

  }
  List countryData;

  fetchCountryData()async {
    http.Response response = await http.get(
        'https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchWorldWideData();
    fetchCountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: worldData == null
          ? Center(child: CircularProgressIndicator(),): SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding:
                EdgeInsets.only(left: 20, top: 20, right: 10, bottom: 40),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.03),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Wrap(
                  runSpacing: 20,
                  spacing: 10,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Worldwide',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryScreen()));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color:kPrimaryColor,
                                    borderRadius: BorderRadius.circular(9)
                                ),
                                padding: EdgeInsets.all(10.0),
                                child: Text(' All Countries',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),)
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>StateScreen()));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color:kPrimaryColor,
                                    borderRadius: BorderRadius.circular(9)
                                ),
                                padding: EdgeInsets.all(10.0),
                                child: Text('India',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),)
                            ),
                          ),
                        ],
                      ),
                    ),

                    InfoCard(
                      title: "Confirmed Cases",
                      iconColor: Color(0xFFFF8C00),
                      effectedNum: worldData['cases'],
                      press: () {},
                    ),
                    InfoCard(
                      title: "Total Deaths",
                      iconColor: Color(0xFFFF2D55),
                      effectedNum: worldData['deaths'],
                      press: () {},
                    ),
                    InfoCard(
                      title: "Total Recovered",
                      iconColor: Color(0xFF50E3C2),
                      effectedNum: worldData['recovered'],
                      press: () {},
                    ),
                    InfoCard(
                      title: "Active Cases",
                      iconColor: Color(0xFF5856D6),
                      effectedNum: worldData['active'],
                      press: (){
                        /*
                        dynamic result = await Navigator.pushNamed(context,'/location');
                        setState(() {
                          data={
                            'cured' : result['cured'],
                            'deaths' : result['deaths'],
                            'noOfCases' : result['noOfCases'],
                            'state' : result['state'],
                          };
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DetailsScreen();
                            },
                          ),
                        );*/
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Preventions",
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      buildPreventation(),
                      SizedBox(
                        height: 20,
                      ),
                      buildHelpCard(context),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


  Row buildPreventation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        PreventionCard(
          svgSrc: "assets/icons/hand_wash.svg",
          title: "Wash Hands",
        ),
        PreventionCard(
          svgSrc: "assets/icons/use_mask.svg",
          title: "Use Masks",
        ),
        PreventionCard(
          svgSrc: "assets/icons/Clean_Disinfect.svg",
          title: "Clean Disinfect",
        ),
      ],
    );
  }

  Container buildHelpCard(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * .4,
              top: 20,
              right: 20,
            ),
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF60BE93),
                  Color(0xFF1BBD59),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Dial 1075 for \nMedical Help\n",
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: Colors.white),
                  ),
                  TextSpan(
                    text: "If any Symptoms appear",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SvgPicture.asset(
              "assets/icons/nurse.svg",
              height: 120,
              width: 100,
            ),
          ),
          Positioned(
            top: 30,
            right: 10,
            child: SvgPicture.asset(
              "assets/icons/virus.svg",
              height: 40,
              width: 40,
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor.withOpacity(.03),
      elevation: 0,
      title: Center(
        child: Text(
          "Covid-19 Tracker",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 30,
          ),
        ),
      ),

      /*
      backgroundColor: kPrimaryColor.withOpacity(.03),
      elevation: 0,
      leading: IconButton(
          icon: SvgPicture.asset(
            "assets/icons/menu.svg",
            height: 20,
            width: 20,
          ),
          onPressed: () {}),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/search.svg",
            height: 20,
            width: 20,
          ),
          onPressed: () {},
        ),
      ],*/
    );
  }

class PreventionCard extends StatelessWidget {
  final String svgSrc;
  final String title;

  const PreventionCard({
    Key key,
    this.svgSrc,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SvgPicture.asset(
          svgSrc,
          height: 30,
          width: 30,
        ),
        Text(
          title,
          style:
              Theme.of(context).textTheme.body2.copyWith(color: kPrimaryColor),
        ),
      ],
    );
  }
}
