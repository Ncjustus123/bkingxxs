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
    return Container(
      padding: EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 10),
      color: Colors.red,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              right: 200,
            ),
            child: Text(
              booking.departureSelectedBus.routeName,
              style: textStyle,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FadedContainer(),
              SizedBox(
                width: 10,
              ),
              FadedContainer(),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: BelowWidget(
                  title: "Depature Date",
                  time: booking.getBuses.departureDate,
                  icon: Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ),
              Expanded(
                child: BelowWidget(
                  title: "Depature Time",
                  icon: Icon(
                    Icons.access_time_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
                  time: booking.departureSelectedBus.departureTime,
                ),
              ),
            ],
          ),
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
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: icon,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textStyle,
              ),
              Text(
                time,
                style: textStyle,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class FadedContainer extends StatelessWidget {
  final String numberoftravellers;
  final Widget icon;
  final Widget icons;
  const FadedContainer({
    this.numberoftravellers,
    this.icon,
    this.icons,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white.withOpacity(0.1),
        child: Column(
          children: [
            Text(numberoftravellers?? ""),
            Row(
              children: [
                icon??Container(),
                icons??Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
