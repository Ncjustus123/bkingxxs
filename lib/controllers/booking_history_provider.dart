

import 'package:Libmot_Mobile/constants/dialogs/dialog.dart';
import 'package:Libmot_Mobile/controllers/booking_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Libmot_Mobile/constants/dialogs/dialog.dart';
import 'package:provider/provider.dart';
class FireCore extends StatelessWidget {
  BookingRepository booking;

  @override
  Widget build(BuildContext context) {
    booking = Provider.of<BookingRepository>(context);
    return  SafeArea(
       child: StreamBuilder(
         stream: FirebaseFirestore.instance.collection("courses").snapshots(),
         builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
           if(!snapshot.hasData){
             return Center(
               child: CircularProgressIndicator(),
             );
           }
           return ListView(
             children:snapshot.data.docs.map((documents) {
               booking.time = Image.network(documents['img']);
               return Center(
                 child: Center(
                   child: Container(
                     width: 700,
                     height: 700,
                     child: Image.network(documents['img']),
                   ),
                 ),
               );
             }).toList(),
           );
         },
       ),
    );
  }
  
  
}


