import 'package:Libmot_Mobile/controllers/agent_provider.dart';
import 'package:Libmot_Mobile/controllers/booking_status_repository.dart';
import 'package:Libmot_Mobile/controllers/coupon_repository.dart';
import 'package:Libmot_Mobile/controllers/hire_bus_repository.dart';
import 'package:Libmot_Mobile/controllers/seat_selection_repository.dart';
import 'package:Libmot_Mobile/controllers/user_repository.dart';
import 'package:Libmot_Mobile/services/firebase/flutter_local_notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'controllers/booking_repository.dart';
import 'routes.dart';
import 'package:Libmot_Mobile/controllers/theme_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundhandeler);
  runApp(MyApp());
}

Future<void> backgroundhandeler(RemoteMessage message) async {
  LocalNotification.display(message);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LocalNotification.initilize(context);
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification.body);
      }
      //LocalNotification.display(message);
    });
    
    // final themeProvider = Provider.of<ThemeProvider>(context);
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
        defaultTransition: Transition.zoom,
        transitionDuration:Duration(milliseconds: 250),
        theme: MyThemes.lightTheme,
        debugShowCheckedModeBanner: false,
        title: "Libmot Mobile",
        initialRoute: "initial",
        themeMode:ThemeMode.system,
        darkTheme: MyThemes.darkTheme,
        onGenerateRoute: routes,
        builder: EasyLoading.init(),
      ),
    );
  }
}

