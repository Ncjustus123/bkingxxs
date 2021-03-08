import 'dart:convert';

import 'package:Libmot_Mobile/models/booking_model.dart';
import 'package:Libmot_Mobile/models/destination_terminal.dart';
import 'package:Libmot_Mobile/models/get_buses_model.dart';
import 'package:Libmot_Mobile/models/get_buses_response.dart';
import 'package:Libmot_Mobile/models/get_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../resources/networking/api_calls.dart';
import '../resources/networking/api_calls.dart';
import '../resources/networking/api_calls.dart';

class BookingRepository with ChangeNotifier {
  bool depatureAvailable;
  bool arrivalAvailable;

  final booking = new BookingModel();
  final getBuses = new GetBusesModel();
  final String busSearch = "/selectBus";

  GetRouteModel getRouteModel;
  DestinationTerminalModel destinationTerminalModel;
  GetBusesModel model;
  GetBusesResponseModel getBusesResponseModel;

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
    destinationTerminalModel = null;
    notifyListeners();
    final response = await ApiCalls().getDestinationTerminals(id);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      destinationTerminalModel =
          DestinationTerminalModel.fromJson(responseData);

      notifyListeners();
    } else {
      return null;
    }
  }

  searchBuses(_scaffoldKey, BuildContext context) async {
    model = GetBusesModel(
        tripType: getBuses.tripType ?? 0,
        departureTerminalId: getBuses.departureTerminalId,
        destinationTerminalId: getBuses.destinationTerminalId,
        numberOfAdults: getBuses.numberOfAdults,
        numberOfChildren: getBuses.numberOfChildren ?? 0,
        departureDate: getBuses.departureDate,
        returnDate: getBuses.returnDate);
    Response response = await ApiCalls().searchBuses(model.toJson());
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      getBusesResponseModel = GetBusesResponseModel.fromJson(responseData);
      if (getBusesResponseModel.object == null) {
        depatureAvailable = false;

      
        _scaffoldKey.currentState.showSnackBar(
            new SnackBar(content: new Text("No buses available")));

        
      } else {
        Navigator.of(context).pushNamed(busSearch);
      }
    } else {
      return null;
    }
  }

  void tripTypeChange(int i) {
    getBuses.tripType = i;
    notifyListeners();
  }

  Future<DateTime> showDate(context) async {
    final now = DateTime.now();
    return await showDatePicker(
        context: context,
        initialDate: now.add(Duration(days: 1)), //tomorrow initial date
        firstDate: now,
        lastDate: now.add(Duration(days: 14)), //TODO days from firebase//open for only two weeks
        helpText: "Select travelling date");
  }
}
