
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:Libmot_Mobile/constants/Buttons/buttons.dart';

dialog(context, String title, content, {onpressed}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),

        child: Wrap(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 90,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                content,
                style: TextStyle(
                    fontSize: 13, color: Colors.black, fontFamily: 'Monserrat'),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: SmallButtonReusable(
                name: "Okay",
                onpressed: onpressed,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class NetworkDialog {
  static noNetwork(context, String title, content, onpressed) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Icon(
                Icons.wifi_off,
                color: Colors.green,
                size: 90,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                content,
                style: TextStyle(fontSize: 13),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Spacer(),
              SmallButtonReusable(
                name: "Retry",
                onpressed: onpressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BannerDialog {
  static noNetwork(context, Image image, onpressed) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              image,
              SizedBox(
                height: 10,
              ),
              Spacer(),
              SmallButtonReusable(
                name: "okay",
                onpressed: onpressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UIReusable {
  static void showLoading(
      {@required Color progressColor,
      Color backgroundColor,
      Color indicatorColor,
      Color textColor,
      EasyLoadingIndicatorType indicatorType,
      status}) {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 1000)
      ..indicatorType = indicatorType
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = progressColor
      ..backgroundColor = backgroundColor
      ..indicatorColor = indicatorColor
      ..textColor = textColor
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = false
      ..dismissOnTap = false;
    EasyLoading.show(status: status);
  }
}

class Dialogs {
  static showLoadingDialog({BuildContext context, text}) {
    Get.dialog(
      AlertDialog(
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.transparent,
        titlePadding: EdgeInsets.zero,
        content: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Center(child: loadingRow(context, text)),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static Row loadingRow(BuildContext context, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
            child: Image.asset(
          'images/logo.png',
          height: 60,
        )),
        SizedBox(width: 20),
        DefaultTextStyle(
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            letterSpacing: 1.2,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
          child: AnimatedTextKit(
            onTap: () {},
            animatedTexts: [
              TypewriterAnimatedText(text),
            ],
          ),
        ),
      ],
    );
  }

  static showErrorSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      duration: Duration(seconds: 3),
      backgroundColor: Colors.white70,
      colorText: Colors.pink,
    );
  }

  static showNoInternetSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      duration: Duration(seconds: 4),
      icon: Icon(
        Icons.wifi_off,
        color: Colors.orange,
      ),
      backgroundColor: Colors.white,
      colorText: Colors.orange,
    );
  }

  static showSuccessSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      borderRadius: 5,
      duration: Duration(seconds: 2),
      backgroundColor: Colors.white70,
      colorText: Colors.green,
    );
  }

  static showWelcomeSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      borderRadius: 5,
      duration: Duration(seconds: 4),
      // icon: Padding(
      //   padding: const EdgeInsets.all(2.0),
      //   child: Container(
      //     decoration: BoxDecoration(
      //         shape: BoxShape.circle, color: Colors.redAccent.withOpacity(0.3)),
      //     child: Center(
      //       child: Padding(
      //         padding: const EdgeInsets.all(7.0),
      //         child: Image.asset(
      //           'images/LIBMOT LOGO 1.png',
      //           width: 75,
      //           height: 75,
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      backgroundColor: Colors.white70,
      colorText: Colors.blueGrey,
    );
  }
}

class WidgetTextField extends StatelessWidget {
  final String lableText;
  final Function validator;
  final controller;

  // final Function onTap;
  const WidgetTextField({
    Key key,
    @required this.lableText,
    this.validator,
    @required this.controller,
    // this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 5),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: TextFormField(
            //onTap: onTap,
            decoration: InputDecoration(
              fillColor: Colors.grey,
              focusColor: Colors.grey,
              border: InputBorder.none,
              labelText: lableText,
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            ),
            controller: controller,
            validator: validator,
          ),
        ),
      ),
    );
  }
}

void showLoading(
    {@required Color progressColor,
    Color backgroundColor,
    Color indicatorColor,
    Color textColor,
    EasyLoadingIndicatorType indicatorType,
    status}) {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 1000)
    ..indicatorType = indicatorType
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = progressColor
    ..backgroundColor = backgroundColor
    ..indicatorColor = indicatorColor
    ..textColor = textColor
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
  EasyLoading.show(status: status);
}
