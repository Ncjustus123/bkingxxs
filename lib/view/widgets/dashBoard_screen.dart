import 'package:Libmot_Mobile/Reusables/constants.dart';
import 'package:Libmot_Mobile/Reusables/ui_reusables.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreen createState() => _DashBoardScreen();
}

class _DashBoardScreen extends State<DashBoardScreen> {
  double xOffset = 0;
  double yOffset = 0;

  bool isDrawerOpen = false;

  static final getTicketPage = "/bookASeat";
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(isDrawerOpen ? 0.90 : 1.00)
        ..rotateZ(isDrawerOpen ? -50 : 0),
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/Lekki-Ikoyi Link Bridge 1.png"),
          fit: BoxFit.cover,
        ),
        // color: Colors.white,
        borderRadius:
            isDrawerOpen ? BorderRadius.circular(40) : BorderRadius.circular(0),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  isDrawerOpen
                      ? GestureDetector(
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          onTap: () {
                            setState(() {
                              xOffset = 0;
                              yOffset = 0;
                              isDrawerOpen = false;
                            });
                          },
                        )
                      : GestureDetector(
                          child: Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                          onTap: () {
                            setState(() {
                              xOffset = 290;
                              yOffset = 80;
                              isDrawerOpen = true;
                            });
                          },
                        ),
                  Padding(
                    padding: const EdgeInsets.only(right: 90, left: 0),
                    child: Image.asset(
                      "images/LIBMOT LOGO 1.png",
                      height: 40,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Column(
              children: <Widget>[
                Row(
                  children: [
                    Expanded(
                      child: ReusableCard(
                        colour: kRed,
                        onPressed: () {
                          Navigator.of(context).pushNamed(getTicketPage);
                        },
                        cardChild: Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(
                              Icons.airport_shuttle,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Ticket Booking",
                            style: textStyle,
                          ),
                        ]),
                      ),
                    ),
                    Expanded(
                      child: ReusableCard(
                        colour: kGrey,
                        cardChild: Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(
                              Icons.bus_alert,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Hire A Bus",
                            style: textStyle,
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ReusableCard(
                        colour: Colors.green,
                        cardChild: Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(
                              Icons.support_agent,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Become An Agent",
                            style: textStyle,
                          ),
                        ]),
                      ),
                    ),
                    Expanded(
                      child: ReusableCard(
                        colour: Colors.blue,
                        cardChild: Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(
                              Icons.settings_applications_rounded,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Copper Wee",
                            style: textStyle,
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ReusableCard(
                        colour: Colors.yellow[700],
                        cardChild: Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              "images/Libmot Express Logo 1.png",
                              height: 40,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Libmot Express",
                            style: textStyle,
                          ),
                        ]),
                      ),
                    ),
                    Expanded(
                      child: ReusableCard(
                        colour: Colors.grey[300],
                        cardChild: Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(
                              Icons.drive_eta_rounded,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Libmot Drive",
                            style: textStyle,
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 500,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Item1 extends StatelessWidget {
  final Widget name;
  Item1(this.name);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.3, 1],
              colors: [Color(0xff5f2c82), Color(0xff49a09d)]),
        ),
        child: name,
      ),
    );
  }
}

class Item2 extends StatelessWidget {
  static final busHirePage = "/busHire";
  final Widget name;
  Item2(this.name);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(busHirePage);
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
                0.3,
                1
              ],
              colors: [
                Color(0xffff4000),
                Color(0xffffcc66),
              ]),
        ),
        child: name,
      ),
    );
  }
}

class Item3 extends StatelessWidget {
  static final busHirePage = "/busHire";
  final Widget name;
  Item3(this.name);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(busHirePage);
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.3, 1],
              colors: [Color(0xff5f2c00), Color(0xff49a09d)]),
        ),
      ),
    );
  }
}
