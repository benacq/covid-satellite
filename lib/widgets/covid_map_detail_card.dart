import 'package:covidapp/models/countries_data_model.dart';
import 'package:covidapp/widgets/covid_country_data_cols.dart';
import 'package:flutter/material.dart';

class CovidMapDetailCard extends StatelessWidget {
  final CovidCountriesModel covidModel;
  final int indexTapped;
  CovidMapDetailCard({@required this.covidModel, @required this.indexTapped});
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              widthFactor: 0.85,
              child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(244, 244, 244, 1),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(10),
                  height: 300,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              width: 80,
                              color: Colors.red,
                              constraints:
                                  BoxConstraints(maxHeight: 80, maxWidth: 120),
                              child: Container(
                                child: Image.network(covidModel.flag),
                              )),
                        ],
                      ),
                      SizedBox(height: 4),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              covidModel.country.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Flex(
                        mainAxisAlignment: MainAxisAlignment.center,
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                            child: CountriesDataView(
                              color: Color.fromRGBO(237, 139, 0, 1),
                              name: "Cases",
                              dataCount: covidModel.cases,
                            ),
                          ),
                          Expanded(
                            child: CountriesDataView(
                              color: Color.fromRGBO(255, 127, 127, 1),
                              name: "Deaths",
                              dataCount: covidModel.deaths,
                            ),
                          ),
                          Expanded(
                            child: CountriesDataView(
                              color: Color.fromRGBO(60, 214, 152, 1),
                              name: "Recoveries",
                              dataCount: covidModel.recovered,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Flex(
                        mainAxisAlignment: MainAxisAlignment.center,
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                            child: CountriesDataView(
                              color: Color.fromRGBO(237, 139, 0, 1),
                              name: "Cases Today",
                              dataCount: covidModel.todayCases,
                            ),
                          ),
                          Expanded(
                            child: CountriesDataView(
                              color: Color.fromRGBO(255, 127, 127, 1),
                              name: "Deaths Today",
                              dataCount: covidModel.todayDeaths,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            )));
  }
}
