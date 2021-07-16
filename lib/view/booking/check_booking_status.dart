import 'package:Libmot_Mobile/controllers/booking_status_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CheckBooking extends StatelessWidget {
  final bookingRefController = TextEditingController();

  final _bookingForm = GlobalKey<FormState>();

  BookingStatusRepository checkBooking;

  @override
  Widget build(BuildContext context) {
    checkBooking = Provider.of<BookingStatusRepository>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: (checkBooking.status == BookingStatusState.notSearching)
                ? Column(
                    children: [
                      Form(
                        key: _bookingForm,
                        child: TextFormField(
                            controller: bookingRefController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please put in your email';
                              }
                              return null;
                            }),
                      ),
                      ElevatedButton(
                          child: Text("Search"),
                          onPressed: () {
                            if (_bookingForm.currentState.validate()) {
                              checkBooking
                                  .getBookingStatus(bookingRefController.text);
                            }
                          })
                    ],
                  )
                : Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        getRow(
                            "Referral Code",
                            checkBooking
                                .bookingResponse.object.bookingReferenceCode),
                        divider,
                        getRow("Name:",
                            checkBooking.bookingResponse.object.fullName),
                        divider,
                        getRow("Route:",
                            checkBooking.bookingResponse.object.routeName),
                        divider,
                        getRow("Travel Date:",
                            checkBooking.bookingResponse.object.dateCreated),
                        divider,
                        getRow("Time:",
                            checkBooking.bookingResponse.object.dateCreated),
                        divider,
                        getRow(
                            "Fare:",
                            checkBooking.bookingResponse.object.amount
                                .toString()),
                        ElevatedButton(
                          child: Text("Back to Homepage"),
                          onPressed: () {
                            //TODO: pushRelacement to homepage
                          },
                        ),
                      ],
                    ),
                  )),
      ),
    );
  }

  getRow(String title, String value) {
    return Row(
      children: [
        Text(title),
        Spacer(),
        Text(value),
      ],
    );
  }

  Widget divider = const Divider();
}
