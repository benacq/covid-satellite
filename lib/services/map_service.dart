import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:covidapp/models/countries_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapEngine with ChangeNotifier {
  Completer<GoogleMapController> _mapController = Completer();
  // List _covidStreamList;
  Uint8List _customMarker;
  int _index;
  bool _mapMarkerInfo = false;

  get mapMarkerInfo => _mapMarkerInfo;
  get index => _index;
  get mapController => _mapController;

  set disableMarkerInfo(bool disable) {
    _mapMarkerInfo = disable;
    notifyListeners();
  }

//PASS LIST TO THIS CLASS
  // set setSnapShot(List snapshot) {
  //   _covidStreamList = snapshot;
  // }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

//SET MARKER ICON
  Future<void> markerIcon() async {
    final Uint8List markerIcon =
        await getBytesFromAsset("assets/icons/virus2.png", 70);
    _customMarker = markerIcon;
  }

  // ignore: missing_return
  Set<Marker> markerGenerator(
      List<CovidCountriesModel> countriesDataModelList) {
    if (countriesDataModelList != null) {
      final Set<Marker> _markers = {};
      Marker countryMarker;
      if (_customMarker != null) {
        for (int i = 0; i < countriesDataModelList.length; i++) {
          countryMarker = Marker(
              markerId: MarkerId(countriesDataModelList[i].country.toString()),
              position: LatLng(countriesDataModelList[i].lat.toDouble(),
                  countriesDataModelList[i].long.toDouble()),
              icon: BitmapDescriptor.fromBytes(_customMarker),
              // icon: BitmapDescriptor.defaultMarker,
              infoWindow: InfoWindow(
                  title: countriesDataModelList[i].country.toString()),
              onTap: () {
                _index = i.toInt();
                _mapMarkerInfo = true;
                notifyListeners();
              });

          _markers.add(countryMarker);
        }
      }
      return _markers;
    }
  }

  void changeMapCameraPosition(value) {
    if (value == null) {
      throw (value);
    } else {
      Geolocator()
          .placemarkFromAddress(value)
          .then((data) async => {
                await _mapController.future
                    .then((controller) => {
                          controller.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                            target: LatLng(data[0].position.latitude,
                                data[0].position.longitude),
                            zoom: 5.0,
                          )))
                        })
                    .catchError((onError) {
                  print("Controller error");
                })
              })
          .catchError((onError) {
        print("An error occured");
      });
    }
  }

  MapEngine() {
    markerIcon();
  }
}
