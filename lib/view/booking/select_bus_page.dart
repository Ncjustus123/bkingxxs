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

    booking = Provider.of<BookingRepository>(context);
    (booking.currentBookingStatus.index == 0)
        ? bus = booking.getBusesResponseModel.object.departures
        : bus = booking.getBusesResponseModel.object.arrivals;

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          width: _width,
          height: _height,
          child: Column(
            children: [
              myAppBar(context, 'Available Buses'),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(45))),
                  child: ListView.builder(
                      itemCount: bus.length,
                      padding: EdgeInsets.all(0),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        booking.departureSelectedBus = bus[index];
                        return SelectBus(
                          index: index,
                          bus: bus[index],
                          noOfChildren: booking.getBuses.numberOfChildren,
                        );
                      }),
                ),
              ),
            ],
          ),
        ));
  }
}
