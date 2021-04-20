import 'package:Libmot_Mobile/models/get_buses_response.dart';
import 'package:flutter/material.dart';

class SelectBus extends StatelessWidget {
  final String selectSeat = "/selectSeats";
  final index;
  final Buses bus;
  SelectBus({this.index, this.bus});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(selectSeat, arguments: bus);
      },
          child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bus.routeName,
              style: TextStyle(fontSize: 15),
            ),
            Row(
              children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                SizedBox(),
                Text(" Departure Time:${bus.departureTime}"),
                SizedBox(),
                Image.asset(
                  'images/haice_2020.png',
                  height: 90,
                  //width: 70,
                ),
                Text("${bus.vehicleName} | AC"),
                Text("${bus.availableNumberOfSeats} available seat(s)")
              ]),
              SizedBox(),
              Column(
                
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(" ${bus.farePrice} per child", style: TextStyle(decoration: TextDecoration.lineThrough,decorationColor: Colors.red),),
                  Text(" ${bus.farePrice} per child"),
                  Text(" ${bus.farePrice} per child"),
                  FlatButton(onPressed: (){}, child: Text("view seat"),color: Colors.red,),
                ]
              )
            ]),
          ],
        ),
      ),
    );
  }
}
