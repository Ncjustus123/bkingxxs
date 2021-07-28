import 'package:Libmot_Mobile/Reusables/appBar.dart';
import 'package:Libmot_Mobile/Reusables/buttons.dart';
import 'package:Libmot_Mobile/Reusables/text_field.dart';
import 'package:Libmot_Mobile/controllers/hire_bus_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
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

  // String apiKey = "AIzaSyBk_w-PWeLWwnMb_nxVl_Ybq2Mc123re9w";
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
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKeyBusHire,

                        child: Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                Prediction p = await PlacesAutocomplete.show(
                                  context: context,
                                  apiKey: apiKey,
                                  mode: Mode.overlay,
                                  // Mode.fullscreen
                                  strictbounds: false,
                                  types: [],
                                  language: "en",
                                  onError: (error) {
                                    print(error.toJson());
                                  },
                                  components: [
                                    Component(Component.country, "NG")
                                  ],
                                );
                                print(p);

                                if (p != null) {
                                  PlacesDetailsResponse _detail = await _places
                                      .getDetailsByPlaceId(p.placeId);
                                  fromController.text =
                                      _detail.result.formattedAddress;
                                  print(_detail.toJson());
                                  print(
                                      "${_detail.result.geometry.location.lat} ${_detail.result.geometry.location.lng}");
                                }
                              },
                              child: InputFormField(
                                suffixIcon: Icon(Icons.place),
                                label: 'From',
                                controller: fromController,
                                enabled: false,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                Prediction p = await PlacesAutocomplete.show(
                                  context: context,
                                  apiKey: apiKey,
                                  mode: Mode.overlay,
                                  // Mode.fullscreen
                                  strictbounds: false,
                                  types: [],
                                  language: "en",
                                  onError: (error) {
                                    print(error.toJson());
                                  },
                                  components: [
                                    Component(Component.country, "NG")
                                  ],
                                );
                                print(p);

                                if (p != null) {
                                  PlacesDetailsResponse _detail = await _places
                                      .getDetailsByPlaceId(p.placeId);
                                  toController.text =
                                      _detail.result.formattedAddress;
                                  print(_detail.toJson());
                                  print(
                                      "${_detail.result.geometry.location.lat} ${_detail.result.geometry.location.lng}");
                                }
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
                                  if (_formKeyBusHire.currentState.validate()) {
                                    hireBus.hireBus.departure = fromController.text;
                                    hireBus.hireBus.destination = toController.text;
                                    hireBus.hireBus.departureDate = departureDateController.text;
                                    Navigator.of(context).pushNamed(busHireDetailsPage);
                                    print(hireBus.hireBus.toJson());
                                  }
                                  //
                                  // Navigator.of(context)
                                  //     .pushNamed(busHireDetailsPage);
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

}
