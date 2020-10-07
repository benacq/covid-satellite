import 'package:covidapp/models/countries_data_model.dart';
import 'package:covidapp/services/fetch_covid_data.dart';
import 'package:covidapp/services/map_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  MapEngine _mapEngineProvider;

  @override
  void initState() {
    super.initState();
    _mapEngineProvider = Provider.of<MapEngine>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    _typeAheadController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<CovidCountriesModel>>(
        future: new FetchCovidData().covidCountries,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error Fetching Data"),
            );
          }

          if (!snapshot.hasData) {
            return SpinKitChasingDots(
              color: Color.fromRGBO(164, 52, 68, 1),
              size: 50.0,
            );
          }

          List<CovidCountriesModel> covidCountriesData = snapshot.data;
          return Stack(
            children: [
              Consumer<MapEngine>(builder: (context, data, _) {
                return GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(26.3351, 17.2283), zoom: 0.0),
                  onMapCreated: (GoogleMapController controller) {
                    _mapEngineProvider.mapController.complete(controller);
                  },
                  compassEnabled: true,
                  onTap: (LatLng argument) {
                    FocusScope.of(context).unfocus();
                    data.disableMarkerInfo = false;
                  },
                  markers:
                      _mapEngineProvider.markerGenerator(covidCountriesData),
                );
              }),

              // Visibility(
              //   visible: _mapEngineProvider.mapMarkerInfo,
              //   child: Positioned.fill(
              //       child: Align(
              //           alignment: Alignment.bottomCenter,
              //           child: FractionallySizedBox(
              //             widthFactor: 0.85,
              //             child: Container(
              //                 decoration: BoxDecoration(
              //                     color: Color.fromRGBO(244, 244, 244, 1),
              //                     borderRadius: BorderRadius.only(
              //                         bottomLeft: Radius.circular(20),
              //                         topLeft: Radius.circular(20),
              //                         topRight: Radius.circular(20),
              //                         bottomRight: Radius.circular(20))),
              //                 margin: EdgeInsets.only(bottom: 10),
              //                 padding: EdgeInsets.all(10),
              //                 height: 300,
              //                 child: _mapEngineProvider.index == null
              //                     ? Center(
              //                         child: Text("Loading..."),
              //                       )
              //                     : null //markerInfoData(_infectedCountries)
              //                 ),
              //           ))),
              // ),
            ],
          );
        },
      ),
    );
  }
}
