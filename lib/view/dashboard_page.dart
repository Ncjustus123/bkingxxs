import 'package:Libmot_Mobile/view/widgets/dashBoard_screen.dart';
import 'package:flutter/material.dart';

import 'widgets/drawer_screen.dart';

// ignore: must_be_immutable
class DashboardPage extends StatefulWidget {
  static final forgotPasswordPage = "/forget_password";

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserRepository>(context);

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: Stack(
          children: [
            DrawerScreen(),
             DashBoardScreen(),
          ],
        ),
      ),
    );
  }
}

Widget helpSupport(BuildContext context) {
  return ElevatedButton(
    child: Text("Help & Support"),
    onPressed: () {
      Navigator.of(context).pushNamed("/helpSupportPage");
    },
  );
}

Widget checkBookingStatus(BuildContext context) {
  return ElevatedButton(
      child: Text("Check booking status"),
      onPressed: () {
        Navigator.of(context).pushNamed("/checkBookingStatus");
      });
}

Widget becomeAgent(BuildContext context) {
  return ElevatedButton(
    child: Text("Become an Agent"),
    onPressed: () {
      Navigator.of(context).pushNamed("/becomeAnAgentPage");
    },
  );
}

Widget signUp(BuildContext context) {
  return ElevatedButton(
    child: Text("Sign up"),
    onPressed: () {
      Navigator.of(context).pushNamed("/signUpPage");
    },
  );
}

Widget forgotPassword(BuildContext context) {
  return ElevatedButton(
    child: Text("Forgot Password"),
    onPressed: () {
      Navigator.of(context).pushNamed(DashboardPage.forgotPasswordPage);
    },
  );
}
