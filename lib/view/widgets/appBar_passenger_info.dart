import 'package:Libmot_Mobile/Reusables/constants.dart';
import 'package:Libmot_Mobile/models/get_buses_response.dart';
import 'package:Libmot_Mobile/repository/booking_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar() : preferredSize = Size.fromHeight(100);
  @override
  final Size preferredSize;

  _CustomAppBarState createState() => _CustomAppBarState();
}

//  int index;
List<Buses> bus;
BookingRepository booking;
int index;

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    booking = Provider.of<BookingRepository>(context);
    int totalTravellers =
        booking.getBuses.numberOfChildren + booking.getBuses.numberOfAdults;
    double estimatedAdultfare = (booking.getBusesResponseModel.object.tripType == 0)
        ? booking.getBuses.numberOfAdults *
            booking.departureSelectedBus.adultFare
        : booking.getBuses.numberOfAdults *
                booking.departureSelectedBus.adultFare +
            booking.getBuses.numberOfAdults *
                booking.arrivalSelectedBus.adultFare;
    double estimateChildfare =(booking.getBusesResponseModel.object.tripType == 0)
        ? booking.getBuses.numberOfChildren *
            booking.departureSelectedBus.childFare
        : booking.getBuses.numberOfChildren *
                booking.departureSelectedBus.childFare +
            booking.getBuses.numberOfChildren *
                booking.arrivalSelectedBus.childFare;

    double totalEstimate = estimatedAdultfare + estimateChildfare;
    booking.totalestimate = totalEstimate;
    booking.totalTravellers = totalTravellers;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).primaryColor,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  spreadRadius: 3,
                  blurRadius: 3,
                  color: Colors.grey.withOpacity(0.3),
                  offset: Offset(2, 3))
            ]),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Text(
                    booking.departureSelectedBus.routeName,
                    style: textStyle,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      fadedContainer(
                        context: context,
                        title: booking.getBuses.numberOfChildren > 0
                            ? "$totalTravellers Traveller(s)"
                            : "${booking.getBuses.numberOfAdults} Traveller(s)",
                        bottom: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.people,
                              size: 27,
                              color: Colors.white,
                            ),
                            Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 15,
                            ),
                          ],
                        ),
                      ),
                      BelowWidget(
                        title: "Departure Date",
                        time: booking.getBuses.departureDate,
                        icon: Icon(
                          Icons.event_outlined,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    children: [
                      fadedContainer(
                          title: 'Fare price',
                          context: context,
                          bottom: Text(
                            "${getNairaSign()}${totalEstimate}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: "Monserrat"),
                          )),
                      BelowWidget(
                        title: "Departure Time",
                        icon: Icon(
                          Icons.access_time_outlined,
                          color: Colors.white,
                          size: 25,
                        ),
                        time: booking.departureSelectedBus.departureTime,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget fadedContainer({BuildContext context, bottom, title}) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 12, 10, 8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.5)),
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ],
          ),
          bottom
        ],
      ),
    );
  }
}

class BelowWidget extends StatelessWidget {
  final String title;
  final String time;
  final Widget icon;

  const BelowWidget({
    this.title,
    this.time,
    this.icon,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: icon,
          ),
          SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
                Text(
                  time,
                  style: TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
