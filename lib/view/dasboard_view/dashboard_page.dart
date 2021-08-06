import 'package:Libmot_Mobile/controllers/booking_history_provider.dart';
import 'package:Libmot_Mobile/controllers/theme_provider.dart';
import 'package:Libmot_Mobile/controllers/user_repository.dart';
import 'package:Libmot_Mobile/view/dasboard_view/dashBoard_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Libmot_Mobile/view/dasboard_view/drawer_screen.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DashboardPage extends StatefulWidget {
  static final forgotPasswordPage = "/forget_password";

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  DateTime currentBackPressTime;
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
              //FireCore(),

              // StreamBuilder(
              //   stream: FirebaseFirestore.instance.collection("courses").snapshots(),
              //   builder: (context,snapshot){
              //     return ListView(
              //       children: snapshot.data.documents.map((document) {
              //         return Center(
              //           child: Container(
              //             width: MediaQuery.of(context).size.width / 1.2,
              //             height: MediaQuery.of(context).size.height / 6,
              //             child:Image.network(document['banner']),
              //           ),
              //         );
              //       }).toList(),
              //     );
                  // return ListView.builder(
                  //     itemCount: snapshot.data.documents.lenght,
                  //     itemBuilder: (context,index){
                  //       DocumentSnapshot libmot = snapshot.data.documents[index];
                  //       return Image.network(libmot['banner']);
                  //     });
                //},
              //),
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
