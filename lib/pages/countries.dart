import 'dart:async';

import 'package:covidapp/api/covid_requests.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CovidCountryView extends StatefulWidget {
  @override
  _CovidCountryViewState createState() => _CovidCountryViewState();
}

class _CovidCountryViewState extends State<CovidCountryView> {
  List<charts.Series<Set, String>> _covidPieData;
  int selectedCountryIndex = 0;
  List _infectedCountries;
  Timer timer;
  NumberFormat f = new NumberFormat();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CovidRequest covidCountries = Provider.of<CovidRequest>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(241, 241, 241, 1),
        body: StreamBuilder(
            stream: covidCountries.covidCountryStream.stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                _covidPieData = List<charts.Series<Set, String>>();
                _infectedCountries = snapshot.data;
                generateData(snapshot.data[selectedCountryIndex]);
              }
              return !snapshot.hasData
                  ? SpinKitChasingDots(
                      color: Color.fromRGBO(164, 52, 68, 1),
                      size: 50.0,
                    )
                  : ListView(
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
                              // color: Colors.red,
                              child: Image.network(
                                  _infectedCountries[selectedCountryIndex]
                                      ['countryInfo']['flag']),
                            ),
                          ],
                        ),
                        Container(
                          // color: Colors.red,
                          margin: EdgeInsets.all(20),
                          alignment: Alignment.topCenter,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectedCountryIndex == null
                                ? null
                                : dropDownList(
                                    snapshot.data)[selectedCountryIndex],
                            items:
                                dropDownList(snapshot.data).map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              selectedCountryIndex =
                                  dropDownList(snapshot.data).indexOf(value);
                              if (mounted) {
                                setState(() {
                                  generateData(
                                      snapshot.data[selectedCountryIndex]);
                                });
                              }
                            },
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        _flexThreeCols(
                            _infectedCountries,
                            selectedCountryIndex,
                            _infectedCountries[selectedCountryIndex]['cases'],
                            _infectedCountries[selectedCountryIndex]['deaths'],
                            _infectedCountries[selectedCountryIndex]
                                ['recovered'],
                            "Cases",
                            "Deaths",
                            "Recoveries",
                            Color.fromRGBO(60, 214, 152, 1)),
                        SizedBox(
                          height: 20,
                        ),
                        _flexThreeCols(
                          _infectedCountries,
                          selectedCountryIndex,
                          _infectedCountries[selectedCountryIndex]
                              ['todayCases'],
                          _infectedCountries[selectedCountryIndex]
                              ['todayDeaths'],
                          _infectedCountries[selectedCountryIndex]['critical'],
                          "Cases Today",
                          "Deaths Today",
                          "Critical",
                          Color.fromRGBO(138, 21, 56, 1),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        _covidPieData == null
                            ? Text("VALUE NULL")
                            : SizedBox(
                                height: 300,
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Container(
                                    child: charts.PieChart(
                                      _covidPieData,
                                      animate: true,
                                      animationDuration: Duration(seconds: 5),
                                      behaviors: [
                                        new charts.DatumLegend(
                                            outsideJustification: charts
                                                .OutsideJustification
                                                .endDrawArea,
                                            horizontalFirst: true,
                                            desiredMaxRows: 2,
                                            cellPadding: new EdgeInsets.only(
                                                right: 4, bottom: 4),
                                            entryTextStyle:
                                                charts.TextStyleSpec(
                                                    color: charts
                                                        .MaterialPalette
                                                        .purple
                                                        .shadeDefault,
                                                    fontSize: 11))
                                      ],
                                      // defaultRenderer:
                                      //      charts.ArcRendererConfig(
                                      //         arcWidth: 80,
                                      //         arcRendererDecorators: [
                                      //        charts.ArcLabelDecorator(
                                      //           labelPosition: charts
                                      //               .ArcLabelPosition.inside)
                                      //     ]
                                      //     ),
                                    ),
                                  ),
                                ),
                              )
                      ],
                    );
            }),
      ),
    );
  }

  List<String> dropDownList(List countryList) {
    List<String> itemList = [];
    if (countryList != null) {
      for (var i = 0; i < countryList.length; i++) {
        itemList.add("${countryList[i]['country']}");
      }
    }
    return itemList..sort();
  }

  void generateData([Map covidData]) {
    List<Set<dynamic>> countryPieData = [
      Set.from(["Cases", covidData['cases'], Color.fromRGBO(237, 139, 0, 1)]),
      Set.from(["Deaths", covidData['deaths'], Colors.red]),
      Set.from(["Critical", covidData['critical'], Color.fromRGBO(138, 21, 56, 1)]),
      Set.from(["Recoveries", covidData['recovered'], Colors.green])
    ];

    _covidPieData.add(charts.Series(
        data: countryPieData,
        domainFn: (Set data, _) => data.toList()[0],
        measureFn: (Set data, _) => data.toList()[1],
        colorFn: (Set data, _) =>
            charts.ColorUtil.fromDartColor(data.toList()[2]),
        id: "Data Test",
        labelAccessorFn: (Set row, _) => '${row.toList()[1]}'));
  }

  ///FLEX WIDGET
  Widget _flexThreeCols(
      List dataList,
      int index,
      int cases,
      int deaths,
      int recoveryCritical,
      String caseString,
      String deathString,
      String criticalRecover,
      Color colorCriticalRecover) {
    NumberFormat f = new NumberFormat();
    return Flex(
      mainAxisAlignment: MainAxisAlignment.center,
      direction: Axis.horizontal,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10),
            height: 70,
            // color: Color.fromRGBO(237, 139, 0, 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    f.format(cases),
                    style: TextStyle(
                        color: Color.fromRGBO(237, 139, 0, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    caseString,
                    style: TextStyle(
                        color: Color.fromRGBO(237, 139, 0, 1), fontSize: 15),
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
            height: 70,
            // color: Color.fromRGBO(255, 127, 127, 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    f.format(deaths),
                    style: TextStyle(
                        color: Color.fromRGBO(255, 127, 127, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    deathString,
                    style: TextStyle(
                        color: Color.fromRGBO(255, 127, 127, 1), fontSize: 15),
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
            height: 70,
            // color: Color.fromRGBO(237, 139, 0, 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    f.format(recoveryCritical),
                    style: TextStyle(
                        color: colorCriticalRecover,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    criticalRecover,
                    style: TextStyle(color: colorCriticalRecover, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
