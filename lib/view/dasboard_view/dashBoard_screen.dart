import 'package:Libmot_Mobile/constants/constants.dart';
import 'package:Libmot_Mobile/constants/dialogs/dialog.dart';
import 'package:Libmot_Mobile/services/firebase/firecore.dart';
import 'package:Libmot_Mobile/controllers/theme_provider.dart';
import 'package:Libmot_Mobile/view/Agent/agent.dart';
import 'package:Libmot_Mobile/view/booking/book_a_seat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DashBoardScreen extends StatefulWidget {
  DashBoardScreen({@required this.name});

  final String name;

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
                Get.isDarkMode
                    ? Color(0x0000000).withOpacity(0.8)
                    : Color(0xFFFFFFF).withOpacity(0.2),
                BlendMode.srcOver),
          ),
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
                                size: 32,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                xOffset = 360;
                                yOffset = 90;
                                isDrawerOpen = true;
                              });
                            },
                          ),
                    Text(
                      "",
                      style: TextStyle(color: Colors.white),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     Get.isDarkMode
                    //         ? Get.changeTheme(MyThemes.lightTheme)
                    //         : Get.changeTheme(MyThemes.darkTheme);
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                    //     child: Get.isDarkMode
                    //         ? Image.asset(
                    //             'icons/dark_mode.png',
                    //             color: Colors.white,
                    //             height: 35,
                    //             width: 35,
                    //           )
                    //         : Image.asset(
                    //             'icons/light_mode.png',
                    //             color: Colors.white,
                    //             height: 35,
                    //             width: 35,
                    //           ),
                    //   ),
                    // ),
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
                              'Hello ${toBeginningOfSentenceCase(widget.name) ?? 'Guest'}',
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
                                color: Theme.of(context).primaryColor,
                                title: 'Ticket Booking',
                                onTap: () {
                                  Get.to(() => BookASeatPage(),
                                      arguments: {'nyscOption': "general"});
                                },
                                icon: Icon(
                                  Icons.airport_shuttle_outlined,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                              SizedBox(width: 15),
                              dashboardCard(
                                context: context,
                                color: Colors.grey[600],
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
                                color: Color(0xFF0B5475),
                                title: 'Become an Agent',
                                onTap: () {
                                  Get.to(AgentPage());
                                },
                                icon: Icon(
                                  Icons.support_agent,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                              SizedBox(width: 15),
                              dashboardCard(
                                context: context,
                                color: Color(0xFF29BF12),
                                title: "Copper Wee",
                                onTap: () {
                                  Get.to(() => BookASeatPage(),
                                      arguments: {'nyscOption': "nysc"});
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
                                  launch(
                                      "https://apps.apple.com/ng/app/libmot-express-app/id1548969326");
                                },
                                icon: Image.asset(
                                  "images/Libmot Express Logo 1.png",
                                  height: 40,
                                ),
                              ),

                              // Container(
                              //   height: 165,
                              //
                              //   child: Banner(
                              //       message: "Have a nice day!", location: BannerLocation.topEnd),
                              //
                              // ),
                              SizedBox(width: 15),
                              dashboardCard(
                                context: context,
                                color: Color(0xFF3D348B),
                                title: "Libmot Drive",
                                onTap: () {
                                  Dialogs.showErrorSnackBar('Opps!',
                                      'Libmot Drive Coming Soon');
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
          margin: EdgeInsets.fromLTRB(0, 8, 0, 16),
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

@override
void paint(Canvas canvas, Size size) {
  final p1 = Offset(50, 50);
  final p2 = Offset(250, 150);
  final paint = Paint()
    ..color = Colors.black
    ..strokeWidth = 4;
  canvas.drawLine(p1, p2, paint);
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
