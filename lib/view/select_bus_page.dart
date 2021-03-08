import 'package:Libmot_Mobile/repository/booking_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectBusPage extends StatelessWidget {
  

  BookingRepository booking;
  @override
  Widget build(BuildContext context) {
    booking = Provider.of<BookingRepository>(context);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView.builder(
        itemBuilder: (context, index) {
            return ;
          }));
  }
}
