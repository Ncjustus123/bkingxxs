import 'package:Libmot_Mobile/repository/user_repository.dart';
import 'package:Libmot_Mobile/view/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  static final getTicketPage = "/bookASeat";
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);

    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          children: [
            Text("DashboardPage"),
            getTicket(context),
            // hireBus(),
            // becomeAgent(),
            // corperWee(),
            // openExpress(),
            // libmotDrive(),
            logOut(user, context),
          ],
        ),
      ),
    ));
  }

  Widget getTicket(context) {
    return ElevatedButton(
      child: Text("Get a Ticket"),
      onPressed: () => Navigator.of(context).pushNamed(getTicketPage),
    );
  }

  Widget hireBus() {}

  Widget becomeAgent() {}

  Widget corperWee() {}
  Widget openExpress() {}
  Widget libmotDrive() {}

  Widget logOut(user, context) {
    return ElevatedButton(
      child: Text("Log out"),
      onPressed: () {
        user.logout();
        if (user.loggedInStatus == LoggedInStatus.LoggedOut) {
          Navigator.of(context).pushNamed("/welcome");
        }
      },
    );
  }
}
