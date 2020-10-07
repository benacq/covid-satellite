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
    double width = MediaQuery.of(context).size.width;
    // print(covidGlobal.covidAll);

    return SafeArea(
      maintainBottomViewPadding: true,
      child: Container(
        child: StreamBuilder(
            stream: covidGlobal.covidAll.asStream(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // return Center(child: Text("Global"));
              if (snapshot.hasError) {
                return (Center(child: Text("An error occured")));
              }

              if (!snapshot.hasData) {
                return SpinKitChasingDots(
                  color: Color.fromRGBO(164, 52, 68, 1),
                  size: 50.0,
                );
              } else {
                return ListView(
                  children: <Widget>[
//------------------------------------------         ------------------------------------------//

                    Container(
                      height: 200,
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        // color: Color.fromRGBO(237, 139, 0, 1),
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: new BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      child: Card(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.bubble_chart,
                                    color: Color.fromRGBO(237, 139, 0, 1),
                                    size: 40,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Total Cases",
                                    style: TextStyle(
                                      // fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Color.fromRGBO(237, 139, 0, 1),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Text(
                                f.format(snapshot.data['cases']),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 34,
                                  color: Color.fromRGBO(237, 139, 0, 1),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.public,
                                    color: Color.fromRGBO(0, 0, 0, 0.4),
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "${snapshot.data['affectedCountries']} Countries",
                                    style: TextStyle(
                                        // fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Color.fromRGBO(0, 0, 0, 0.4)),
                                  ),
                                ],
                              ),

// SizedBox(height: 10),

                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Last Updated",
                                          // "${snapshot.data['updated']} Countries",
                                          style: TextStyle(
                                              // fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.4)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.clock,
                                          color: Color.fromRGBO(0, 0, 0, 0.4),
                                          size: 15,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          lastUpdated(snapshot.data['updated']),
                                          // "${snapshot.data['updated']} Countries",
                                          style: TextStyle(
                                              // fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.4)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
////////////////////////////////////////////////////
///////////////////////////////////////////////////
                    (width < 400)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 20),
                                child: Card(
                                  elevation: 8,
                                  shadowColor: Colors.white,
                                  child: Container(
                                    // padding: EdgeInsets.all(10),
                                    height: 100,
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              FontAwesomeIcons.virusSlash,
                                              color: Color.fromRGBO(
                                                  60, 214, 152, 1),
                                              size: 20,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              "Recoveries",
                                              style: TextStyle(
                                                  // fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                  color: Color.fromRGBO(
                                                      60, 214, 152, 1)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Center(
                                          child: Text(
                                            f.format(
                                                snapshot.data['recovered']),
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    60, 214, 152, 1),
                                                fontSize: 30),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 20),
                                child: Card(
                                  elevation: 8,
                                  shadowColor: Colors.white,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    height: 100,
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              FontAwesomeIcons.firstAid,
                                              color: Color.fromRGBO(
                                                  90, 141, 255, 1),
                                              size: 20,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              "Active",
                                              style: TextStyle(
                                                  // fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                  color: Color.fromRGBO(
                                                      90, 141, 255, 1)),
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
                                                color: Color.fromRGBO(
                                                    90, 141, 255, 1),
                                                fontSize: 30),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  child: Flex(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    direction: Axis.horizontal,
                                    children: <Widget>[
                                      Expanded(
                                        child: Card(
                                          shadowColor: Colors.white,
                                          elevation: 8,
                                          child: Container(
                                            height: 100,
                                            // color: Colors.white,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .heartbeat,
                                                      color: Color.fromRGBO(
                                                          255, 127, 127, 1),
                                                      size: 20,
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      "Deaths",
                                                      style: TextStyle(
                                                          // fontWeight: FontWeight.w600,
                                                          fontSize: 18,
                                                          color: Color.fromRGBO(
                                                              255,
                                                              127,
                                                              127,
                                                              1)),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Center(
                                                  child: Text(
                                                    f.format(snapshot
                                                        .data['deaths']),
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            255, 127, 127, 1),
                                                        fontSize: 30),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Card(
                                          elevation: 8,
                                          shadowColor: Colors.white,
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            height: 100,
                                            color: Colors.white,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .ambulance,
                                                      color: Color.fromRGBO(
                                                          138, 21, 56, 1),
                                                      size: 18,
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      "Critical",
                                                      style: TextStyle(
                                                          // fontWeight: FontWeight.w600,
                                                          fontSize: 18,
                                                          color: Color.fromRGBO(
                                                              138, 21, 56, 1)),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Center(
                                                  child: Text(
                                                    f.format(snapshot
                                                        .data['critical']),
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            138, 21, 56, 1),
                                                        fontSize: 30),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  child: Flex(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    direction: Axis.horizontal,
                                    children: <Widget>[
                                      Expanded(
                                        child: Card(
                                          elevation: 8,
                                          shadowColor: Colors.white,
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            height: 100,
                                            color: Colors.white,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Center(
                                                  child: Text(
                                                    f.format(snapshot
                                                        .data['todayDeaths']),
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            255, 127, 127, 1),
                                                        fontSize: 30),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Center(
                                                  child: Text(
                                                    "Deaths Today",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            255, 127, 127, 1),
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Card(
                                          elevation: 8,
                                          shadowColor: Colors.white,
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            height: 100,
                                            color: Colors.white,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Center(
                                                  child: Text(
                                                    f.format(snapshot
                                                        .data['todayCases']),
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            237, 139, 0, 1),
                                                        fontSize: 30),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Center(
                                                  child: Text(
                                                    "Cases Today",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            237, 139, 0, 1),
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          )
                        :
/////////////////////////////////////////////////
/////////////////////////////////////////////////
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  child: Flex(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    direction: Axis.horizontal,
                                    children: <Widget>[
                                      Expanded(
                                        child: Card(
                                          shadowColor: Colors.white,
                                          elevation: 8,
                                          child: Container(
                                            height: 100,
                                            // color: Colors.white,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .heartbeat,
                                                      color: Color.fromRGBO(
                                                          255, 127, 127, 1),
                                                      size: 20,
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      "Deaths",
                                                      style: TextStyle(
                                                          // fontWeight: FontWeight.w600,
                                                          fontSize: 18,
                                                          color: Color.fromRGBO(
                                                              255,
                                                              127,
                                                              127,
                                                              1)),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Center(
                                                  child: Text(
                                                    f.format(snapshot
                                                        .data['deaths']),
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            255, 127, 127, 1),
                                                        fontSize: 30),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Card(
                                          elevation: 8,
                                          shadowColor: Colors.white,
                                          child: Container(
                                            // padding: EdgeInsets.all(10),
                                            height: 100,
                                            color: Colors.white,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .virusSlash,
                                                      color: Color.fromRGBO(
                                                          60, 214, 152, 1),
                                                      size: 20,
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      "Recoveries",
                                                      style: TextStyle(
                                                          // fontWeight: FontWeight.w600,
                                                          fontSize: 18,
                                                          color: Color.fromRGBO(
                                                              60, 214, 152, 1)),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Center(
                                                  child: Text(
                                                    f.format(snapshot
                                                        .data['recovered']),
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            60, 214, 152, 1),
                                                        fontSize: 30),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: 20,
                              ),

                              Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  child: Flex(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    direction: Axis.horizontal,
                                    children: <Widget>[
                                      Expanded(
                                        child: Card(
                                          elevation: 8,
                                          shadowColor: Colors.white,
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            height: 100,
                                            color: Colors.white,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Icon(
                                                      FontAwesomeIcons.firstAid,
                                                      color: Color.fromRGBO(
                                                          90, 141, 255, 1),
                                                      size: 20,
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      "Active",
                                                      style: TextStyle(
                                                          // fontWeight: FontWeight.w600,
                                                          fontSize: 18,
                                                          color: Color.fromRGBO(
                                                              90, 141, 255, 1)),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Center(
                                                  child: Text(
                                                    f.format(snapshot
                                                        .data['active']),
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            90, 141, 255, 1),
                                                        fontSize: 30),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Card(
                                          elevation: 8,
                                          shadowColor: Colors.white,
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            height: 100,
                                            color: Colors.white,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .ambulance,
                                                      color: Color.fromRGBO(
                                                          138, 21, 56, 1),
                                                      size: 18,
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      "Critical",
                                                      style: TextStyle(
                                                          // fontWeight: FontWeight.w600,
                                                          fontSize: 18,
                                                          color: Color.fromRGBO(
                                                              138, 21, 56, 1)),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Center(
                                                  child: Text(
                                                    f.format(snapshot
                                                        .data['critical']),
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            138, 21, 56, 1),
                                                        fontSize: 30),
                                                  ),
                                                ),
                                              ],
                                            ),
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
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  child: Flex(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    direction: Axis.horizontal,
                                    children: <Widget>[
                                      Expanded(
                                        child: Card(
                                          elevation: 8,
                                          shadowColor: Colors.white,
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            height: 100,
                                            color: Colors.white,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Center(
                                                  child: Text(
                                                    f.format(snapshot
                                                        .data['todayDeaths']),
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            255, 127, 127, 1),
                                                        fontSize: 30),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Center(
                                                  child: Text(
                                                    "Deaths Today",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            255, 127, 127, 1),
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Card(
                                          elevation: 8,
                                          shadowColor: Colors.white,
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            height: 100,
                                            color: Colors.white,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Center(
                                                  child: Text(
                                                    f.format(snapshot
                                                        .data['todayCases']),
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            237, 139, 0, 1),
                                                        fontSize: 30),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Center(
                                                  child: Text(
                                                    "Cases Today",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            237, 139, 0, 1),
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          )
                  ],
                );
              }
            }),
      ),
    );
  }

  Widget _snackBar() => SnackBar(
        content: Text(
          "You have a message!",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        // backgroundColor: BLUE_LIGHT,
      );

  String lastUpdated(int timestamp) {
    DateTime date =
        new DateTime.fromMillisecondsSinceEpoch(timestamp).toLocal();
    return date.toString();
  }
}
