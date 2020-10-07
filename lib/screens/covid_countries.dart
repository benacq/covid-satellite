import 'dart:async';
import 'package:covidapp/models/countries_data_model.dart';
import 'package:covidapp/services/fetch_covid_data.dart';
import 'package:covidapp/widgets/covid_country_data_cols.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class CovidCountries extends StatefulWidget {
  @override
  _CovidCountriesState createState() => _CovidCountriesState();
}

class _CovidCountriesState extends State<CovidCountries> {
  List<charts.Series<Set, String>> _covidChartData;
  int selectedCountryIndex = 0;
  Timer timer;
  NumberFormat f = new NumberFormat();
  List<String> countries;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: FetchCovidData.covidCountriesScaffoldKey,
      backgroundColor: Color.fromRGBO(241, 241, 241, 1),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return FutureBuilder<List<CovidCountriesModel>>(
              future: new FetchCovidData().covidCountries,
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

                List<CovidCountriesModel> covidCountriesData = snapshot.data;
                countries = covidCountriesData.map((e) => e.country).toList();
                _covidChartData = List<charts.Series<Set, String>>();
                generateChart(covidCountriesData[selectedCountryIndex]);
                return ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            constraints: BoxConstraints(
                                maxHeight: 100,
                                maxWidth: 150,
                                minHeight: 80,
                                minWidth: 120),
                            child: Image.network(
                                covidCountriesData[selectedCountryIndex].flag))
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      alignment: Alignment.topCenter,
                      child: new DropdownButton(
                        isExpanded: true,
                        value: countries[selectedCountryIndex],
                        items: countries.map((String country) {
                          return DropdownMenuItem<String>(
                            value: country,
                            child: Text(country),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCountryIndex = countries.indexOf(value);
                            generateChart(
                                covidCountriesData[selectedCountryIndex]);
                          });
                        },
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
                            dataCount:
                                covidCountriesData[selectedCountryIndex].cases,
                          ),
                        ),
                        Expanded(
                          child: CountriesDataView(
                            color: Color.fromRGBO(255, 127, 127, 1),
                            name: "Deaths",
                            dataCount:
                                covidCountriesData[selectedCountryIndex].deaths,
                          ),
                        ),
                        Expanded(
                          child: CountriesDataView(
                            color: Color.fromRGBO(60, 214, 152, 1),
                            name: "Recoveries",
                            dataCount: covidCountriesData[selectedCountryIndex]
                                .recovered,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Flex(
                      mainAxisAlignment: MainAxisAlignment.center,
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          child: CountriesDataView(
                            color: Color.fromRGBO(237, 139, 0, 1),
                            name: "Cases Today",
                            dataCount: covidCountriesData[selectedCountryIndex]
                                .todayCases,
                          ),
                        ),
                        Expanded(
                          child: CountriesDataView(
                            color: Color.fromRGBO(255, 127, 127, 1),
                            name: "Deaths Today",
                            dataCount: covidCountriesData[selectedCountryIndex]
                                .todayDeaths,
                          ),
                        ),
                        Expanded(
                          child: CountriesDataView(
                            color: Color.fromRGBO(138, 21, 56, 1),
                            name: "Critical",
                            dataCount: covidCountriesData[selectedCountryIndex]
                                .critical,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _covidChartData == null
                        ? Text(
                            "null chart",
                            textAlign: TextAlign.center,
                          )
                        : SizedBox(
                            height: 300,
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Container(
                                child: charts.PieChart(
                                  _covidChartData,
                                  animate: true,
                                  animationDuration: Duration(seconds: 5),
                                  behaviors: [
                                    new charts.DatumLegend(
                                        outsideJustification: charts
                                            .OutsideJustification.endDrawArea,
                                        horizontalFirst: true,
                                        desiredMaxRows: 2,
                                        cellPadding: new EdgeInsets.only(
                                            right: 4, bottom: 4),
                                        entryTextStyle: charts.TextStyleSpec(
                                            color: charts.MaterialPalette.purple
                                                .shadeDefault,
                                            fontSize: 11))
                                  ],
                                ),
                              ),
                            ),
                          )
                  ],
                );
              });
        },
      ),
    );
  }

  ///****************************************************************************************/
  /// DRAW CHART
  ///*****************************************************************************************/
  void generateChart(CovidCountriesModel covidDataModel) {
    List<Set<dynamic>> countryPieData = [
      Set.from(["Cases", covidDataModel.cases, Color.fromRGBO(237, 139, 0, 1)]),
      Set.from(["Deaths", covidDataModel.deaths, Colors.red]),
      Set.from([
        "Critical",
        covidDataModel.critical,
        Color.fromRGBO(138, 21, 56, 1)
      ]),
      Set.from(["Recoveries", covidDataModel.recovered, Colors.green])
    ];

    _covidChartData.add(charts.Series(
        data: countryPieData,
        domainFn: (Set data, _) => data.toList()[0],
        measureFn: (Set data, _) => data.toList()[1],
        colorFn: (Set data, _) =>
            charts.ColorUtil.fromDartColor(data.toList()[2]),
        id: "Covid-19 Status",
        labelAccessorFn: (Set row, _) => '${row.toList()[1]}'));
  }
}
