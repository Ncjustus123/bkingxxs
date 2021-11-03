import 'dart:io';

import 'package:Libmot_Mobile/controllers/agent_provider.dart';
import 'package:Libmot_Mobile/controllers/booking_status_repository.dart';
import 'package:Libmot_Mobile/controllers/coupon_repository.dart';
import 'package:Libmot_Mobile/controllers/hire_bus_repository.dart';
import 'package:Libmot_Mobile/controllers/seat_selection_repository.dart';
import 'package:Libmot_Mobile/controllers/theme_provider.dart';
import 'package:Libmot_Mobile/controllers/user_repository.dart';
import 'package:Libmot_Mobile/services/firebase/flutter_local_notification.dart';
import 'package:Libmot_Mobile/view/welcome/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';

import 'controllers/booking_repository.dart';
import 'routes.dart';

RemoteConfig config;
bool hasLogged = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  if (Platform.isIOS) {
    iOsNotification();
  }
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    runApp(MyApp());
  });
}

Future<void> backgroundHandler(RemoteMessage message) async {
  LocalNotification.display(message);
}

Future<void> checkUpdate() async {
  if (Platform.isAndroid &&
      (await InAppUpdate.checkForUpdate()).updateAvailability ==
          UpdateAvailability.updateAvailable) {
    InAppUpdate.performImmediateUpdate();
  }
}


iOsNotification() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    checkUpdate();
    // UpgradeAlert(
    //   countryCode: "NG",
    //   dialogStyle: UpgradeDialogStyle.cupertino,
    //   child: Center(child: Text("checking...")),
    // );
    LocalNotification.initilize(context);
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification.body);
        NewDialogs.showMessage(
            title: '${message.notification.title}',
            message: '${message.notification.body}');
      }

      //LocalNotification.display(message);
    });
    Future<bool> checkConfig(BuildContext context) async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = packageInfo.version;
      print("version is $version");
      if (Theme.of(context).platform == TargetPlatform.android) {
        String currentVersion = config.getString("current_android_version");
        bool isMandatory = config.getBool("android_update_mandatory");
        if (!config.getBool("android_active")) {
        }
        if (!isUserAppCurrent(version, currentVersion)) {
          // show dialog
          print("current status $isMandatory");
          showAndroidUpdateDialog(context, isMandatory);
        }
      }
      return true;
    }

    Future<RemoteConfig> setupRemoteConfig() async {
      final RemoteConfig remoteConfig = await RemoteConfig.instance;
      remoteConfig.setConfigSettings(RemoteConfigSettings());
      try {
        await remoteConfig.notifyListeners();
        await remoteConfig.fetch();
        remoteConfig.setDefaults(<String, dynamic>{
          'current_android_version': '1.0.0',
          'android_active': true,
          'android_update_mandatory': true,
        });
        print(remoteConfig.getBool("android_active"));
        return remoteConfig;
      } catch (e) {
        return null;
      }
    }



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
        home:FutureBuilder(
          future: setupRemoteConfig(),
          builder: (BuildContext context, AsyncSnapshot<RemoteConfig>snapshot){
            return snapshot.hasData && (snapshot.connectionState == ConnectionState.done)
                ?Provider(
              remote: snapshot.data,
              child: Builder(builder: (context){
                Future.delayed(Duration(milliseconds: 500),()=> checkConfig(context));
                return WelcomePage();
              },),
            ):Container();
          },
        ) ,
        defaultTransition: Transition.zoom,
        transitionDuration: Duration(milliseconds: 250),
        theme: MyThemes.lightTheme,
        debugShowCheckedModeBanner: false,
        title: "Libmot Mobile",
        initialRoute: "initial",
        themeMode: ThemeMode.system,
        darkTheme: MyThemes.lightTheme,
        onGenerateRoute: routes,
        builder: EasyLoading.init(),
      ),
    );
  }
}

class Provider extends InheritedWidget{
  final RemoteConfig remote;
  final Map appConfig = {};
  Provider({
    Key key,
    Widget child,
    this.remote,
}):super(key: key,child:child);
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;

  }

}
bool isUserAppCurrent(String deviceVersion, String firebaseVersion) {
  List deviceList = deviceVersion.split(".");
  List firebaseList = firebaseVersion.split(".");

  var unionLength = firebaseList.length > deviceList.length
      ? firebaseList.length
      : deviceList.length;

  for (var i = 0; i < unionLength; i++) {
    if (deviceList.length - 1 < i) {
      return false;
    }
    if (firebaseList.length - 1 < i) {
      return true;
    }

    if (int.parse(firebaseList[i]) > int.parse(deviceList[i])) {
      return false;
    }

    if (int.parse(firebaseList[i]) == int.parse(deviceList[i]) &&
        i == unionLength - 1) {
      return true;
    }
  }

  return false;
}

void showAndroidUpdateDialog(BuildContext context, bool mandatory) {
  showDialog(
      context: context,
      barrierDismissible: !mandatory,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return !mandatory;
          },
          child: AlertDialog(
            contentPadding:
            const EdgeInsets.only(bottom: 10, left: 20, right: 20, top: 10),
            title: Text("New Version Available"),
            content: Text(
                "Your version of Libmot Self Service app is currently outdated, Please visit android store to get the latest version"),
            actions: <Widget>[
              (mandatory)
                  ? Container()
                  : FlatButton(
                child: Text("Later"),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),

              FlatButton(
                child: Text("Update Now"),
                onPressed: () {
                  // StoreRedirect.redirect(
                  //     androidAppId: SystemProperties.appPackageAndroid,
                  //     iOSAppId: SystemProperties.appIDIOS);
                },
              ),
            ],
          ),
        );
      });
}


class NewDialogs{
  static showMessage({
    message,
    title,
  }) {
    Get.dialog(
      AlertDialog(
        elevation: 0,
        contentPadding: EdgeInsets.all(0),
        backgroundColor: Colors.transparent,
        content: Stack(
          children: [
            Card(
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
                child: Wrap(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF11202A).withOpacity(0.3)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Icon(
                            Icons.question_answer,
                            color: Color(0xFF11202A),
                            size: 34,
                          ),
                        ),
                      ),
                    ),
                    Container(height: 15),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            letterSpacing: 0.1,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    Container(height: 10),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10),
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            letterSpacing: 0.2,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 7,
              right: 7,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.cancel,
                  color: Color(0xFFE7AA07),
                  size: 35,
                ),
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}
