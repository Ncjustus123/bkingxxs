import 'dart:convert';

import 'package:Libmot_Mobile/models/booking_model.dart';
import 'package:Libmot_Mobile/models/destination_terminal.dart';
import 'package:Libmot_Mobile/models/get_buses_model.dart';
import 'package:Libmot_Mobile/models/get_buses_response.dart';
import 'package:Libmot_Mobile/models/get_route.dart';
import 'package:Libmot_Mobile/models/post_booking_response.dart';
import 'package:Libmot_Mobile/view/widgets/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';
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
  Buses departureSelectedBus = new Buses();
  Buses arrivalSelectedBus = new Buses();

  GetRouteModel getRouteModel;
  DestinationTerminalModel destinationTerminalModel;

  GetBusesModel model;
  GetBusesResponseModel getBusesResponseModel;
  PostBookingResponse postBookingResponse;
  int triptype;
  String guid;
  int routeid;

  String name;

  addAdult() {
    getBuses.numberOfAdults++;
    notifyListeners();
  }

  addChildren() {
    if (getBuses.numberOfChildren < 2) {
      getBuses.numberOfChildren++;
    }
    notifyListeners();
  }

  notifyListeners();

  subtractAdult() {
    if (getBuses.numberOfAdults != 0) getBuses.numberOfAdults--;
    notifyListeners();
  }

  subtractChildren() {
    if (getBuses.numberOfChildren != 0) getBuses.numberOfChildren--;
    notifyListeners();
  }

  countButton({BuildContext context, icon, onTap}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        elevation: 1.5,
        shape: CircleBorder(),
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  offset: Offset(0.5, 0.9),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                  child: Icon(
                icon,
                color: Theme.of(context).primaryColor,
                size: 20,
              )),
            ),
          ),
        ),
      ),
    );
  }

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
    print('gbntyen');
    print(id);
    destinationTerminalModel = null;
    notifyListeners();
    final response = await ApiCalls().getDestinationTerminals(id);
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      destinationTerminalModel =
          DestinationTerminalModel.fromJson(responseData);

      notifyListeners();
    } else {
      return null;
    }
  }

  void tripTypeChange(int i) {
    getBuses.tripType = i ?? 0;
    booking.tripType = i ?? 0;
    notifyListeners();
  }

  searchBuses(_scaffoldKey, BuildContext context) async {
    booking.passengerType = 0;
    booking.bookingStatus = 1;
    booking.routeIdReturn = 0;
    booking.routeId = routeid;
    booking.seatRegistrations = guid;
    booking.tripType = triptype;
    booking.hasCoupon = false;
    booking.isGhanaRoute = false;
    booking.isSub = false;
    booking.isLoggedIn = true;

    Response response = await ApiCalls().searchBuses(getBuses.toJson());
    print(getBuses.toJson());
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(response.body);

      getBusesResponseModel = GetBusesResponseModel.fromJson(responseData);
      print(responseData);
      print(getBusesResponseModel.object.departures[0].tripId);
      if (getBusesResponseModel.object == null) {
        //depatureAvailable = false;
        Dialogs.showErrorSnackBar('Oops!',
            'There are no buses available on this route at the moment');
      } else {
        currentBookingStatus = CurrentBookingStatus.Departure;
        Navigator.of(context).pushNamed(busSearch);
      }
      //   currentBookingStatus = CurrentBookingStatus.Arrival;
      // Navigator.of(context).pushNamed(busSearch);
      print(currentBookingStatus);
    } else {
      return null;
    }
  }

  //Andriod
  Future<DateTime> showDate(context) async {
    final now = DateTime.now();
    return await showDatePicker(
        context: context,
        initialDate: now.add(Duration(days: 1)),
        //tomorrow initial date
        firstDate: now,
        lastDate: now.add(Duration(days: 14)),
        //TODO days from firebase//open for only two weeks
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
      Dialogs.showErrorSnackBar('Oops!',
          'You need to agree to our terms and conditions before you can proceed');
      // final snackBar = SnackBar(
      //     content: Text(
      //         'You need to agree to our terms and conditions before you can proceed'));
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    //TODO: CHECK IF TWENTY MINUTES HAVE NOT ELAPSED AND THE BOOKING REFERENCE IS AVAILABLE.

    // booking.passengerType = 0;
    // booking.bookingStatus = 1;
    // booking.routeIdReturn = 0;
    //booking.seatRegistrations =
    //"${getBusesResponseModel.object.departures[0].tripId}${":6"}";
    //booking.routeId = getBusesResponseModel.object.departures[0].routeId;
    // booking.isLoggedIn = true;
    // booking.isSubReturn = false;
    // booking.isSub = false;
    // booking.isGhanaRoute = false;
    // booking.hasCoupon = false;
    //  booking.paymentMethod = 5;
    // booking.passengerType = 0;
    // booking.bookingType = 2;
    // booking.gender ==
    // BookingModel model;

    final response = await ApiCalls().postBooking(booking.toJson());
    print(booking);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
      postBookingResponse = PostBookingResponse.fromJson(responseData);

      //TODO: end the first dialog box

      //show dialog box
      Navigator.of(context).pushNamed("/paymentpage");
    }
  }

// payWithPaystack(BuildContext context) {
//   showDialog(context: context, builder: (context) => PaymentPaystack());
// }

  beginFlutterwavePayment(BuildContext context, String amount, String email,
      String fullName, String txref, String phoneNumber) async {
    final Flutterwave flutterwave = Flutterwave.forUIPayment(
      context: context,
      //encryptionKey: baseInstance.base.flutterwaveEncryptionKey,
      encryptionKey: "26c03b274b07e6a19b179978",
      //publicKey: baseInstance.base.flutterwavePublicKey,
      publicKey: "FLWPUBK-add64679c55bac888696922e372cecb5-X",
      currency: "NGN",
      amount: "50",
      email: email,
      fullName: fullName,
      txRef: txref,
      isDebugMode: false,
      phoneNumber: phoneNumber,
      acceptCardPayment: true,
      acceptUSSDPayment: true,
      acceptAccountPayment: true,
    );

    try {
      final ChargeResponse response =
          await flutterwave.initializeForUiPayments();
      if (response == null) {
        // user didn't complete the transaction.
        print("transaction not complete");
      } else {
        final isSuccessful = checkPaymentIsSuccessful(
          response,
          "NGN",
          amount,
          txref,
        );
        if (isSuccessful) {
          print("Successful");
          // provide value to customer
        } else {
          // check message
          print(response.message);
          // check status
          print(response.status);

          // check processor error
          print(response.data.processorResponse);
        }
      }
    } catch (error, stacktrace) {
      // handleError(error);
      print(error);
      print(stacktrace);
    }
  }

  bool checkPaymentIsSuccessful(final ChargeResponse response, String currency,
      String amount, String txref) {
    return response.data.status == FlutterwaveConstants.SUCCESSFUL &&
        response.data.currency == currency &&
        response.data.amount == amount &&
        response.data.txRef == txref;
  }
}

enum CurrentBookingStatus { Departure, Arrival }
