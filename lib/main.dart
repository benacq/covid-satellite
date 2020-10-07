import 'package:covidapp/logic/map_view_logic.dart';
import 'package:covidapp/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api/covid_requests.dart';

void main() {
  runApp(MyApp());
  // runApp(MultiProvider(providers: [
  //   ChangeNotifierProvider(
  //     create: (BuildContext context) => CovidRequest(),
  //   ),
  //   ChangeNotifierProvider(
  //     create: (BuildContext context) => MapViewLogic(),
  //   )
  // ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
