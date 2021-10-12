import 'package:Libmot_Mobile/Reusables/appBar.dart';
import 'package:Libmot_Mobile/Reusables/buttons.dart';
import 'package:Libmot_Mobile/Reusables/text_field.dart';
import 'package:Libmot_Mobile/constants/constants.dart';
import 'package:Libmot_Mobile/constants/dialogs/dialog.dart';
import 'package:Libmot_Mobile/controllers/booking_repository.dart';
import 'package:Libmot_Mobile/controllers/user_repository.dart';
import 'package:Libmot_Mobile/models/paymentPaystackModel.dart';
import 'package:Libmot_Mobile/services/networking/api_calls.dart';
import 'package:Libmot_Mobile/services/networking/live_data.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:provider/provider.dart';

class FundWalletPage extends StatefulWidget {

  @override
  _FundWalletPageState createState() => _FundWalletPageState();
}

class _FundWalletPageState extends State<FundWalletPage>
    with AfterLayoutMixin<FundWalletPage>, SingleTickerProviderStateMixin{
  final email = TextEditingController();
  final amount = TextEditingController();
  double walletamount;
  int initialamount;
  UserRepository repository;
  BookingRepository booking;
  final plugin = PaystackPlugin();
  PaymentModelObject object;
  String ref="wallet";



  @override
  void initState() {
    plugin.initialize(publicKey: LiveData().paystackPublicKey);//live
    //plugin.initialize(publicKey: TestData().paystackPublicKey);//Test
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    repository = Provider.of<UserRepository>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            myWhiteAppBar(context, "Fund Wallet"),
            SizedBox(height: 20,),
            Container(
              child: Center(
                  child: Text("${getNairaSign()}${amount.text}",
                    style: TextStyle(color: Colors.white,fontSize:50,fontFamily: "Monserrat", ),)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor,
              ),
              height: 200,
              width: 400,
              
            ),
            SizedBox(height: 30,),
            InputFormField(
              label: 'Email',
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
               controller: email,
            ),
            InputFormField(
              label: 'Amount',
              keyboardType: TextInputType.number,
               controller: amount,
              onChanged: (value){
                setState(() {
                  value =amount;
                  initialamount = int.parse(amount.text);
                  walletamount = initialamount.toDouble();
                  print("walletamount");
                  print(walletamount);
                });
              },
            ),
            SizedBox(height: 30,),
            Buttons.coloredButton(
              context: context,
              title: "Add Money",
              onTap: () {
                initializePayment(walletamount,ref);
              }
            ),

          ],
        ),
      ),
    );
  }
  void initializePayment(double amount, String reference) async {
    Charge c = Charge();
    c.amount = (walletamount*100).toInt();
    c.card = PaymentCard.empty();
    c.email = repository.profile.object.email;
    c.reference = ref;
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

        await processPaystackPayment(ref);
      } else {

      }
    });
  }



  Future<void> processPaystackPayment(reference) async {
    showFetchingData('Processing ..');
    object = PaymentModelObject(
      email: repository.profile.object.email,
      amount: (walletamount*100).toInt(),
      refCode: ref,
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
          "Your booking 0f ${getNairaSign()}${booking.totalestimate} was successful",
          onpressed: () {

          });
    } else {
      print("payment failed");
      EasyLoading.dismiss();
      dialog1(context, "Payment failed",
          "Your booking 0f ${getNairaSign()}${booking.totalestimate} was unsuccessful",
          onpressed: () {

          });

    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    email.text = repository.profile.object.email;
    // TODO: implement afterFirstLayout
  }
}
