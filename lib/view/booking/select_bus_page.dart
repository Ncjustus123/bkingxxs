import 'package:Libmot_Mobile/Reusables/appBar.dart';
import 'package:Libmot_Mobile/Reusables/constants.dart';
import 'package:Libmot_Mobile/models/get_buses_response.dart';
import 'package:Libmot_Mobile/repository/booking_repository.dart';
import 'package:Libmot_Mobile/view/widgets/select_bus_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'select_seat_page.dart';

// ignore: must_be_immutable
class SelectBusPage extends StatelessWidget {
  BookingRepository booking;

  //CurrentBookingStatus currentBookingStatus;
  List<Buses> bus;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    // booking = Provider.of<BookingRepository>(context);
    // (booking.currentBookingStatus.index == 0)
    //     ? bus = booking.getBusesResponseModel.object.departures
    //     : bus = booking.getBusesResponseModel.object.arrivals;

    return Scaffold(
        // appBar: AppBar(
        //   title: Text(
        //     "Available ",
        //     style: textStyle1,
        //   ),
        //   elevation: 0,
        //   backgroundColor: Color(0xFFFFFFFF).withOpacity(0.9),
        //   leading: Icon(Icons.arrow_back_rounded, color: Colors.black),
        // ),
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          width: _width,
          height: _height,
          child: Column(
            children: [
              myAppBar(context,'Available Buses'),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(45))),
                  child: ListView.builder(
                      itemCount: 4,
                     padding: EdgeInsets.all(0),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        // booking.departureSelectedBus = bus[index];
                        return InkWell(
                          onTap: () {
                            // Navigator.of(context).pushNamed(selectSeat, arguments: bus);
                          },
                          child: Card(
                            elevation: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Bus.routeName',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              letterSpacing: 0.3,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              shadows: <Shadow>[
                                                Shadow(
                                                    color:
                                                        Colors.black.withOpacity(0.4),
                                                    offset: Offset(0.3, 0.4))
                                              ]),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Departure Time: 7:80",
                                          textAlign: TextAlign.center,
                                          style: textStyleHeading,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15),
                                Row(children: [
                                  Expanded(
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'images/haice_2020.png',
                                            height: 75,
                                            //width: 70,
                                          ),

                                          //     :
                                          // Image.asset(
                                          //   'images/bus_image.png',
                                          //   height: 70,
                                          //   //width: 70,
                                          // ),
                                          SizedBox(height: 10),

                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              "hiace | AC",
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              "3 available seat(s)",
                                              style: textStyle2,
                                            ),
                                          )
                                        ]),
                                  ),
                                  Expanded(
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5,
                                                bottom: 5,
                                                right: 5,
                                                left: 50),
                                            child: Text(
                                              "\$78300 Terminal",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  decoration:
                                                      TextDecoration.lineThrough,
                                                  decorationColor: Colors.red),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5,
                                                bottom: 5,
                                                right: 5,
                                                left: 50),
                                            child: Text(
                                              "\$48783 per Adult",
                                              style: textStyle2,
                                            ),
                                          ),
                                          // (noOfChildren > 0)
                                          //     ?
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5,
                                                bottom: 5,
                                                right: 5,
                                                left: 50),
                                            child: Text(
                                              "\$7892 per child",
                                              style: textStyle2,
                                            ),
                                          ),
                                          // : SizedBox(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5,
                                                bottom: 5,
                                                right: 5,
                                                left: 50),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Get.to(()=>SelectSeatPage());
                                                // Navigator.of(context)
                                                //     .pushNamed(selectSeat, arguments: bus);
                                              },
                                              child: Text("View seat(s)"),
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.red),
                                                shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(5.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                  )
                                ]),
                              ],
                            ),
                          ),
                        );
                        //   SelectBus(
                        //   index: index,
                        //   bus: bus[index],
                        //   noOfChildren: booking.getBuses.numberOfChildren,
                        // );
                      }),
                ),
              ),
            ],
          ),
        ));
  }
}
