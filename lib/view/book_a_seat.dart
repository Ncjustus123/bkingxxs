import 'package:Libmot_Mobile/models/get_route.dart';
import 'package:flutter/material.dart';
import 'package:Libmot_Mobile/repository/booking_repository.dart';
import 'package:provider/provider.dart';

import '../repository/booking_repository.dart';

class BookASeatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final booking = Provider.of<BookingRepository>(context);
    booking.getAllRoute();

    return Scaffold(
        backgroundColor: Colors.grey,
        body: Container(
            color: Colors.white,
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  items: (booking.getRouteModel  ==null)
                      ? []
                      : booking.getRouteModel.object.items
                          .map((RouteItems route) {
                          return DropdownMenuItem<String>(
                            child: Text(route.name),
                          );
                        }).toList(),
                  onChanged: (_) {},
                ),
              ],
            )));
  }
}
