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

  GetRouteModel getRouteModel;
  DestinationTerminalModel destinationTerminalModel;

  GetBusesModel model;
  GetBusesResponseModel getBusesResponseModel;
  PostBookingResponse postBookingResponse;

  String name;
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

  searchBuses(_scaffoldKey, BuildContext context) async {
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
    Response response = await ApiCalls().searchBuses(getBuses.toJson());

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(response.body);

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

    final response = await ApiCalls().postBooking(booking.toJson());

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

// beginFlutterwavePayment(BuildContext context, String amount, String email,
//     String fullName, String txref, String phoneNumber) async {
//   final Flutterwave flutterwave = Flutterwave.forUIPayment(
//     context: context,
//     //encryptionKey: baseInstance.base.flutterwaveEncryptionKey,
//     encryptionKey: "26c03b274b07e6a19b179978",
//     //publicKey: baseInstance.base.flutterwavePublicKey,
//     publicKey: "FLWPUBK-add64679c55bac888696922e372cecb5-X",
//     currency: "NGN",
//     amount: "50",
//     email: email,
//     fullName: fullName,
//     txRef: txref,
//     isDebugMode: false,
//     phoneNumber: phoneNumber,
//     acceptCardPayment: true,
//     acceptUSSDPayment: true,
//     acceptAccountPayment: true,
//   );

//   try {
//     final ChargeResponse response =
//         await flutterwave.initializeForUiPayments();
//     if (response == null) {
//       // user didn't complete the transaction.
//       print("transaction not complete");
//     } else {
//       final isSuccessful = checkPaymentIsSuccessful(
//         response,
//         "NGN",
//         amount,
//         txref,
//       );
//       if (isSuccessful) {
//         print("Successful");
//         // provide value to customer
//       } else {
//         // check message
//         print(response.message);
//         // check status
//         print(response.status);

//         // check processor error
//         print(response.data.processorResponse);
//       }
//     }
//   } catch (error, stacktrace) {
//     // handleError(error);
//     print(error);
//     print(stacktrace);
//   }
// }

// bool checkPaymentIsSuccessful(final ChargeResponse response, String currency,
//     String amount, String txref) {
//   return response.data.status == FlutterwaveConstants.SUCCESSFUL &&
//       response.data.currency == currency &&
//       response.data.amount == amount &&
//       response.data.txRef == txref;
// }
}

//ios
Future<DateTime> showiosDate(
    BuildContext context, Function ondateselect) async {
  final now = DateTime.now();
  showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          color: Colors.white,
          child: CupertinoDatePicker(
            onDateTimeChanged: ondateselect,
            mode: CupertinoDatePickerMode.date,
            minimumDate: now,
            maximumDate: now.add(Duration(days: 14)),
          ),
        );
      });
}

enum CurrentBookingStatus { Departure, Arrival }
