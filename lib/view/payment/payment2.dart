import 'package:Libmot_Mobile/Reusables/appBar.dart';
import 'package:Libmot_Mobile/constants/constants.dart';
import 'package:Libmot_Mobile/Reusables/text_field.dart';
import 'package:Libmot_Mobile/controllers/booking_repository.dart';
import 'package:Libmot_Mobile/services/networking/api_calls.dart';
import 'package:Libmot_Mobile/services/networking/live_data.dart';
import 'package:Libmot_Mobile/services/networking/test_data.dart';
import 'package:Libmot_Mobile/view/booking/booking_confirmation.dart';
import 'package:Libmot_Mobile/view/dasboard_view/dashboard_page.dart';
import 'package:Libmot_Mobile/view/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:Libmot_Mobile/constants/dialogs/dialog.dart';
import 'package:Libmot_Mobile/constants/Buttons/buttons.dart';
import 'package:Libmot_Mobile/models/paymentPaystackModel.dart';

class PaymentPaystackTwo extends StatefulWidget {
  @override
  _PaymentPaystackTwoState createState() => _PaymentPaystackTwoState();
}

class _PaymentPaystackTwoState extends State<PaymentPaystackTwo> {
  final cardNumbercontroller = TextEditingController();
  final monthAndyearofCardExpiry = TextEditingController();
  final cardHoldername = TextEditingController();
  final cvv = TextEditingController();
  String cardNumber = "xxxx xxxx xxxx xxxx";
  String monthAndyear = "MM/YY";
  String cvvNumber = "CVV";
  String cardHolderName = "";
  final plugin = PaystackPlugin();
  BookingRepository booking;
  PaymentModelObject object;
  final formKey = GlobalKey<FormState>();
  bool _showBack = false;

  @override
  void initState() {
    plugin.initialize(publicKey: LiveData().paystackPublicKey);//live
    //plugin.initialize(publicKey: TestData().paystackPublicKey);//Test
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    booking = Provider.of<BookingRepository>(context);
    var firstfare = booking.getBusesResponseModel.object.departures[0].adultFare;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            children: <Widget>[
              myWhiteAppBar(context, "Payment"),
              SizedBox(height: 10,),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: (){
                          initializePayment(booking.totalestimates,booking.postBookingResponse.object.bookingReferenceCode);
                        },
                        child: Image.asset(
                          'images/paystack.png',
                          height: 80,
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Get.snackbar("Sorry!", "FlutterWave not available!");
                        },
                        child: Image.asset(
                          'images/flutterwave.png',
                          height: 80,
                        ),
                      ),
                    ],),
                  Padding(
                    padding: const EdgeInsets.only(left: 90,right: 90,top: 30),
                    child: SizedBox(
                      height: 50,
                      width: 550,
                      child: RaisedButton(
                          onPressed: (){
                            Get.snackbar("Opps", "Wallet Coming soon");
                            //Get.to(WalletPage());
                          },
                          textColor: Colors.white,
                          color: Theme.of(context).primaryColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.wallet_giftcard),
                              SizedBox(width: 5,),
                              Text("Pay with Wallet"),
                            ],
                          )),
                    ),
                  ),
                ],
              ),],),],),);}

  void initializePayment(double amount, String reference) async {
    Charge c = Charge();
    c.amount = (booking.totalestimates * 100).toInt();
    c.card = PaymentCard.empty();
    c.email = booking.booking.email;
    c.reference = booking.postBookingResponse.object.bookingReferenceCode;
    plugin.checkout(
      context,
      charge: c,
      method: CheckoutMethod.card,
      logo: Image.asset(
        "images/LIBMOT LOGO 1.png",
        height: 50,
      ),
      fullscreen: true,
      hideEmail: true,
    ).then((result) async {
      if (result.status) {

        await processPaystackPayment(reference);
      } else {

      }
    });
  }



  Future<void> processPaystackPayment(reference) async {
    showFetchingData('Processing ..');
    object = PaymentModelObject(
      email: booking.booking.email,
      amount: booking.totalestimates.toInt(),
      refCode: booking.postBookingResponse.object.bookingReferenceCode,
      paystackrefrence: 5,
    );
    print("object");
    print(object);
    final response = await ApiCalls().payStackPayment(object.toJson());
    print('backend');
    print(response.body);
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      print("Payment Success");
      dialog(context, "Payment Successful",
          "Your booking 0f ${getNairaSign()}${booking.totalestimates} was successful",
          onpressed: () {
            Get.to(BookingConfirmation());
          });
    } else {
      print("payment failed");
      EasyLoading.dismiss();
      dialog1(context, "Payment failed",
          "Your booking 0f ${getNairaSign()}${booking.totalestimates} was unsuccessful",
          onpressed: () {
            Get.offAll(()=>DashboardPage());
          });

    }
  }
}

