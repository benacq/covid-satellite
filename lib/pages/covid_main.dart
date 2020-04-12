import 'dart:async';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covidapp/api/covid_requests.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CovidMainPage extends StatefulWidget {
  @override
  _CovidMainPageState createState() => _CovidMainPageState();
}

class _CovidMainPageState extends State<CovidMainPage> {
  NumberFormat f = new NumberFormat();
  

@override
void initState() {
    // TODO: implement initState
      }
    
      @override
      Widget build(BuildContext context) {
        CovidRequest covidGlobal = Provider.of<CovidRequest>(context);
        // print(covidGlobal.covidAll);
    
        return SafeArea(
          child: Container(
            child: StreamBuilder(
                stream: covidGlobal.covidAll.asStream(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  // return Center(child: Text("Global"));
                  if (snapshot.hasError) {
                    return (Center(child: Text("An error occured")));
                  }
                  // print(snapshot.data['cases']);
    
                  return !snapshot.hasData
                      ? SpinKitChasingDots(
                          color: Color.fromRGBO(164, 52, 68, 1),
                          size: 50.0,
                        )
                      : ListView(
                          children: <Widget>[
                            Container(
                              height: 200,
                              margin: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(237, 139, 0, 1),
                                border: Border.all(color: Colors.white, width: 2),
                                borderRadius: new BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Color.fromRGBO(0, 0, 0, 0.2),
                                //     blurRadius:
                                //         10.0, // has the effect of softening the shadow
                                //     spreadRadius:
                                //         -10.0, // has the effect of extending the shadow
                                //     offset: Offset(
                                //       10.0, // horizontal, move right 10
                                //       10.0, // vertical, move down 10
                                //     ),
                                //   )
                                // ],
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.bubble_chart,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          "Total Cases",
                                          style: TextStyle(
                                              // fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      f.format(snapshot.data['cases']),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 34,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.public,
                                          color: Color.fromRGBO(255, 255, 255, 0.6),
                                          size: 20,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          "${snapshot.data['affectedCountries']} Countries",
                                          style: TextStyle(
                                              // fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.6)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                                child: Flex(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              direction: Axis.horizontal,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    // padding: EdgeInsets.all(20),
                                    height: 100,
                                    color: Color.fromRGBO(255, 127, 127, 1),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              FontAwesomeIcons.heartbeat,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              "Deaths",
                                              style: TextStyle(
                                                  // fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Center(
                                          child: Text(
                                            f.format(snapshot.data['deaths']),
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 30),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Container(
                                    // padding: EdgeInsets.all(10),
                                    height: 100,
                                    color: Color.fromRGBO(60, 214, 152, 1),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              FontAwesomeIcons.virusSlash,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              "Recoveries",
                                              style: TextStyle(
                                                  // fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Center(
                                          child: Text(
                                            f.format(snapshot.data['recovered']),
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 30),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                            SizedBox(
                              height: 20,
                            ),
    
                            //SECOND FLEX
    
                            Container(
                                child: Flex(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              direction: Axis.horizontal,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    height: 100,
                                    color: Color.fromRGBO(90, 141, 255, 1),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              FontAwesomeIcons.firstAid,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              "Active",
                                              style: TextStyle(
                                                  // fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Center(
                                          child: Text(
                                            f.format(snapshot.data['active']),
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 30),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    height: 100,
                                    color: Color.fromRGBO(138, 21, 56, 1),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              FontAwesomeIcons.ambulance,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              "Critical",
                                              style: TextStyle(
                                                  // fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Center(
                                          child: Text(
                                            f.format(snapshot.data['critical']),
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 30),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
    
                            //THIRD FLEX
                            SizedBox(
                              height: 20,
                            ),
    
                            Container(
                                child: Flex(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              direction: Axis.horizontal,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    height: 100,
                                    color: Color.fromRGBO(255, 127, 127, 1),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Center(
                                          child: Text(
                                            f.format(snapshot.data['todayDeaths']),
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 30),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Center(
                                          child: Text(
                                            "Deaths Today",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 18),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    height: 100,
                                    color: Color.fromRGBO(237, 139, 0, 1),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Center(
                                          child: Text(
                                            f.format(snapshot.data['todayCases']),
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 30),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Center(
                                          child: Text(
                                            "Cases Today",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 18),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                            ),
                          ],
                        );
                }),
          ),
        );
      }
    
  
}
