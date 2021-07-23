import 'dart:convert';

import 'package:Libmot_Mobile/models/check_booking_details_response_model.dart';
import 'package:Libmot_Mobile/services/networking/api_calls.dart';
import 'package:flutter/cupertino.dart';

class BookingStatusRepository with ChangeNotifier {
  BookingStatusState status = BookingStatusState.notSearching;
  CheckBookingDetailsResponse bookingResponse = CheckBookingDetailsResponse();
  Future getBookingStatus(String bookingRef) async {
    final response = await ApiCalls().checkBookingStatus(bookingRef);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
      bookingResponse = CheckBookingDetailsResponse.fromJson(responseData);
      status = BookingStatusState.searchingDone;
      notifyListeners();
    } else {
      return null;
    }
  }
}

enum BookingStatusState { notSearching, searchingDone }
