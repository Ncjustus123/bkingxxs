import 'package:Libmot_Mobile/Reusables/constants.dart';
import 'package:Libmot_Mobile/Reusables/ui_reusables.dart';
import 'package:Libmot_Mobile/view/booking/book_a_seat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreen createState() => _DashBoardScreen();
}

class _DashBoardScreen extends State<DashBoardScreen> {
  double xOffset = 0;
  double yOffset = 0;

  bool isDrawerOpen = false;

  static final getTicketPage = "/bookASeat";
  static final hireAbus = "/busHire";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        setState(() {
          xOffset = 0;
          yOffset = 0;
          isDrawerOpen = false;
        });
      },
      child: AnimatedContainer(
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(isDrawerOpen ? 0.85 : 1.00)
          ..rotateZ(isDrawerOpen ? -50 : 0),
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Color(0x0000000).withOpacity(0.8), BlendMode.srcOver),
          ),
          // color: Colors.white,
          borderRadius: isDrawerOpen
              ? BorderRadius.circular(40)
              : BorderRadius.circular(0),
        ),
        child: Container(
          height: size.height,
          width: size.width,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(20, 35, 20, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    isDrawerOpen
                        ? GestureDetector(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, bottom: 8),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
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
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, bottom: 8),
                              child: Icon(
                                Icons.sort,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                xOffset = 350;
                                yOffset = 30;
                                isDrawerOpen = true;
                              });
                            },
                          ),
                    Text(
                      "",
                      style: TextStyle(color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                      child: Icon(
                        Icons.notifications_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 8),
                            child: Text(
                              'Welcome Chinedu',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              dashboardCard(
                                context: context,
                                color: Color(0xFFB8230B),
                                title: 'Ticket Booking',
                                onTap: () {
                                      Get.to(()=>BookASeatPage());
                                },
                                icon: Icon(
                                  Icons.airport_shuttle_outlined,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                              SizedBox(width: 10),
                              dashboardCard(
                                context: context,
                                color: Color(0xFF555354),
                                title: 'Hire a Bus',
                                onTap: () {
                                  Navigator.of(context).pushNamed(hireAbus);
                                },
                                icon: Icon(
                                  Icons.bus_alert,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              dashboardCard(
                                context: context,
                                color: Color(0xFF359939),
                                title: 'Become an Agent',
                                onTap: () {
                                  // Navigator.of(context).pushNamed(getTicketPage);
                                },
                                icon: Icon(
                                  Icons.support_agent,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                              SizedBox(width: 10),
                              dashboardCard(
                                context: context,
                                color: Color(0xFF0B5475),
                                title: "Copper Wee",
                                onTap: () {
                                  // Navigator.of(context).pushNamed(getTicketPage);
                                },
                                icon: Icon(
                                  Icons.stream,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              dashboardCard(
                                context: context,
                                color: Color(0xFFFCA800),
                                title: "Libmot Express",
                                onTap: () {
                                  // Navigator.of(context).pushNamed(getTicketPage);
                                },
                                icon: Image.asset(
                                  "images/Libmot Express Logo 1.png",
                                  height: 40,
                                ),
                              ),
                              SizedBox(width: 10),
                              dashboardCard(
                                context: context,
                                color: Color(0xFF95A19D),
                                title: "Libmot Drive",
                                onTap: () {
                                  // Navigator.of(context).pushNamed(getTicketPage);
                                },
                                icon: Icon(
                                  Icons.drive_eta_rounded,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 8),
                            child: Text(
                              'Welcome Chinedu',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              dashboardCard(
                                context: context,
                                color: Color(0xFFB8230B),
                                title: 'Ticket Booking',
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(getTicketPage);
                                },
                                icon: Icon(
                                  Icons.airport_shuttle_outlined,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                              SizedBox(width: 10),
                              dashboardCard(
                                context: context,
                                color: Color(0xFF555354),
                                title: 'Hire a Bus',
                                onTap: () {
                                  // Navigator.of(context).pushNamed(getTicketPage);
                                },
                                icon: Icon(
                                  Icons.bus_alert,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              dashboardCard(
                                context: context,
                                color: Color(0xFF359939),
                                title: 'Become an Agent',
                                onTap: () {
                                  // Navigator.of(context).pushNamed(getTicketPage);
                                },
                                icon: Icon(
                                  Icons.support_agent,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                              SizedBox(width: 10),
                              dashboardCard(
                                context: context,
                                color: Color(0xFF0B5475),
                                title: "Copper Wee",
                                onTap: () {
                                  // Navigator.of(context).pushNamed(getTicketPage);
                                },
                                icon: Icon(
                                  Icons.stream,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              dashboardCard(
                                context: context,
                                color: Color(0xFFFCA800),
                                title: "Libmot Express",
                                onTap: () {
                                  // Navigator.of(context).pushNamed(getTicketPage);
                                },
                                icon: Image.asset(
                                  "images/Libmot Express Logo 1.png",
                                  height: 40,
                                ),
                              ),
                              SizedBox(width: 10),
                              dashboardCard(
                                context: context,
                                color: Color(0xFF95A19D),
                                title: "Libmot Drive",
                                onTap: () {
                                  // Navigator.of(context).pushNamed(getTicketPage);
                                },
                                icon: Icon(
                                  Icons.drive_eta_rounded,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Expanded dashboardCard({BuildContext context, onTap, title, icon, color}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 165,
          margin: EdgeInsets.fromLTRB(0, 8, 8, 16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(7.0),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
              child: Padding(padding: const EdgeInsets.all(18.0), child: icon),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: textStyle,
            ),
          ]),
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
