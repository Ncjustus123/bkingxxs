import 'package:Libmot_Mobile/repository/user_repository.dart';
import 'package:Libmot_Mobile/view/dashboard_page.dart';
import 'package:Libmot_Mobile/view/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../resources/database/user_preference.dart';

class InitialPage extends StatelessWidget {
  final String welcomeRoute = "/welcome";
  final String dashboardRoute = "/dashboard";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    user.checkLogin();
    switch (user.loggedInStatus) {
      case LoggedInStatus.LoggedIn:
        return DashboardPage();
        break;
      case LoggedInStatus.LoggedOut:
        return WelcomePage();
      default:
        return Waiting();
        break;
    }
  }
}

class Waiting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
      ),
    );
  }
}
