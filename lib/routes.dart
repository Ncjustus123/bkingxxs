
import 'package:Libmot_Mobile/view/booking/apply_coupon_page.dart';
import 'package:Libmot_Mobile/view/booking/passenger_info_page.dart';
import 'package:Libmot_Mobile/view/booking/check_booking_status.dart';
import 'package:Libmot_Mobile/view/help_support/complaints_page.dart';
import 'package:Libmot_Mobile/view/help_support/help_support_page.dart';
import 'package:Libmot_Mobile/view/booking/select_bus_page.dart';
import 'package:Libmot_Mobile/view/login/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'view/become_agent/become_an_agent.dart';
import 'view/booking/book_a_seat.dart';
import 'view/initial_page.dart';
import 'view/login/forget_password_page.dart';
import 'view/welcome_page.dart';
import 'view/dashboard_page.dart';
import 'view/login/login_page.dart';
import 'view/bus_hire/bus_hire_page.dart';
import 'view/bus_hire/bus_hire_details_page.dart';
import 'view/bus_hire/bus_hire_success_page.dart';
import 'Reusables/select_seat_page.dart';

Route routes(RouteSettings settings) {
  final args = settings.arguments;

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
         return MaterialPageRoute(builder: (context) => ForgotPassword());
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
    case "/selectBus":
      {
        return MaterialPageRoute(builder: (context) => SelectBusPage());
      }
      break;
      case "/selectSeats":
      {
        return MaterialPageRoute(builder: (context) => SelectSeatPage(
          bus : args,
        ));
      }
      break;
    case "/busHireDetails":
      {
        return MaterialPageRoute(builder: (context) => BusHIreDetailsPage());
      }
      break;
    case "/busHireSuccess":
      {
        return MaterialPageRoute(builder: (context) => BusHireSuccessPage());
      }
      break;
      case "/passengerInfomation":
      {
        return MaterialPageRoute(builder: (context) => PassengerInfoPage());

      }
      break;
      case "/applyCoupon":
      {
        return MaterialPageRoute(builder: (context)=> ApplyCoupon());
      }
      break;
    case "/helpSupportPage":
      {
        return MaterialPageRoute(builder: (context) => HelpSupportPage());
      }
      break;
    case "/complaintsPage":
      {
        return MaterialPageRoute(builder: (context) => ComplaintsPage());
      }
      break;
    case "/checkBookingStatus":
      {
        return MaterialPageRoute(builder: (context) => CheckBooking());
      }
      break;
      case "/signUpPage":
      {
        return MaterialPageRoute(builder: (context) => SignUpPage());
      }
      break;
    case "/becomeAnAgentPage":
      {
        return MaterialPageRoute(builder: (context) => BecomeAnAgent());
      }
      break;
    default:
      {
         return MaterialPageRoute(builder: (context) => InitialPage());  //404 page
      }
      
  }
  return null;
}
