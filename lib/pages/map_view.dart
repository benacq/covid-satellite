import 'package:covidapp/api/covid_requests.dart';
import 'package:covidapp/logic/map_view_logic.dart';
import 'package:covidapp/logic/type_ahead_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CovidMapView extends StatefulWidget {
  @override
  _CovidMapViewState createState() => _CovidMapViewState();
}

class _CovidMapViewState extends State<CovidMapView> {
  
  NumberFormat f = new NumberFormat();
  final TextEditingController _typeAheadController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _typeAheadController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CovidRequest covidCountries = Provider.of<CovidRequest>(context);
    MapViewLogic covidMapOperations = Provider.of<MapViewLogic>(context);
    List _infectedCountries;

    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
            stream: covidCountries.covidCountryStream?.stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                Center(
                  child: Text("Error Fetching Data"),
                );
              }
              if (snapshot.hasData) {
                _infectedCountries = snapshot.data;
                covidMapOperations.setSnapShot = snapshot.data;

                // print(covidMapOperations.markerGenerator);
              }
              return !snapshot.hasData
                  ? SpinKitChasingDots(
                      color: Color.fromRGBO(164, 52, 68, 1),
                      size: 50.0,
                    )
                  : Stack(children: [
                      GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(26.3351, 17.2283), zoom: 0.0),
                        onMapCreated: (GoogleMapController controller) {
                          covidMapOperations.mapController.complete(controller);
                        },
                        compassEnabled: true,
                        onTap: (LatLng argument) {
                          FocusScope.of(context).unfocus();
                          covidMapOperations.disableMarkerInfo = false;
                        },
                        markers: covidMapOperations.markerGenerator,
                      ),
                      Visibility(
                        visible: covidMapOperations.mapMarkerInfo,
                        child: Positioned.fill(
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: FractionallySizedBox(
                                  widthFactor: 0.85,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(244, 244, 244, 1),
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              bottomRight:
                                                  Radius.circular(20))),
                                      margin: EdgeInsets.only(bottom: 10),
                                      padding: EdgeInsets.all(10),
                                      height: 300,
                                      child: covidMapOperations.index == null
                                          ? Center(
                                              child: Text("Loading..."),
                                            )
                                          : markerInfoData(_infectedCountries)),
                                ))),
                      ),

                      //SEARCH BAR
                      Positioned.fill(
                          child: Align(
                              alignment: Alignment.topCenter,
                              child: FractionallySizedBox(
                                widthFactor: 0.75,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.2),
                                        blurRadius:
                                            10.0, // has the effect of softening the shadow
                                        spreadRadius:
                                            -10.0, // has the effect of extending the shadow
                                        offset: Offset(
                                          10.0, // horizontal, move right 10
                                          10.0, // vertical, move down 10
                                        ),
                                      )
                                    ],
                                  ),
                                  margin: EdgeInsets.only(
                                    top: 10,
                                    right: 10,
                                  ),
                                  height: 50,
                                  // child:,
                                  child: TypeAheadField(
                                    textFieldConfiguration:
                                        TextFieldConfiguration(
                                      onEditingComplete: () => {
                                        print(this._typeAheadController.text),
                                        covidMapOperations.changeMapCameraPosition(
                                            this._typeAheadController.text),
                                        FocusScope.of(context).unfocus()
                                      },
                                      decoration: InputDecoration(
                                        suffix: Container(
                                          margin: EdgeInsets.only(
                                            right: 10,
                                          ),
                                          child: GestureDetector(
                                            onTap: () => {
                                              covidMapOperations.changeMapCameraPosition(this
                                                  ._typeAheadController
                                                  .text),
                                              FocusScope.of(context).unfocus()
                                            },
                                            child: Text(
                                              "Go",
                                              style: TextStyle(
                                                  color: Colors.blueAccent,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        icon: Container(
                                            margin: EdgeInsets.only(
                                                left: 10, top: 5),
                                            width: 22,
                                            height: 22,
                                            child: new Image.asset(
                                                'assets/icons/search.png')),
                                        border: InputBorder.none,
                                        hintText: "Search Country",
                                        // contentPadding: EdgeInsets.only(left: 10)
                                      ),
                                      controller: this._typeAheadController,
                                    ),
                                    suggestionsCallback: (pattern) {
                                      return CitiesService.getSuggestions(
                                          pattern);
                                    },
                                    itemBuilder: (context, suggestion) {
                                      return this._typeAheadController.text ==
                                              ''
                                          ? Container()
                                          : ListTile(
                                              title: Text(suggestion),
                                            );
                                    },
                                    hideOnEmpty: true,
                                    onSuggestionSelected: (suggestion) {
                                      this._typeAheadController.text =
                                          suggestion;
                                    },
                                  ),
                                ),
                              ))),

            ///////////////////////////////////////////                 ////////////////////////////////////
            ////////////////////////////////////////// H E L P  I C O N ////////////////////////////////////
                      Positioned.fill(
                          child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: EdgeInsets.only(top: 20, right: 10),
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          child: FloatingActionButton(
                            backgroundColor: Colors.black,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => new AlertDialog(
                                        title: new Text("HELP"),
                                        content: new Text(
                                            "Virus icons represent countries with recorded cases.\nTap on a country to display case details"),
                                      ));
                            },
                            child: Icon(
                              FontAwesomeIcons.info,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        ),
                      )),
                    ]);
            }),
      ),
    );
  }

  //WIDGET METHODS
  ///FLEX WIDGET
  Widget _flexThreeCols(Map dataMap) {
    MapViewLogic covidMapOperations = Provider.of<MapViewLogic>(context);
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
                    f.format(dataMap['cases']),
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
                    "Cases",
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
                    f.format(dataMap['deaths']),
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
                    "Deaths",
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
                    f.format(dataMap['recovered']),
                    style: TextStyle(
                        color: Color.fromRGBO(60, 214, 152, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    "Recoveries",
                    style: TextStyle(
                        color: Color.fromRGBO(60, 214, 152, 1), fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  //MARKER TAP INFO WIDGET
  Widget markerInfoData(List infectedCountries) {
    MapViewLogic covidMapOperations = Provider.of<MapViewLogic>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: 80,
                color: Colors.red,
                constraints: BoxConstraints(maxHeight: 80, maxWidth: 120),
                child: Container(
                  child: Image.network(
                      infectedCountries[covidMapOperations.index]['countryInfo']
                          ['flag']),
                )),
          ],
        ),
        SizedBox(height: 4),

        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                infectedCountries[covidMapOperations.index]['country']
                    .toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),

        SizedBox(height: 25),

        _flexThreeCols(infectedCountries[covidMapOperations.index]),

        // //////////THIRD FLEX
        SizedBox(
          height: 10,
        ),

        Flex(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                        f.format(infectedCountries[covidMapOperations.index]
                            ['todayCases']),
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
                        "Cases Today",
                        style: TextStyle(
                            color: Color.fromRGBO(237, 139, 0, 1),
                            fontSize: 15),
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
                        f.format(infectedCountries[covidMapOperations.index]
                            ['todayDeaths']),
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
                        "Deaths Today",
                        style: TextStyle(
                            color: Color.fromRGBO(255, 127, 127, 1),
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }




}
