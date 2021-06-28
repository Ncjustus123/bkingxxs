import 'package:Libmot_Mobile/repository/booking_repository.dart';
import 'package:Libmot_Mobile/view/widgets/appBar_passenger_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'buttons.dart';

class BottomCard extends StatefulWidget {
  // const BottomCard();
  BookingRepository booking;

  @override
  _BottomCardState createState() => _BottomCardState();
}

class _BottomCardState extends State<BottomCard> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    booking = Provider.of<BookingRepository>(context);
    return Container(
      color: Colors.transparent,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
            color: Theme.of(context).scaffoldBackgroundColor),
        height: _height * 0.5,
        width: _width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: 50,
                      height: 4,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Text(
                  'Travellers',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                SizedBox(height: 15),
                Text(
                  'Select the number of persons travelling',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    AdultOptions(
                      title: 'Adult(s)',
                    ),
                    SizedBox(width: 15),
                    ChildrenOptions(
                      title: 'Children(ren)',
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Buttons.coloredButton(
                  context: context,
                  title: 'Proceed',
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                      // Get.back();
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AdultOptions extends StatefulWidget {
  final String title;
  final String adultCount;

  const AdultOptions({
    this.title,
    this.adultCount,
  });

  @override
  _AdultOptionsState createState() => _AdultOptionsState();
}

class _AdultOptionsState extends State<AdultOptions> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        Center(
            child: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        )),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            addButton(
                context: context,
                icon: Icons.add,
                onTap: () {
                  setState(() {
                    booking.getBuses.numberOfAdults++;
                  });
                }),
            Expanded(
                child: Text(
              booking.getBuses.numberOfAdults.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            )),
            subtractButton(
                context: context,
                icon: Icons.remove,
                onTap: () {
                  setState(() {
                    booking.getBuses.numberOfAdults--;
                  });
                }),
          ],
        ),
      ],
    ));
  }
}

class ChildrenOptions extends StatefulWidget {
  final String title;

  const ChildrenOptions({
    this.title,
  });

  @override
  _ChildrenOptionsState createState() => _ChildrenOptionsState();
}

class _ChildrenOptionsState extends State<ChildrenOptions> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        Center(
            child: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        )),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            addButton(
                context: context,
                icon: Icons.add,
                onTap: () {
                  setState(() {
                    if (booking.getBuses.numberOfChildren < 2) {
                      booking.getBuses.numberOfChildren++;
                    }
                  });
                }),
            Expanded(
                child: Text(
              booking.getBuses.numberOfChildren.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            )),
            subtractButton(
                context: context,
                icon: Icons.remove,
                onTap: () {
                  setState(() {
                    if (booking.getBuses.numberOfChildren != 0)
                      booking.getBuses.numberOfChildren--;
                  });
                }),
          ],
        ),
      ],
    ));
  }
}

subtractButton({BuildContext context, icon, onTap}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Material(
      elevation: 1.5,
      shape: CircleBorder(),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                offset: Offset(0.5, 0.9),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
                child: Icon(
              icon,
              color: Theme.of(context).primaryColor,
              size: 20,
            )),
          ),
        ),
      ),
    ),
  );
}

addButton({BuildContext context, icon, onTap}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Material(
      elevation: 1.5,
      shape: CircleBorder(),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                offset: Offset(0.5, 0.9),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
                child: Icon(
              icon,
              color: Theme.of(context).primaryColor,
              size: 20,
            )),
          ),
        ),
      ),
    ),
  );
}
