import 'package:Libmot_Mobile/constants/dialogs/dialog.dart';
import 'package:Libmot_Mobile/services/firebase/firecore.dart';
import 'package:Libmot_Mobile/controllers/theme_provider.dart';
import 'package:Libmot_Mobile/controllers/user_repository.dart';
import 'package:Libmot_Mobile/view/dasboard_view/dashBoard_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Libmot_Mobile/view/dasboard_view/drawer_screen.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:Libmot_Mobile/controllers/booking_repository.dart';

// ignore: must_be_immutable
class DashboardPage extends StatefulWidget {
  static final forgotPasswordPage = "/forget_password";

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  DateTime currentBackPressTime;
  UserRepository user;
  buildDialog(context) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => Container(height:MediaQuery.of(context).size.height,child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FireCore(),
        ],
      )),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 3)).then((_) => buildDialog(context));
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Container(
          child: Stack(
            children: [
              DrawerScreen(
                name: user.profile != null
                    ? '${user.profile.object.firstName} ${user.profile.object.lastName}'
                    : 'Guest',
              ),
              DashBoardScreen(
                name: user.profile != null
                    ? user.profile.object.firstName ?? 'Guest'
                    : 'Guest',
              ),
            
            ],
          ),
        ),
      ),
    );
    
  }
   

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            new Text(
              "Are you sure you want to exit",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 20,
            ),
            ElevatedButton(
              onPressed: () {
                print("tapped");
                SystemNavigator.pop();
              },
              child: Text("Yes",
                  style: TextStyle(
                      color: MyThemes.darkTheme != null
                          ? Colors.white
                          : Colors.black)),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColor)),
            ),
          ],
        ),
        backgroundColor: Colors.black,
      ));
      return Future.value(false);
    }
    return Future.value(true);
  }
}
