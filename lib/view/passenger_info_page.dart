import 'package:Libmot_Mobile/repository/seat_selection_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PassengerInfoPage extends StatelessWidget {
  List<String> genderType = [
    'Male',
    'Female',
  ];
  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 5,
          backgroundColor: Colors.black,
          bottom: PreferredSize(
            child: Container(
              height: 60,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "hdh",
                        style: TextStyle(color: Colors.green),
                      ),
                      Text(
                        "hdh",
                        style: TextStyle(color: Colors.green),
                      ),
                      Spacer(),
                      Text(
                        "hdh",
                        style: TextStyle(color: Colors.green),
                      ),
                      Text(
                        "hdh",
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                  Divider(
                    height: 3,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            Container(
              height: 500,
              width: 400,
              color: Colors.yellow,
              child: Column(children: [
                TextField(),
                TextField(),
               DropdownButtonFormField<String>(
                 items: genderType.map((dynamic value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                 }).toList(),
                 onChanged: (_){},

               ),
                TextField(),
                TextField(),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
