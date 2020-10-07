import 'package:covidapp/screens/map_view.dart';
import 'package:covidapp/screens/covid_countries.dart';
import 'package:covidapp/screens/covid_global.dart';
import 'package:covidapp/services/map_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentTab = 0;
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(164, 52, 68, 1),
        title: Text(
          "Covid Satellite",
          style: GoogleFonts.chakraPetch(),
        ),
        actions: <Widget>[
          IconButton(
            tooltip: "Map View",
            icon: Icon(FontAwesomeIcons.map),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider<MapEngine>(
                        create: (context) => new MapEngine(),
                        child: CovidMapView())),
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: Container(
            child: WillPopScope(
          onWillPop: onWillPop,
          child: Stack(
            children: <Widget>[
              PageView(
                onPageChanged: (index) {
                  setState(() {
                    _currentTab = index;
                  });
                },
                controller: _pageController,
                children: <Widget>[
                  CovidGlobal(),
                  CovidCountries(),
                ],
              ),
            ],
          ),
        )),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        fixedColor: Color.fromRGBO(164, 52, 68, 1),
        elevation: 16.0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            title: Text('Global'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            title: Text('Countries'),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentTab = index;
          });
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 350), curve: Curves.ease);
        },
      ),
    );
  }

  DateTime currentBackPressTime;
  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Press back again to close app');
      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return true;
  }
}
