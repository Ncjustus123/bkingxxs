import 'dart:convert';

import 'package:Libmot_Mobile/Reusables/appBar.dart';
import 'package:Libmot_Mobile/Reusables/buttons.dart';
import 'package:Libmot_Mobile/Reusables/text_field.dart';
import 'package:Libmot_Mobile/constants/constants.dart';
import 'package:Libmot_Mobile/constants/dialogs/dialog.dart';
import 'package:Libmot_Mobile/controllers/booking_repository.dart';
import 'package:Libmot_Mobile/controllers/booking_status_repository.dart';
import 'package:Libmot_Mobile/models/check_booking_details_response_model.dart';
import 'package:Libmot_Mobile/services/networking/api_calls.dart';
import 'package:Libmot_Mobile/view/dasboard_view/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CheckBooking extends StatefulWidget {
  @override
  _CheckBookingState createState() => _CheckBookingState();
}

class _CheckBookingState extends State<CheckBooking> {
  final bookingRefController = TextEditingController();

  final _bookingForm = GlobalKey<FormState>();
  bool loading = true;
  BookingStatusRepository checkBooking;

  // @override
  // void initState() {
  //   checkBooking.status = BookingStatusState.notSearching;
  //   super.initState();
  // }
  // DF2CBE57TAG
//19B7A413OAG

  @override
  Widget build(BuildContext context) {
    checkBooking = Provider.of<BookingStatusRepository>(context);
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    // checkBooking.status = BookingStatusState.notSearching;
// print('checkBooking.status');
// print(checkBooking.status);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        width: _width,
        height: _height,
        child: Column(
          children: [
            myAppBar(context, 'Booking Status'),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(23.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(45))),
                child: SingleChildScrollView(
                    child: loading
                        ? Column(
                            children: [
                              Form(
                                key: _bookingForm,
                                child: InputFormField(
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    controller: bookingRefController,
                                    label: 'Booking Reference',
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please put in your booking reference code';
                                      }
                                      return null;
                                    }),
                              ),
                              SizedBox(height: 30),
                              Buttons.coloredButton(
                                  context: context,
                                  title: "Search",
                                  onTap: () {
                                    if (_bookingForm.currentState.validate()) {
                                      getBookingStatus(
                                          bookingRefController.text);
                                    }
                                  })
                            ],
                          )
                        : Column(
                            children: [
                              SizedBox(height: 10),
                              getRow("Referral Code",
                                  bookingResponse.object.bookingReferenceCode),
                              divider,
                              getRow("Name:", bookingResponse.object.fullName),
                              divider,
                              getRow(
                                  "Route:", bookingResponse.object.routeName),
                              divider,
                              getRow("Travel Date:", date),
                              divider,
                              getRow("Time:", time),
                              divider,
                              getRow("Fare:",
                                  "${getNairaSign()}${bookingResponse.object.amount}"),
                              SizedBox(height: 40),
                              Buttons.coloredButton(
                                context: context,
                                title: "Back to Homepage",
                                onTap: () {
                                  Get.offAll(() => DashboardPage());
                                },
                              ),
                            ],
                          )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String date;
  String time;
  CheckBookingDetailsResponse bookingResponse = CheckBookingDetailsResponse();

  Future getBookingStatus(String bookingRef) async {
    showFetchingData('Checking booking status');

    final response = await ApiCalls().checkBookingStatus(bookingRef);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
      if (responseData['code'] == '400') {
        EasyLoading.dismiss();

        Dialogs.showErrorSnackBar('Error!', 'Invalid Reference code');
      } else {
        setState(() {
          bookingResponse = CheckBookingDetailsResponse.fromJson(responseData);
          loading = false;
        });
         print("mn");
        print(bookingResponse.object.dateCreated);

        var parsedtime = DateTime.parse(bookingResponse.object.dateCreated);
        date = DateFormat('yMMMd').format(parsedtime).toString();
        time = DateFormat('jm').format(parsedtime).toString();

        EasyLoading.dismiss();
      }
    } else {
      EasyLoading.dismiss();

      Dialogs.showErrorSnackBar('Error!', 'Invalid Reference code');
      return null;
    }
  }

  getRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text(title)),
          SizedBox(width: 10),
          Expanded(
              flex: 2,
              child: Text(
                value,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,fontFamily: "Monserrat",),
              )),
        ],
      ),
    );
  }

  Widget divider = const Divider();
}
