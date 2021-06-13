import 'package:Libmot_Mobile/Reusables/constants.dart';
import 'package:Libmot_Mobile/models/get_buses_response.dart';
import 'package:Libmot_Mobile/repository/booking_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar() : preferredSize = Size.fromHeight(100);
  @override
  final Size preferredSize;
  _CustomAppBarState createState() => _CustomAppBarState();
}

//  int index;
List<Buses> bus;
BookingRepository booking;
int index;

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context ) {
    booking = Provider.of<BookingRepository>(context);
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 5,
      backgroundColor: Colors.red,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Container(
          height: 60,
          child: Column(
            children: [
              Text(booking.departureSelectedBus.routeName),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Spacer(),
                ],
              ),
              // Divider(
              //   height: 3,
              //   color: Colors.white,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
