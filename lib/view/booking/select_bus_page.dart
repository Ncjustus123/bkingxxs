import 'package:Libmot_Mobile/Reusables/constants.dart';
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
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    booking = Provider.of<BookingRepository>(context);
    (booking.currentBookingStatus.index == 0)
        ? bus = booking.getBusesResponseModel.object.departures
        : bus = booking.getBusesResponseModel.object.arrivals;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Available ",
            style: textStyle1,
          ),
          elevation: 0,
          backgroundColor: Color(0xFFFFFFFF).withOpacity(0.9),
          leading: Icon(Icons.arrow_back_rounded, color: Colors.black),
        ),
        // backgroundColor: Colors.grey[100],
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/Lekki-Ikoyi Link Bridge 1.png"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Color(0xFFFFFFFF).withOpacity(0.9), BlendMode.srcOver),
            ),
          ),
          width: _width,
          height: _height,
          child: ListView.builder(
              itemCount: bus.length,
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
        ));
  }
}
