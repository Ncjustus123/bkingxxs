import 'package:Libmot_Mobile/models/depature_terminal.dart';
import 'package:Libmot_Mobile/models/get_route.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:Libmot_Mobile/repository/booking_repository.dart';
import 'package:provider/provider.dart';
import 'package:Libmot_Mobile/Reusables/ui_reusables.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../repository/booking_repository.dart';

class BookASeatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     TextEditingController passenger = TextEditingController();
    final booking = Provider.of<BookingRepository>(context);
    booking.getAllRoute();

    //TODO: show loading screen

    return Scaffold(
        backgroundColor: Colors.grey,
        body: SafeArea(
          child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  DefaultTabController(
                        length: 2,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TabBar(
                            indicator: BubbleTabIndicator(
                                tabBarIndicatorSize: TabBarIndicatorSize.tab,
                                indicatorHeight: 35,
                                indicatorColor: Colors.red),
                            labelStyle: TextStyle(
                              fontSize: 15,
                            ),
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.black,
                            tabs: [
                              Text("oneway"),
                              Text("round trip"),
                            ],
                            onTap: (index) {
                              print('$index');

                            },
                          ),
                        ),
                      ),
                  DropdownButtonFormField<String>(
                    items: (booking.getRouteModel == null)
                        ? []
                        : booking.getRouteModel.object.items
                            .map((RouteItems route) {
                            return DropdownMenuItem<String>(
                              child: Text(route.name),
                              value: route.id.toString(),
                            );
                          }).toList(),
                    onChanged: (String id) {
                      booking.getBuses.departureTerminalId = int.parse(id);
                      booking.getDestinationTerminals(booking.getBuses.departureTerminalId);
                    },
                  ),
                  DropdownButtonFormField<String>(
                    items: (booking.depatureTerminalModel == null)
                        ? []
                        : booking.depatureTerminalModel.object
                            .map((DepatureObject object) {
                            return DropdownMenuItem<String>(
                              child: Text(object.name),
                            );
                          }).toList(),
                    onChanged: (String id) {
                      booking.getBuses.destinationTerminalId= int.parse(id);
                    },
                  ),
                  TextField(),
                  TextField(
                    controller: passenger,
                  ),
                  FlatButton(
                    onPressed: () {
                      booking.searchBuses();
                    },
                    child: Text(
                      "Proceed",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.red,
                  ),
                ],
              )),
        ));
  }
}
