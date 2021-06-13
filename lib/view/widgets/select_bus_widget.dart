import 'package:Libmot_Mobile/Reusables/constants.dart';
import 'package:Libmot_Mobile/models/get_buses_response.dart';
import 'package:flutter/material.dart';

class SelectBus extends StatelessWidget {
  final String selectSeat = "/selectSeats";
  final index;
  final Buses bus;
  final int noOfChildren;
  SelectBus({this.index, this.bus, this.noOfChildren});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(selectSeat, arguments: bus);
        },
        child: Card(
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      bus.routeName,
                      style: textStyle2,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      " Departure Time:${bus.departureTime}",
                      style: textStyle2,
                    ),
                  ],
                ),
              ),
              Row(children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(),
                      (bus.vehicleName == "Toyota (Business Class)")
                          ? Image.asset(
                              'images/haice_2020.png',
                              height: 80,
                              //width: 70,
                            )
                          : Image.asset(
                              'images/bus_image.png',
                              height: 70,
                              //width: 70,
                            ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text("${bus.vehicleName} | AC"),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text("${bus.availableNumberOfSeats} available seat(s)",style: textStyle2,),
                      )
                    ]),
                SizedBox(),
                Column(
                    
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5,bottom: 5,right: 5,left: 50),
                        child: Text(
                          " ${getNairaSign()}${bus.farePrice} \n Terminal",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.red),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5,bottom: 5,right: 5,left: 50),
                        child: Text("${getNairaSign()} ${bus.adultFare} \n per Adult",style: textStyle2,),
                      ),
                      (noOfChildren > 0)
                          ? Padding(
                            padding: const EdgeInsets.only(top: 5,bottom: 5,right: 5,left: 50),
                            child: Text(" ${getNairaSign()}${bus.childFare} \n per child",style: textStyle2,),
                          )
                          : SizedBox(),
                      Padding(
                        padding: const EdgeInsets.only(top: 5,bottom: 5,right: 5,left: 50),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(selectSeat, arguments: bus);
                          },
                          child: Text("view seat"),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                            shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ])
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
