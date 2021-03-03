import 'dart:convert';

import 'package:Libmot_Mobile/models/booking_model.dart';
import 'package:Libmot_Mobile/models/get_route.dart';
import 'package:flutter/cupertino.dart';

import '../resources/networking/api_calls.dart';

class BookingRepository with ChangeNotifier {
 
  final booking = new BookingModel();
  GetRouteModel getRouteModel;

  Future<GetRouteModel> getAllRoute() async {
    final response = await ApiCalls().getAllRoutes();
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
       getRouteModel = GetRouteModel.fromJson(responseData);
      notifyListeners();
    } else {
      return null;
    }
  }
}
