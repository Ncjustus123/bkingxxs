import 'package:flutter/material.dart';

import 'view/book_a_seat.dart';
import 'view/initial_page.dart';
import 'view/welcome_page.dart';
import 'view/dashboard_page.dart';
import 'view/login_page.dart';
import 'view/bus_hire_page.dart';

Route routes(RouteSettings settings) {
  switch (settings.name) {
    case "initial":
      {
        return MaterialPageRoute(builder: (context) => InitialPage());
      }
      break;
    case "/welcome":
      {
        return MaterialPageRoute(builder: (context) => WelcomePage());
      }
      break;
    case "/login":
      {
        return MaterialPageRoute(builder: (context) => LoginPage());
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
        return MaterialPageRoute(builder: (context) => DashboardPage());
      }
      break;
    case "/bookASeat":
      {
        return MaterialPageRoute(builder: (context) => BookASeatPage());
      }
      break;
    case "/busHire":
      {
        return MaterialPageRoute(builder: (context) => BusHirePage());
      }
      break;
    default:
      {
        // return MaterialPageRoute(builder: (context) => DashBoard());  //404 page
      }
  }
}
