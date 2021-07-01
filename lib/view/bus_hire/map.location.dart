import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';


class MapLocation extends StatefulWidget {
  MapLocation({this.forResult = false});
  final bool forResult;

  @override
  _MapLocationState createState() => _MapLocationState(forResult);
}

class _MapLocationState extends State<MapLocation> {
  _MapLocationState(this._forResult);

  final bool _forResult;

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: CustomWidget.getAppBar(context, "pick your location", true),
      body: Column(
        children: <Widget>[
          Expanded(
            child: PlacePicker(
              apiKey: "",// "AIzaSyCDKx70BDW1fPBXOUNfN4aWKTSdyJWB45A",
              initialPosition: _kGooglePlex.target,
              useCurrentLocation: true,
              onPlacePicked: (result) {
                Map json = Map();
                json['address'] = result.formattedAddress;
                json['lat'] = result.geometry.location.lat;
                json['lng'] = result.geometry.location.lng;

                if (_forResult) {
                  Navigator.of(context).pop(result);
                } else {
//                        Navigator.of(context)
//                            .push(createRoute(PreferredDateTime()));
                }
              },
            ),
          ),
//          Container(
//            padding: const EdgeInsets.all(5),
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.end,
//              children: <Widget>[
//                Text("Searching..."),
//                Container(
//                  width: 200,
//                  height: 45,
//                  child: RaisedButton(
//                    shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.all(Radius.circular(45))),
//                    elevation: 5,
//                    onPressed: () {
//                      if (_forResult) {
//                        Navigator.of(context).pop("current location");
//                      } else {
////                        Navigator.of(context)
////                            .push(createRoute(PreferredDateTime()));
//                      }
////
//                    },
//                    color: Colors.yellow[700],
//                    child: Text(
//                      "Proceed",
//                      style: TextStyle(
//                          color: Colors.white, fontWeight: FontWeight.bold),
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          )
        ],
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
