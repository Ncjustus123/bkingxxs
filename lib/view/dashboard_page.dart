import 'package:Libmot_Mobile/repository/user_repository.dart';
import 'package:Libmot_Mobile/view/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  static final getTicketPage = "/bookASeat";
  static final busHirePage = "/busHire";

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);

    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Text("DashboardPage"),
                ElevatedButton(
                  child: Text("Get a Ticket"),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(getTicketPage),
                ),
                ElevatedButton(
                    child: Text("Hire a bus"),
                    onPressed: () {
                      Navigator.of(context).pushNamed(busHirePage);
                    }),
                ElevatedButton(
                    child: Text("Libmot Drive"),
                    onPressed: () {
                      // _scaffoldKey.currentState.showSnackBar(
                      //   SnackBar(
                      //     content: Text('A SnackBar has been shown.'),
                      //   ),
                      // );
                      // print("snackbar shown");

                      // final snackBar = SnackBar(
                      //   content: Text('Libmot Drive Coming soon!'),
                      //   //backgroundColor: Colors.deepOrangeAccent,
                      // );
                      // _scaffoldKey.currentState.showSnackBar(snackBar);
                    }),
                //hireBus(),
                // becomeAgent(),
                // corperWee(),
                // openExpress(),
                // libmotDrive(context),
                ElevatedButton(
                  child: Text("Log out"),
                  onPressed: () {
                    user.logout();
                    if (user.loggedInStatus == LoggedInStatus.LoggedOut) {
                      Navigator.of(context).pushNamed("/welcome");
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }

  // Widget getTicket(context) {

  // }

  // Widget hireBus() {}

  // Widget becomeAgent() {}

  // Widget corperWee() {}
  // Widget openExpress() {}

  // Widget libmotDrive(context) {
  //   return ElevatedButton(
  //       child: Text("Libmot Drive"),
  //       onPressed: () {
  //         // _scaffoldKey.currentState.showSnackBar(
  //         //   SnackBar(
  //         //     content: Text('A SnackBar has been shown.'),
  //         //   ),
  //         // );
  //         // print("snackbar shown");

  //         // final snackBar = SnackBar(
  //         //   content: Text('Libmot Drive Coming soon!'),
  //         //   //backgroundColor: Colors.deepOrangeAccent,
  //         // );
  //         // _scaffoldKey.currentState.showSnackBar(snackBar);
  //       });
  // }

  // Widget logOut(user, context) {
  //   return
  // }
}
