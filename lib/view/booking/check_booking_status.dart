import 'package:Libmot_Mobile/Reusables/appBar.dart';
import 'package:Libmot_Mobile/Reusables/buttons.dart';
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
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
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
                    child: (checkBooking.status ==
                            BookingStatusState.notSearching)
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
                              Buttons.coloredButton(
                                  context: context,
                                  title: "Search",
                                  onTap: () {
                                    if (_bookingForm.currentState.validate()) {
                                      checkBooking.getBookingStatus(
                                          bookingRefController.text);
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
                                    checkBooking.bookingResponse.object
                                        .bookingReferenceCode),
                                divider,
                                getRow(
                                    "Name:",
                                    checkBooking
                                        .bookingResponse.object.fullName),
                                divider,
                                getRow(
                                    "Route:",
                                    checkBooking
                                        .bookingResponse.object.routeName),
                                divider,
                                getRow(
                                    "Travel Date:",
                                    checkBooking
                                        .bookingResponse.object.dateCreated),
                                divider,
                                getRow(
                                    "Time:",
                                    checkBooking
                                        .bookingResponse.object.dateCreated),
                                divider,
                                getRow(
                                    "Fare:",
                                    checkBooking.bookingResponse.object.amount
                                        .toString()),
                                Buttons.coloredButton(
                                  context: context,
                                  title: "Back to Homepage",
                                  onTap: () {
                                    //TODO: pushRelacement to homepage
                                  },
                                ),
                              ],
                            ),
                          )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,10,0,10),
      child: Row(
        children: [
          Expanded(flex:1,child: Text(title)),
          SizedBox(width: 10),
          Expanded(flex:2,child: Text(value,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),)),
        ],
      ),
    );
  }

  Widget divider = const Divider();
}
