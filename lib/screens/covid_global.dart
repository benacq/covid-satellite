import 'package:covidapp/models/global_data_model.dart';
import 'package:covidapp/services/fetch_covid_data.dart';
import 'package:covidapp/widgets/global_case_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class CovidGlobal extends StatelessWidget {
  final NumberFormat f = new NumberFormat();

  String parseTime(int timestamp) {
    DateTime date =
        new DateTime.fromMillisecondsSinceEpoch(timestamp).toLocal();
    return date.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: FetchCovidData.covidGlobalScaffoldKey,
      body: LayoutBuilder(builder: (context, BoxConstraints constraints) {
        return FutureBuilder<CovidGlobalModel>(
            future: new FetchCovidData().covidGlobal,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return (Center(child: Text("Something went wrong")));
              }

              if (!snapshot.hasData) {
                return SpinKitChasingDots(
                  color: Color.fromRGBO(164, 52, 68, 1),
                  size: 50.0,
                );
              }
              CovidGlobalModel covidGlobalData = snapshot.data;
              return ListView(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 250, minHeight: 200),
                    child: Card(
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
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
                                  fontSize: 18,
                                  color: Color.fromRGBO(237, 139, 0, 1),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(
                            "${f.format(covidGlobalData.cases)}",
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
                                "${f.format(covidGlobalData.affectedCountries)} Countries",
                                style: TextStyle(
                                    // fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Color.fromRGBO(0, 0, 0, 0.4)),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Last Updated",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color.fromRGBO(0, 0, 0, 0.4)),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.clock,
                                      color: Color.fromRGBO(0, 0, 0, 0.4),
                                      size: 15,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "${parseTime(covidGlobalData.updated)}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color.fromRGBO(0, 0, 0, 0.4)),
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
                  // For smaller devices, card become small on smaller screen sizes which makes the texts overflow
                  constraints.maxWidth < 400
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GlobalCaseCard(
                              name: "Recoveries",
                              dataIcon: Icon(
                                FontAwesomeIcons.virusSlash,
                                color: Color.fromRGBO(60, 214, 152, 1),
                                size: 20,
                              ),
                              textColor: Color.fromRGBO(60, 214, 152, 1),
                              recordedValue: covidGlobalData.recovered,
                            ),
                            GlobalCaseCard(
                              name: "Active",
                              dataIcon: Icon(
                                FontAwesomeIcons.firstAid,
                                color: Color.fromRGBO(90, 141, 255, 1),
                                size: 20,
                              ),
                              textColor: Color.fromRGBO(90, 141, 255, 1),
                              recordedValue: covidGlobalData.active,
                            ),
                            Container(
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                    child: GlobalCaseCard(
                                      name: "Deaths",
                                      dataIcon: Icon(
                                        FontAwesomeIcons.heartbeat,
                                        color: Color.fromRGBO(255, 127, 127, 1),
                                        size: 20,
                                      ),
                                      textColor:
                                          Color.fromRGBO(255, 127, 127, 1),
                                      recordedValue: covidGlobalData.deaths,
                                    ),
                                  ),
                                  Expanded(
                                    child: GlobalCaseCard(
                                      name: "Critical",
                                      dataIcon: Icon(
                                        FontAwesomeIcons.ambulance,
                                        color: Color.fromRGBO(138, 21, 56, 1),
                                        size: 20,
                                      ),
                                      textColor: Color.fromRGBO(138, 21, 56, 1),
                                      recordedValue: covidGlobalData.critical,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                    child: GlobalCaseCard(
                                      name: "Deaths Today",
                                      dataIcon: Icon(
                                        FontAwesomeIcons.virusSlash,
                                        color: Color.fromRGBO(255, 127, 127, 1),
                                        size: 20,
                                      ),
                                      textColor:
                                          Color.fromRGBO(255, 127, 127, 1),
                                      recordedValue:
                                          covidGlobalData.todayDeaths,
                                    ),
                                  ),
                                  Expanded(
                                    child: GlobalCaseCard(
                                      name: "Cases Today",
                                      dataIcon: Icon(
                                        FontAwesomeIcons.thermometerHalf,
                                        color: Color.fromRGBO(237, 139, 0, 1),
                                        size: 20,
                                      ),
                                      textColor: Color.fromRGBO(237, 139, 0, 1),
                                      recordedValue: covidGlobalData.todayCases,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                    child: GlobalCaseCard(
                                      name: "Deaths",
                                      dataIcon: Icon(
                                        FontAwesomeIcons.heartbeat,
                                        color: Color.fromRGBO(255, 127, 127, 1),
                                        size: 20,
                                      ),
                                      textColor:
                                          Color.fromRGBO(255, 127, 127, 1),
                                      recordedValue: covidGlobalData.deaths,
                                    ),
                                  ),
                                  Expanded(
                                    child: GlobalCaseCard(
                                      name: "Recoveries",
                                      dataIcon: Icon(
                                        FontAwesomeIcons.virusSlash,
                                        color: Color.fromRGBO(60, 214, 152, 1),
                                        size: 20,
                                      ),
                                      textColor:
                                          Color.fromRGBO(60, 214, 152, 1),
                                      recordedValue: covidGlobalData.recovered,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                    child: GlobalCaseCard(
                                      name: "Active",
                                      dataIcon: Icon(
                                        FontAwesomeIcons.firstAid,
                                        color: Color.fromRGBO(90, 141, 255, 1),
                                        size: 20,
                                      ),
                                      textColor:
                                          Color.fromRGBO(90, 141, 255, 1),
                                      recordedValue: covidGlobalData.active,
                                    ),
                                  ),
                                  Expanded(
                                    child: GlobalCaseCard(
                                      name: "Critical",
                                      dataIcon: Icon(
                                        FontAwesomeIcons.ambulance,
                                        color: Color.fromRGBO(138, 21, 56, 1),
                                        size: 20,
                                      ),
                                      textColor: Color.fromRGBO(138, 21, 56, 1),
                                      recordedValue: covidGlobalData.critical,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                    child: GlobalCaseCard(
                                      name: "Deaths Today",
                                      dataIcon: Icon(
                                        FontAwesomeIcons.virusSlash,
                                        color: Color.fromRGBO(255, 127, 127, 1),
                                        size: 20,
                                      ),
                                      textColor:
                                          Color.fromRGBO(255, 127, 127, 1),
                                      recordedValue:
                                          covidGlobalData.todayDeaths,
                                    ),
                                  ),
                                  Expanded(
                                    child: GlobalCaseCard(
                                      name: "Cases Today",
                                      dataIcon: Icon(
                                        FontAwesomeIcons.thermometerHalf,
                                        color: Color.fromRGBO(237, 139, 0, 1),
                                        size: 20,
                                      ),
                                      textColor: Color.fromRGBO(237, 139, 0, 1),
                                      recordedValue: covidGlobalData.todayCases,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                ],
              );
            });
      }),
    );
  }
}
