import 'package:Libmot_Mobile/constants/constants.dart';
import 'package:Libmot_Mobile/models/get_buses_response.dart';
import 'package:Libmot_Mobile/controllers/booking_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBarTwo extends StatefulWidget implements PreferredSizeWidget {
  Buses buss;
  CustomAppBarTwo({this.buss}) : preferredSize = Size.fromHeight(100);
  @override
  final Size preferredSize;

  _CustomAppBarTwoState createState() => _CustomAppBarTwoState();
}

//  int index;
List<Buses> bus;
BookingRepository booking;
int index;

class _CustomAppBarTwoState extends State<CustomAppBarTwo> {
  @override
  Widget build(BuildContext context) {
    booking = Provider.of<BookingRepository>(context);
    double firstfare = booking.getBusesResponseModel.object.departures[0].adultFare;
    double childfirstfare = booking.getBusesResponseModel.object.departures[0].childFare;
    var busName =booking.getBusesResponseModel.object.departures;
    int totalTravellers =
        booking.getBuses.numberOfChildren + booking.getBuses.numberOfAdults;
    double estimatedAdultfare = (booking.getBusesResponseModel.object.tripType == 0)
        ? booking.getBuses.numberOfAdults *
        firstfare
        : booking.getBuses.numberOfAdults *
        booking.getBuses.numberOfAdults *
        firstfare;
    double estimateChildfare =(booking.getBusesResponseModel.object.tripType == 0)
        ? booking.getBuses.numberOfChildren *
        childfirstfare
        : booking.getBuses.numberOfChildren *
        childfirstfare+
        booking.getBuses.numberOfChildren *
            childfirstfare;

    double totalEstimates = estimatedAdultfare + estimateChildfare;
    booking.totalestimates = totalEstimates;
    booking.totalTravellers = totalTravellers;
    print("${booking.getBusesResponseModel.object.departures[0].adultFare}");
    print("${booking.getBusesResponseModel.object.departures[0].vehicleName}");
    //double firstfare = booking.getBusesResponseModel.object.departures[0].adultFare;
    var secondfare = booking.getBusesResponseModel.object.departures[1].adultFare;
    print("${booking.getBusesResponseModel.object.departures[1].adultFare}");
    print("${booking.getBusesResponseModel.object.departures[1].vehicleName}");
    print("${busName[1].vehicleName}");
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
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
                            "${getNairaSign()}${totalEstimates}",
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
