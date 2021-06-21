import 'package:Libmot_Mobile/repository/agent_provider.dart';
import 'package:Libmot_Mobile/repository/booking_status_repository.dart';
import 'package:Libmot_Mobile/repository/coupon_repository.dart';
import 'package:Libmot_Mobile/repository/hire_bus_repository.dart';
import 'package:Libmot_Mobile/repository/seat_selection_repository.dart';
import 'package:Libmot_Mobile/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        ChangeNotifierProvider(create: (_) => UserRepository()),
        ChangeNotifierProvider(create: (_) => BookingRepository()),
        ChangeNotifierProvider(create: (_) => HireBusRepository()),
        ChangeNotifierProvider(create: (_) => BookingStatusRepository()),
        ChangeNotifierProvider(create: (_) => AgentProvider()),
        ChangeNotifierProvider(create: (_) => SeatSelectionRepository()),
        ChangeNotifierProvider(create: (_) => CouponRepository()),
      ],
      child: GetMaterialApp(
        defaultTransition: Transition.upToDown,
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFEDF6FC),
          primarySwatch: Colors.red,
          primaryColor: Color(0xFFFD1919),
          accentColor: Color(0xFFE7AA07),
          fontFamily: 'Circular',
        ),
        // darkTheme: ThemeData(
        //   scaffoldBackgroundColor: Color(0xFF4D4D4D),
        //   primaryColor: Color(0xFF62010D),
        // ),
        debugShowCheckedModeBanner: false,
        title: "Libmot Mobile",
        initialRoute: "initial",
        onGenerateRoute: routes,
      ),
    );
  }
}
