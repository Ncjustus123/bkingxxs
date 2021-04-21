import 'package:Libmot_Mobile/models/get_buses_response.dart';
import 'package:Libmot_Mobile/repository/booking_repository.dart';
import 'package:Libmot_Mobile/view/widgets/select_bus_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SelectBusPage extends StatelessWidget {
  BookingRepository booking;
  //CurrentBookingStatus currentBookingStatus;
  List<Buses> bus;

  @override
  Widget build(BuildContext context) {
    booking = Provider.of<BookingRepository>(context);
    
    (booking.currentBookingStatus.index == 0)
        ? bus = booking.getBusesResponseModel.object.departures
        : bus = booking.getBusesResponseModel.object.arrivals;

    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: ListView.builder(
            itemCount: bus.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SelectBus(
                index: index,
                bus: bus[index],
              );
            }));
  }
}
