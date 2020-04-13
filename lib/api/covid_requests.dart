import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:async';

class CovidRequest with ChangeNotifier {

  StreamController _mapViewCountryController;
  StreamController _covidGlobalController;
  StreamController _historyController;


/////////////////////////////////////////COVID GLOBAL DATA/////////////////////////////////////


  // StreamController get covidGlobalStream {
  //   _covidGlobalController = new StreamController();
  //   loadCovidData();
  //   return _covidGlobalController;
  // }

  // Future getCovidGlobalData() async {
  //   var url = 'https://corona.lmao.ninja/all';
  //   try {
  //     final response = await http.get(url);
  //     if (response.statusCode != 200) {
  //       print('Request failed with status: ${response.statusCode}.');
  //     } else {
  //       notifyListeners();
  //       return json.decode(response.body);
  //     }
  //   } catch (e) {

  //     print("AN EXCEPTION OCCURED ${e}");
  //   }
  // }

  // loadCovidGlobalData() async {
  //   getCovidGlobalData().then((res) async {
  //     _covidGlobalController.add(res);
  //     return res;
  //   });
  // }




  Future<Map> get covidAll async {
    var url = 'https://corona.lmao.ninja/all';
    Map<dynamic, dynamic> jsonData;

    try {
      var response = await http.get(url);
      if (response.statusCode != 200) {
        print('Request failed with status: ${response.statusCode}.');
      } else {
        jsonData = convert.jsonDecode(response.body);
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return jsonData;
  }


  ///GET COUNTRIES DATA FOR MAP VIEW
  StreamController get covidCountryStream {
    _mapViewCountryController = new StreamController();
    loadCovidData();
    return _mapViewCountryController;
  }

  Future getCovidCountriesData() async {
    var url = 'https://corona.lmao.ninja/countries';
    try {
      final response = await http.get(url);
      if (response.statusCode != 200) {
        print('Request failed with status: ${response.statusCode}.');
      } else {
        notifyListeners();
        return json.decode(response.body);
      }
    } catch (e) {

      print("AN EXCEPTION OCCURED ${e}");
    }
  }

  loadCovidData() async {
    getCovidCountriesData().then((res) async {
      _mapViewCountryController.add(res);
      return res;
    });
  }


///////////////////////////////////////////// GET COUNTRY HISTORY
///
/////////////////////////////////////////////// NOT USED

  StreamController get covidHistoryStream {
    _historyController = new StreamController();
    loadCovidHistoryData();
    return _historyController;
  }

  Future getCovidHistoryData() async {
    var url = 'https://corona.lmao.ninja/v2/historical';
    try {
      final response = await http.get(url);
      if (response.statusCode != 200) {
        print('Request failed with status: ${response.statusCode}.');
      } else {
        notifyListeners();
        return json.decode(response.body);
      }
    } catch (e) {
      print("AN EXCEPTION OCCURED ${e}");
    }
  }

  loadCovidHistoryData() async {
    getCovidHistoryData().then((res) async {
      _historyController.add(res);
      return res;
    });
  }



}
