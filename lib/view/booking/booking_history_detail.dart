import 'package:Libmot_Mobile/Reusables/appBar.dart';
import 'package:Libmot_Mobile/Reusables/buttons.dart';
import 'package:Libmot_Mobile/controllers/booking_status_repository.dart';
import 'package:Libmot_Mobile/controllers/user_repository.dart';
import 'package:Libmot_Mobile/view/dasboard_view/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingHistoryDetail extends StatefulWidget {
  @override
  _BookingHistoryDetailState createState() => _BookingHistoryDetailState();
}

class _BookingHistoryDetailState extends State<BookingHistoryDetail> {
  String route = '';
  String seatNumber = '';
  String reference = '';
  String time = '';
  String departureDate = '';
  String arrivalDate = '';
  String amount = '';
  String name = '';
  String phone = '';
  String status = '';
  String nextOfKinName = '';
  String bookingType = '';
  UserRepository user;
  var historyItem = [];

  @override
  void initState() {
    var argument = Get.arguments;
    print(argument);
    if (argument != null) {
      var history = argument['history'];
      setState(() {
        route = history['routeName'].toString();
        seatNumber = history['seatNumber'].toString();
        reference = history['bookingReferenceCode'].toString();
        time = history['departureTime'].toString();
        departureDate = history['departureDate'].toString();
        arrivalDate = history['arrivalDate'].toString();
        amount = history['amount'].toString();
        name = history['fullName'].toString();
        phone = history['phoneNumber'].toString();
        status = history['status'].toString();
        nextOfKinName = history['nextOfKinName'].toString();
        bookingType = history['bookingType'].toString();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        width: _width,
        height: _height,
        child: Column(
          children: [
            myAppBar(context, '$route'),
            Expanded(
              child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(45))),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                'BOOKING DETAIL',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              Text(
                                '$bookingType',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                        detailItem('Departure Terminal',
                            '${SplitTerminal.getInitials(route)}'),
                        detailItem('Arrival Terminal',
                            '${SplitTerminal.getLast(route)}'),
                        detailItem('Departure Date', departureDate),
                        detailItem('Arrival Date', arrivalDate),
                        detailItem('Time', time),
                        detailItem('Seat Number', seatNumber),
                        detailItem('Phone Number', phone),
                        detailItem('Name', name),
                        detailItem('Next of Kin', nextOfKinName),
                        detailItem('Reference code', reference),
                        detailItem('Status', status),
                        SizedBox(height: 25),

                        Buttons.coloredButton(
                            context: context,
                            title: 'Go Home',
                            onTap: () {
                              Get.to(() => DashboardPage());
                            }),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Have any complain?",
                                style: TextStyle(color: Colors.black54),
                              ),
                              TextSpan(
                                text: " Reach us.",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Padding detailItem(title, desc) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Row(
        children: [
          Expanded(child: Text('$title')),
          Expanded(
              child: Text(
            '$desc',
            textAlign: TextAlign.justify,
            style: TextStyle(fontWeight: FontWeight.w600),
          )),
        ],
      ),
    );
  }
}
