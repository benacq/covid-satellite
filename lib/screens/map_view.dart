import 'package:covidapp/models/countries_data_model.dart';
import 'package:covidapp/services/fetch_covid_data.dart';
import 'package:covidapp/services/map_service.dart';
import 'package:covidapp/widgets/covid_country_data_cols.dart';
import 'package:covidapp/widgets/covid_map_detail_card.dart';
import 'package:covidapp/widgets/search_bar.dart';
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
  // ignore: unused_field
  MapEngine _mapEngineProvider;

  @override
  void initState() {
    super.initState();
    _mapEngineProvider = Provider.of<MapEngine>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: FutureBuilder<List<CovidCountriesModel>>(
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
              } else {
                List<CovidCountriesModel> covidCountriesData = snapshot.data;
                return Stack(
                  children: [
                    Consumer<MapEngine>(builder: (context, data, _) {
                      return GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(26.3351, 17.2283), zoom: 0.0),
                        onMapCreated: (GoogleMapController controller) {
                          data.mapController.complete(controller);
                        },
                        compassEnabled: true,
                        onTap: (LatLng argument) {
                          FocusScope.of(context).unfocus();
                          data.hideDetailCard = false;
                        },
                        markers: data.markerGenerator(covidCountriesData),
                      );
                    }),
                    Consumer<MapEngine>(builder: (context, data, _) {
                      return Visibility(
                          visible: data.isMarkerCardShowing,
                          child: (data.indexTapped != null &&
                                  covidCountriesData != null)
                              ? CovidMapDetailCard(
                                  covidModel:
                                      covidCountriesData[data.indexTapped],
                                  indexTapped: data.indexTapped,
                                )
                              : Center(
                                  child: Text("Loading..."),
                                ));
                    }),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: FractionallySizedBox(
                          widthFactor: 0.75,
                          child: SearchBar(),
                        ),
                      ),
                    ),
                    Positioned.fill(
                        child: Align(
                      alignment: Alignment.topRight,
                      child: HelpIcon(),
                    )),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
