import 'dart:convert';

import 'package:Libmot_Mobile/models/hire_bus_model.dart';
import 'package:Libmot_Mobile/services/networking/api_calls.dart';
import 'package:Libmot_Mobile/services/networking/getBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';


class HireBusRepository with ChangeNotifier {
  HireBusModel hireBus = HireBusModel();

  Future<String> getAddress(BuildContext context) async {
    Prediction p = await PlacesAutocomplete.show(
        context: context,
        apiKey: GetBase.kGoogleApiKey,
        mode: Mode.overlay, // Mode.fullscreen
        language: "ng",
        components: [new Component(Component.country, "ng")]);

    return p.description ?? "";
  }

  Future postHireBus() async {
    final response = await ApiCalls().postHireBus(hireBus.toJson());
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
      notifyListeners();
    } else {
      return null;
    }
  }
}
