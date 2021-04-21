import 'package:Libmot_Mobile/repository/user_repository.dart';
import 'package:Libmot_Mobile/view/dashboard_page.dart';
import 'package:Libmot_Mobile/view/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);

    user.checkLogin(context);
    return Scaffold(
      body: Container(
        color: Colors.red,
      ),
    );
  }
}
