import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class UIReusable{
  void showLoading( {@required Color progressColor, Color backgroundColor, Color indicatorColor,Color textColor,  
 EasyLoadingIndicatorType indicatorType, status}){
  EasyLoading.instance
  ..displayDuration =  const Duration(milliseconds: 1000)
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
  ..dismissOnTap = false
  ;
  EasyLoading.show(status: status);
  
  
}
}