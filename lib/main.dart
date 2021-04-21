import 'package:Libmot_Mobile/repository/agent_provider.dart';
import 'package:Libmot_Mobile/repository/booking_status_repository.dart';
import 'package:Libmot_Mobile/repository/hire_bus_repository.dart';
import 'package:Libmot_Mobile/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'repository/booking_repository.dart';
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
        ChangeNotifierProvider(
          create: (_) => BookingRepository(),
        ),
        ChangeNotifierProvider(
          create: (_) => HireBusRepository(),
        ),
        ChangeNotifierProvider(
          create: (_) => BookingStatusRepository()),
        ChangeNotifierProvider(
          create: (_) => AgentProvider()),
      ],
      child: MaterialApp(
        title: "Libmot Mobile",
        initialRoute: "initial",
        onGenerateRoute: routes,
      ),
    );
  }
}
