import 'package:Libmot_Mobile/Reusables/appBar.dart';
import 'package:Libmot_Mobile/Reusables/buttons.dart';
import 'package:Libmot_Mobile/Reusables/text_field.dart';
import 'package:Libmot_Mobile/controllers/hire_bus_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BusHirePage extends StatefulWidget {
  @override
  _BusHirePageState createState() => _BusHirePageState();
}

class _BusHirePageState extends State<BusHirePage> {
  final _formKeyBusHire = GlobalKey<FormState>();

  final fromController = TextEditingController();

  final toController = TextEditingController();

  final dateController = TextEditingController();

  final busHireDetailsPage = "/busHireDetails";

  TextEditingController departureDateController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  HireBusRepository hireBus;
  GoogleMapsPlaces _places;
  LatLng userLocation;
  List<AddressComponent> _placeDetails;
  Map _json;

  // String apiKey =        "AIzaSyD6mAOR2Bp-obgXHVCb_iyhTbQliRfhFZM";
  String apiKey = "AIzaSyBg1uH_Vx282roGRmhJExCpwfvMDrHCwRw";

  @override
  void initState() {
    _places = GoogleMapsPlaces(
      apiKey: apiKey,
    );
    super.initState();
  }

  String getStateFromDetails() {
    print(" stating${_placeDetails[_placeDetails.length - 2].longName}");
    return _placeDetails[_placeDetails.length - 2].longName;
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    hireBus = Provider.of<HireBusRepository>(context);

    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          width: _width,
          height: _height,
          child: Column(
            children: [
              myAppBar(context, 'Hire A Bus'),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(23.0),
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(45))),
                    // key: _formKeyBusHire,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              handlePress();
                            },
                            child: InputFormField(
                              suffixIcon: Icon(Icons.place),
                              label: 'From',
                              controller: fromController,
                              enabled: false,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              dropOff();
                            },
                            child: InputFormField(
                              suffixIcon: Icon(Icons.place),
                              label: 'To',
                              enabled: false,
                              controller: toController,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              DateTime chosenDate = await showDatePicker(
                                helpText: 'Departure Date',
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(DateTime.now().year,
                                    DateTime.now().month, DateTime.now().day),
                                lastDate: DateTime(DateTime.now().year + 2),
                              );
                              if (chosenDate != null) {
                                setState(() {
                                  departureDateController.text =
                                      DateFormat('yyyy-MM-dd')
                                          .format(chosenDate)
                                          .toString();
                                });
                              }
                            },
                            child: InputFormField(
                              enabled: false,
                              controller: departureDateController,
                              suffixIcon: Icon(Icons.event_note),
                              label: 'Departure Date',
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Buttons.coloredButton(
                              title: "Proceed",
                              context: context,
                              onTap: () {
                                //Get.to(PlaceDetailWidget());
                                Navigator.of(context)
                                    .pushNamed(busHireDetailsPage);
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  //open for only two weeks

  Future<void> handlePress() async {
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: "AIzaSyD6mAOR2Bp-obgXHVCb_iyhTbQliRfhFZM",
      strictbounds: false,
      mode: Mode.overlay,
      onError: (error) {
        print(error.toJson());
      },
      language: "en",
      decoration: InputDecoration(
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      components: [Component(Component.country, "NG")],
    );
    print('============p');
    print(p);

    // if (p != null) {
    //   // get detail (lat/lng)
    //
    //   PlacesDetailsResponse detail =
    //       await _places.getDetailsByPlaceId(p.placeId);
    //   fromController.text = detail.result.formattedAddress;
    //   _json["pickUpLat"] = detail.result.geometry.location.lat;
    //   _json["pickUpLng"] = detail.result.geometry.location.lng;
    //   _json["pickUpAddress"] = detail.result.formattedAddress;
    //   _placeDetails = detail.result.addressComponents;
    // }
  }

  Future<void> dropOff() async {
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: apiKey,
      onError: (error) {
        print(error.toJson());
      },
      mode: Mode.overlay,
      language: "en",
      decoration: InputDecoration(
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      components: [Component(Component.country, "NG")],
    );
    displayPrediction(p, _scaffoldKey.currentState);
    // if (p != null) {
    //   // get detail (lat/lng)
    //   PlacesDetailsResponse detail =
    //       await _places.getDetailsByPlaceId(p.placeId);
    //   toController.text = detail.result.formattedAddress;
    //   _json["dropOffLat"] = detail.result.geometry.location.lat;
    //   _json["dropOffLng"] = detail.result.geometry.location.lng;
    //   _json["dropOffAddress"] = detail.result.formattedAddress;
    //   _placeDetails = detail.result.addressComponents;
    // }
  }

  Future<Null> displayPrediction(
      Prediction p, ScaffoldState scaffoldState) async {
    if (p != null) {
      // get detail (lat/lng)
      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: 'AIzaSyBg1uH_Vx282roGRmhJExCpwfvMDrHCwRw',
        apiHeaders: await GoogleApiHeaders().getHeaders(),
      );
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
      print('detail');
      print(detail);
      toController.text = detail.result.formattedAddress;
      _json["dropOffLat"] = detail.result.geometry.location.lat;
      _json["dropOffLng"] = detail.result.geometry.location.lng;
      _json["dropOffAddress"] = detail.result.formattedAddress;
      _placeDetails = detail.result.addressComponents;
    }
  }

// *894*7*0051#

  proceedButton(context) {
    return ElevatedButton(
      child: Text("Proceed"),
      onPressed: () {
        if (_formKeyBusHire.currentState.validate()) {
          hireBus.hireBus.departure = fromController.text;
          hireBus.hireBus.destination = toController.text;
          hireBus.hireBus.departureDate = dateController.text;
          Navigator.of(context).pushNamed(busHireDetailsPage);
        }
      },
    );
  }
}
