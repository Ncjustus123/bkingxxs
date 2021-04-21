
import 'package:Libmot_Mobile/models/get_buses_response.dart';
import 'package:Libmot_Mobile/repository/booking_repository.dart';
import 'package:Libmot_Mobile/repository/seat_selection_repository.dart';
import 'package:Libmot_Mobile/view/booking/passenger_info_page.dart';
import 'package:Libmot_Mobile/view/widgets/12_seater_bus.dart';
import 'package:Libmot_Mobile/view/widgets/15_seater_bus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SelectSeatPage extends StatelessWidget {
  final Buses bus;
  final String passengerInfo = "/passengerInfomation";
  SelectSeatPage({@required this.bus});
  BookingRepository booking;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  //SeatSelectionRepository seatSelection;
  @override
  Widget build(BuildContext context) {
    booking = Provider.of<BookingRepository>(context);
    //seatSelection = Provider.of<SeatSelectionRepository>(context);
    return ChangeNotifierProvider(
      create: (_) => SeatSelectionRepository(),
      child: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Consumer<SeatSelectionRepository>(
            builder: (context, seatSelection, child) => Column(
              children: [
                (bus.totalNumberOfSeats == 12)
                    ? TwelveSeaterBus(bus: bus, scaffold: _scaffoldKey)
                    : FifteenSeaterBus(bus: bus, scaffold: _scaffoldKey),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 90, right: 90),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      selectedSeat(),
                      unselectedSeat(),
                      blockedSeat(),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                ButtonTheme(
                  height: 50,
                  minWidth: 200,
                  child: ElevatedButton(
                    child: Text("data"),

                    /// validaion of seats
                    onPressed: () {
                      int numberOfBooking = booking.model.numberOfAdults +
                          booking.model.numberOfChildren;
                      if (numberOfBooking !=
                          seatSelection.selectedSeats.length) {
                        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                            content: new Text("$numberOfBooking")));
                        print('$numberOfBooking');
                        return;
                      }
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>PassengerInfoPage()));
                      //Navigator.of(context).pushNamed(passengerInfo);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  selectedSeat() {
    return Image.asset(
      'images/selected_seat.png',
      height: 45,
    );
  }

  unselectedSeat() {
    return Image.asset(
      'images/unselected_seat.png',
      height: 45,
    );
  }

  blockedSeat() {
    return Image.asset(
      'images/blocked_seat.png',
      height: 45,
    );
  }
}
