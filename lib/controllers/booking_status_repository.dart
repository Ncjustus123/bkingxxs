import 'dart:convert';

import 'package:Libmot_Mobile/constants/dialogs/dialog.dart';
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
      if (responseData['code'] == '400') {
        status = BookingStatusState.notSearching;
        notifyListeners();

        print('=====Error===>');
        print(responseData['code']);
        // print(status);
        print(bookingResponse);

        Dialogs.showErrorSnackBar('Error!', 'Invalid Reference code');
      } else {
        print('=====Success===>');

        bookingResponse = CheckBookingDetailsResponse.fromJson(responseData);
        // status = BookingStatusState.searchingDone;
        print(bookingResponse);
        notifyListeners();
      }
    } else {
      print('=====ErrorPrint===>');

      // status = BookingStatusState.notSearching;
      notifyListeners();

      // print(status);

      Dialogs.showErrorSnackBar('Error!', 'Invalid Reference code');
      return null;
    }
  }
}
class SplitTerminal{
static String getInitials(String inputString) {
List<String> wordList = inputString.split(" ==> ");
if (wordList.isNotEmpty) {
return wordList[0];
} else {
return ' ';
}
}

static String getLast(String inputString) {
List<String> wordList = inputString.split(" ==> ");
if (wordList.isNotEmpty) {
return wordList[1];
} else {
return ' ';
}
}}
enum BookingStatusState { notSearching, searchingDone }
