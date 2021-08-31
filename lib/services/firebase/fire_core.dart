

import 'package:Libmot_Mobile/constants/dialogs/dialog.dart';
import 'package:Libmot_Mobile/controllers/booking_repository.dart';
import 'package:Libmot_Mobile/controllers/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Libmot_Mobile/constants/dialogs/dialog.dart';
import 'package:provider/provider.dart';
class FireCore extends StatelessWidget {
  UserRepository user;
  BookingRepository booking;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserRepository>(context);
    booking = Provider.of<BookingRepository>(context);
    return  Container(
      height: MediaQuery.of(context).size.height*0.5,
      width: MediaQuery.of(context).size.width*0.8,
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
              print("object");
              print(documents['calender_max']);
              booking.time = documents['calender_max'];
              user.image =Image.network(documents['img']);
              return
                  Image.network(documents['img'],fit: BoxFit.fitHeight,);
            }).toList(),
          );
        },
      ),
    );
  }
  
  
}


