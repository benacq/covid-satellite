import 'dart:convert' as convert;

import 'package:covidapp/models/countries_data_model.dart';
import 'package:covidapp/models/global_data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class FetchCovidData {
  static final GlobalKey<ScaffoldState> covidGlobalScaffoldKey =
      new GlobalKey<ScaffoldState>();

  static final GlobalKey<ScaffoldState> covidCountriesScaffoldKey =
      new GlobalKey<ScaffoldState>();

  final snackBar = (errorMsg, Color color) => SnackBar(
        backgroundColor: color,
        content: Text(errorMsg),
      );

  // ****************************************************************************************/
  // * FETCH CORONA GLOBAL DATA
  //*****************************************************************************************/
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
                Color.fromARGB(215, 56, 94, 1))))
        // ignore: missing_return
        .timeout(Duration(seconds: 10), onTimeout: () {
          Fluttertoast.showToast(msg: 'Request timeout');
        });
  }

  //****************************************************************************************/
  // FETCH CORONA STATS BY COUNTRY
  //*****************************************************************************************/
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
        .timeout(Duration(seconds: 10), onTimeout: () {
          Fluttertoast.showToast(msg: 'Request timeout');
        });
  }
}

/// ****************************************************************************************/
/// isolate:
/// MAPS THE LIST DATA INTO THE MODEL ON A BACKGROUND THREAD
/// ***************************************************************************************/
List<CovidCountriesModel> parseCountriesData(List<dynamic> data) {
  final List<Map<String, dynamic>> covidDataList =
      data.cast<Map<String, dynamic>>();
  return covidDataList
      .map<CovidCountriesModel>((json) => CovidCountriesModel.fromJson(json))
      .toList();
}

// abstract class CovidCountryModelInterFace{
//   CovidCountryModel singleCountryStat(int index)
//   Future<List<CovidCountryModel>> covidCountryData();
// }

// //THIS IS AN ISOLATE FUNCTION WHICH MAPS THE DATA UNTO MY CUSTOM OBJECT ON A BACKGROUND THREAD
// List<CovidCountriesModel> parseCountriesData(List<dynamic> data) {
//   final List<Map<String, dynamic>> covidDataList =
//       data.cast<Map<String, dynamic>>();
//       covidDataList.
//   return covidDataList
//       .map<CovidCountriesModel>((json) => CovidCountriesModel.fromJson(json))
//       .toList();
// }

// class CovidCountryStats implements CovidCountryModelInterFace{
//   /*
//   DATA STRUCTURES USED

//   List
//   When a request is sent to the endpoint, an http response is returned in the form of a list/array of json objects.
//   The dynamic size of the List data structure makes it perfect for my use case since i do not know the
//   exact size of data to expect.

//   Map
//   The Map data structure enable us to store data in the form of key value pair
//   The Json object contained in the List is decoded to Dart Map object which provides
//   several helper functions to manipulate its elements.

//   CovidCountryModel
//   This is a custom Dart object that models data of a particular country in one structure.

//   */

//   Future<List<CovidCountriesModel>> covidCountryData() async {

//     //CHECK INTERNET CONNECTION AVAILABILITY BEFORE SENDING REQUEST
//     try {
//       final result = await InternetAddress.lookup('google.com');
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//          return await http
//         .get(url)
//         .then((res) async {
//           assert(res != null);
//           if (res.statusCode == 200) {
//             List<dynamic> data = convert.jsonDecode(res.body);
//             return compute(parseCountriesData, data);
//           } else {
//             print('Request failed with status: ${res.statusCode}.');
//           }
//         });
//       }
//     } on SocketException catch (_) {
//       //no internet connection
//         load cached data from local persistence
//         return cachedData;
//     }
//   }

//   CovidCountriesModel singleCountryStat(int index) async {
//     return await covidCountryData().then((value) => value.elementAt(index));
//   }

// }

// Test covidCountryData_Should_return_List_of_CovidCountryModel_Objects  {

//       Mock covidCountryModelMock;

//       //Stubbing
//       List<CovidCountriesModel> countryData = countryStats.covidCountryData();

//       when(countryStats.covidCountryData()).thenReturn(covidCountryModelMock);
//       expect(countryStats.covidCountryData(), covidCountryModelMock);
// }
