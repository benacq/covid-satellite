import 'package:flutter/cupertino.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hts/screens/account/signin.dart';
import 'package:hts/screens/bookings.dart';
import 'package:hts/screens/home.dart';
import 'package:hts/screens/profile.dart';
import 'package:hts/screens/settings.dart';
import 'package:hts/services/auth.dart';
import 'package:hts/widgets/appbar.dart';
import 'package:hts/widgets/dialogboxes.dart';
import 'package:hts/widgets/drawer.dart';
import '../main.dart';
import '../themes/maintheme.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  //Keys
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  //Initialize
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double size = MediaQuery.of(context).size.width < MediaQuery.of(context).size.height
    //     ? MediaQuery.of(context).size.width
    //     : (!kIsWeb) ? MediaQuery.of(context).size.height : MediaQuery.of(context).size.height / 2;

    //For Refreshing the theme
    if (userProfile.containsKey("Theme"))
      myAppTheme = userProfile["Theme"] == "Light Theme"
          ? getMainThemeWithBrightness(context, Brightness.light)
          : getMainThemeWithBrightness(context, Brightness.dark);

    return
        // HomePage();

        SafeArea(
      child: Scaffold(
          key: scaffoldKey,
          backgroundColor: myAppTheme.scaffoldBackgroundColor,
          appBar: getAppBar(
            scaffoldKey: scaffoldKey,
            context: context,
            strAppBarTitle: "KHBA",
            showBackButton: false,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: IconButton(
                      onPressed: () {
                        if (blIsSignedIn) {
                          //Open Settings screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Bookings()),
                          );
                        } else {
                          showSnackBar(
                              scaffoldKey: scaffoldKey,
                              text: "Please Log in first");
                        }
                      },
                      icon: Icon(Icons.book_online)),
                  label: 'Bookings'),
              BottomNavigationBarItem(
                icon: IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () => _checkLoggedInUser(context),
                ),
                label: 'Profile',
              ),
            ],
          ),

          //drawer
          drawer: getDrawer(context, scaffoldKey),

          //Body
          body: HomePage()),
    );
  }

  _checkLoggedInUser(BuildContext context) {
    //For mobile
    if (blIsSignedIn) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    } else {
      //Redirect to SignIn screen
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => SignInScreen()),
          (Route<dynamic> route) => false);
    }
  }
}
