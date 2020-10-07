import 'package:covidapp/model/countries_data_model.dart';
import 'package:covidapp/model/global_data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class FetchCovidData {
  static final GlobalKey<ScaffoldState> covidGlobalScaffoldKey =
      new GlobalKey<ScaffoldState>();

  static final GlobalKey<ScaffoldState> covidCountriesScaffoldKey =
      new GlobalKey<ScaffoldState>();

  final snackBar = (errorMsg, Color color) => SnackBar(
        backgroundColor: color,
        content: Text(errorMsg),
      );

  ///****************************************************************************************/
  /// FETCH CORONA GLOBAL DATA
  ///*****************************************************************************************/
  Future<CovidGlobalModel> get covidGlobal async {
    String url = "https://corona.lmao.ninja/v2/all";
    return await http
        .get(url)
        .then((res) async {
          assert(res != null);
          if (res.statusCode == 200) {
            Map<String, dynamic> data = convert.jsonDecode(res.body);
            return CovidGlobalModel.fromJson(data);
          } else {
            print('Request failed with status: ${res.statusCode}.');
            covidGlobalScaffoldKey.currentState.showSnackBar(snackBar(
                "${res.statusCode}: Error getting data",
                Color.fromARGB(230, 98, 91, 1)));
          }
        })
        .catchError((onError) => covidGlobalScaffoldKey.currentState
            .showSnackBar(snackBar(
                "Unable to get data, please check your connection",
                Color.fromARGB(230, 98, 91, 1))))
        // ignore: missing_return
        .timeout(Duration(seconds: 8), onTimeout: () {
          covidGlobalScaffoldKey.currentState.showSnackBar(
              snackBar("Request timeout", Color.fromARGB(126, 24, 60, 1)));
        });
  }

  ///****************************************************************************************/
  /// FETCH CORONA STATS BY COUNTRY
  ///*****************************************************************************************/
  Future<List<CovidCountriesModel>> get covidCountries async {
    String url = "https://corona.lmao.ninja/v2/countries";
    return await http
        .get(url)
        .then((res) async {
          assert(res != null);
          if (res.statusCode == 200) {
            List<dynamic> data = convert.jsonDecode(res.body);
            return compute(parseCountriesData, data);
          } else {
            print('Request failed with status: ${res.statusCode}.');
            covidCountriesScaffoldKey.currentState.showSnackBar(snackBar(
                "${res.statusCode}: Error getting data",
                Color.fromARGB(230, 98, 91, 1)));
          }
        })
        .catchError((onError) => covidCountriesScaffoldKey.currentState
            .showSnackBar(snackBar(
                "Unable to get data, please check your connection",
                Color.fromARGB(230, 98, 91, 1))))
        //ignore: missing_return
        .timeout(Duration(seconds: 8), onTimeout: () {
          covidCountriesScaffoldKey.currentState.showSnackBar(
              snackBar("Request timeout", Color.fromARGB(126, 24, 60, 1)));
        });
  }

  // https://corona.lmao.ninja/v2/countries'
}

/// ****************************************************************************************/
/// MAP THE LIST DATA INTO THE MODEL ON A BACKGROUND THREAD
/// ***************************************************************************************/
List<CovidCountriesModel> parseCountriesData(List<dynamic> data) {
  final List<Map<String, dynamic>> covidDataList =
      data.cast<Map<String, dynamic>>();
  return covidDataList
      .map<CovidCountriesModel>((json) => CovidCountriesModel.fromJson(json))
      .toList();
}
