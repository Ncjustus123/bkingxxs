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

class BookingRepository with ChangeNotifier {
  //bool depatureAvailable;
  //bool arrivalAvailable;
  CurrentBookingStatus currentBookingStatus;

  final booking = new BookingModel();
  final getBuses = new GetBusesModel();
  final String busSearch = "/selectBus";
  final String applyCouponPage = "/applyCoupon";

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
    // TODO change back ====>
    // model = GetBusesModel(
    //     tripType: getBuses.tripType ?? 0,
    //     departureTerminalId: getBuses.departureTerminalId,
    //     destinationTerminalId: getBuses.destinationTerminalId,
    //     numberOfAdults: getBuses.numberOfAdults,
    //     numberOfChildren: getBuses.numberOfChildren ?? 0,
    //     departureDate: getBuses.departureDate,
    //     returnDate: getBuses.returnDate);
    booking.paymentMethod = 5;
    booking.passengerType = 0;
    booking.bookingType = 2;
    model = GetBusesModel(
        tripType: 0,
        departureTerminalId: 17,
        destinationTerminalId: 15,
        numberOfAdults: 3,
        numberOfChildren: 2,
        departureDate: getBuses.departureDate,
        returnDate: getBuses.returnDate);
    //Response response = await ApiCalls().searchBuses(getBuses.toJson());
    Response response = await ApiCalls().searchBuses(model.toJson());

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      getBusesResponseModel = GetBusesResponseModel.fromJson(responseData);
      if (getBusesResponseModel.object == null) {
        //depatureAvailable = false;

        ScaffoldMessenger.of(context).showSnackBar(
            new SnackBar(content: new Text("No buses available")));
      } else {
        currentBookingStatus = CurrentBookingStatus.Departure;
        Navigator.of(context).pushNamed(busSearch);
      }
    } else {
      return null;
    }
  }

  void tripTypeChange(int i) {
    getBuses.tripType = i;
    booking.tripType = i;
    notifyListeners();
  }

  Future<DateTime> showDate(context) async {
    final now = DateTime.now();
    return await showDatePicker(
        context: context,
        initialDate: now.add(Duration(days: 1)), //tomorrow initial date
        firstDate: now,
        lastDate: now.add(Duration(
            days: 14)), //TODO days from firebase//open for only two weeks
        helpText: "Select travelling date");
  }

  /*** 
   * PASSENGER INFO CODE START
   */

  void savePassengerInfo(BuildContext context) {
    Navigator.of(context).pushNamed(applyCouponPage);
  }

  /**
   * COUPON ACTIVITY CODE START
   */
  bool agreeTerms = false;

  updateAgreeTerms(bool value) {
    agreeTerms = value;
    notifyListeners();
  }

  couponProceedButton(BuildContext context) async {
    if (!agreeTerms) {
      final snackBar = SnackBar(
          content: Text(
              'You need to agree to our terms and conditions before you can proceed'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    final response = await ApiCalls().postBooking(booking.toJson());

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
    }
  }
}

enum CurrentBookingStatus { Departure, Arrival }
