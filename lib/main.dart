import 'package:Libmot_Mobile/repository/agent_provider.dart';
import 'package:Libmot_Mobile/repository/booking_status_repository.dart';
import 'package:Libmot_Mobile/repository/coupon_repository.dart';
import 'package:Libmot_Mobile/repository/hire_bus_repository.dart';
import 'package:Libmot_Mobile/repository/seat_selection_repository.dart';
import 'package:Libmot_Mobile/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'repository/booking_repository.dart';
import 'routes.dart';
import 'package:Libmot_Mobile/repository/theme_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    //final themeProvider = Provider.of<ThemeProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserRepository()),
        ChangeNotifierProvider(create: (_) => BookingRepository()),
        ChangeNotifierProvider(create: (_) => HireBusRepository()),
        ChangeNotifierProvider(create: (_) => BookingStatusRepository()),
        ChangeNotifierProvider(create: (_) => AgentProvider()),
        ChangeNotifierProvider(create: (_) => SeatSelectionRepository()),
        ChangeNotifierProvider(create: (_) => CouponRepository()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      
      child: GetMaterialApp(
        defaultTransition: Transition.upToDown,
        theme: MyThemes.lightTheme,
        debugShowCheckedModeBanner: false,
        title: "Libmot Mobile",
        initialRoute: "initial",
        themeMode: ThemeProvider().themeMode,
        darkTheme: MyThemes.darkTheme,
        onGenerateRoute: routes,
        builder: EasyLoading.init(),
      ),
    );
  }
}
