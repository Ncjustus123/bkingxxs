import 'package:flutter/material.dart';

Route routes(RouteSettings settings) {
  switch (settings.name) {
    case "/":
      {
        //   return MaterialPageRoute(builder: (context) => DashBoard());
      }
      break;
    case "/login":
      {
        // return MaterialPageRoute(builder: (context) => DashBoard());
      }
      break;
    case "/forget_password":
      {
        // return MaterialPageRoute(builder: (context) => DashBoard());
      }
      break;
    case "/sign_up":
      {
        // return MaterialPageRoute(builder: (context) => DashBoard());
      }
      break;
    case "/dashboard":
      {
        // return MaterialPageRoute(builder: (context) => DashBoard());
      }
      break;
    default:
      {
        // return MaterialPageRoute(builder: (context) => DashBoard());  //404 page
      }
  }
}
