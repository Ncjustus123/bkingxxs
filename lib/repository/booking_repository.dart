import 'dart:convert';

import 'package:Libmot_Mobile/models/booking_model.dart';
import 'package:Libmot_Mobile/models/depature_terminal.dart';
import 'package:Libmot_Mobile/models/get_buses_model.dart';
import 'package:Libmot_Mobile/models/get_route.dart';
import 'package:flutter/cupertino.dart';

import '../resources/networking/api_calls.dart';
import '../resources/networking/api_calls.dart';
import '../resources/networking/api_calls.dart';

class BookingRepository with ChangeNotifier {
  final booking = new BookingModel();
  final getBuses = new  GetBusesModel();


  GetRouteModel getRouteModel;
  DepatureTerminalModel depatureTerminalModel;
  getAllRoute() async {
    final response = await ApiCalls().getAllRoutes();
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      getRouteModel = GetRouteModel.fromJson(responseData);
      notifyListeners();
    } else {
      return null;
    }
  }

  getDestinationTerminals(int id) async {
    depatureTerminalModel = null;
    notifyListeners();
    final response = await ApiCalls().getDestinationTerminals(id);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      depatureTerminalModel = DepatureTerminalModel.fromJson(responseData);
      notifyListeners();
    } else {
      return null;
    }
  }
  searchBuses() async{
    if(getBuses.tripType == null) {getBuses.tripType=0;}
    final response = await ApiCalls().searchBuses();
    if(response.statusCode == 200){
       
    }
  }
}
