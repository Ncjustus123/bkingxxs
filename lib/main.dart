import 'package:Libmot_Mobile/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserRepository(),
        ),
      ],
      child: MaterialApp(
        title: "Libmot Mobile",
        initialRoute: "initial",
        onGenerateRoute: routes,
      ),
    );
  }
}
