
import 'package:Libmot_Mobile/constants/dialogs/dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Libmot_Mobile/constants/dialogs/dialog.dart';
class FireCore extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SafeArea(
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
               return Center(
                 child: Center(
                   child: Container(
                     width: 200,
                     height: 200,
                     child: Image.network(documents['img']),
                   ),
                 ),
               );
             }).toList(),
           );
         },
       ),
     ),
    );
  }
}
