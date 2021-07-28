import 'dart:convert';

import 'package:Libmot_Mobile/constants/dialogs/dialog.dart';
import 'package:Libmot_Mobile/models/hire_bus_model.dart';
import 'package:Libmot_Mobile/services/networking/api_calls.dart';
import 'package:Libmot_Mobile/services/networking/getBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';

import 'booking_repository.dart';

class HireBusRepository with ChangeNotifier {
  HireBusModel hireBus = HireBusModel();

  Future<String> getAddress(BuildContext context) async {
    Prediction p = await PlacesAutocomplete.show(
        context: context,
        apiKey: GetBase.kGoogleApiKey,
        mode: Mode.overlay,
        // Mode.fullscreen
        language: "ng",
        components: [new Component(Component.country, "ng")]);

    return p.description ?? "";
  }

  Future postHireBus(context, {name}) async {
    final response = await ApiCalls().postHireBus(hireBus.toJson());

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
      notifyListeners();
      if (responseData['code'] == '200') {
        EasyLoading.dismiss();

        dialog(context, 'Thank You $name',
            'We are processing your request. A member of our team will get in touch with you soon.\n\n For quick information you can send an email to support@libmot.com or call +2349031565022\n\nThank you for choosing LIBMOT.COM',
            onpressed: () {
          Get.back();
        });
      } else {
        EasyLoading.dismiss();
        Dialogs.showErrorSnackBar(
            'Failed', '${responseData['shortDescription']}');
      }
    } else {
      EasyLoading.dismiss();
      Dialogs.showErrorSnackBar('Failed', 'Kindly fill the form properly and try again.');

      return null;
    }
  }
}
