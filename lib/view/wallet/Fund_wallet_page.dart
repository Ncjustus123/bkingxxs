import 'package:Libmot_Mobile/Reusables/appBar.dart';
import 'package:Libmot_Mobile/Reusables/buttons.dart';
import 'package:Libmot_Mobile/Reusables/text_field.dart';
import 'package:Libmot_Mobile/constants/constants.dart';
import 'package:flutter/material.dart';

class FundWalletPage extends StatefulWidget {
  final email = TextEditingController();
  final amount = TextEditingController();

  @override
  _FundWalletPageState createState() => _FundWalletPageState();
}

class _FundWalletPageState extends State<FundWalletPage> {
  final email = TextEditingController();
  final amount = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
               controller: amount,
            ),
            SizedBox(height: 30,),
            Buttons.coloredButton(
              context: context,
              title: "Add Money",
              onTap: () {}
            ),

          ],
        ),
      ),
    );
  }
}
