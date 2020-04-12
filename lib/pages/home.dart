import 'package:covidapp/pages/countries.dart';
import 'package:covidapp/pages/covid_main.dart';
import 'package:covidapp/pages/map_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(164, 52, 68, 1),
        title: Text("Covid Brief"),
        actions: <Widget>[
          IconButton(
            tooltip: "Map View",
            icon: Icon(FontAwesomeIcons.map),
            color: Colors.white,
            onPressed: () {
              // Navigator.pushNamed(context, '/map_view');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CovidMapView()));
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
                  CovidMainPage(),
                  CovidCountryView(),
                  // CovidMapView()
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
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.map),
          //   title: Text('Map View'),
          // ),
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
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Press back again to close app');
      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}
