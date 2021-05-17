import 'package:Libmot_Mobile/repository/user_repository.dart';
import 'package:Libmot_Mobile/view/dashboard_page.dart';
import 'package:Libmot_Mobile/view/welcome_page.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage>
    with AfterLayoutMixin<InitialPage> {
  UserRepository user;
  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserRepository>(context);

    return Scaffold(
      body: Container(
        color: Colors.red,
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    user.checkLogin(context);
  }
}
