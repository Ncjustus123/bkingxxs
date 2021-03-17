import 'dart:js';

import 'package:Libmot_Mobile/models/profile_model.dart';
import 'package:Libmot_Mobile/repository/booking_repository.dart';
import 'package:Libmot_Mobile/repository/seat_selection_repository.dart';
import 'package:Libmot_Mobile/repository/user_repository.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PassengerInfoPage extends StatefulWidget {
  @override
  _PassengerInfoPageState createState() => _PassengerInfoPageState();
}

class _PassengerInfoPageState extends State<PassengerInfoPage>
    with AfterLayoutMixin<PassengerInfoPage> {
  final String applyCouponPage = "/applyCoupon";

  List<String> genderType = [
    'Male',
    'Female',
  ];

  final firstNamecontroller = TextEditingController();

  final lastNamecontroller = TextEditingController();

  final phoneNumbercontroller = TextEditingController();

  final emailcontroller = TextEditingController();

  final nextOfkincontroller = TextEditingController();

  final kinNumbercontroller = TextEditingController();

  UserRepository repository;
  BookingRepository booking;

  @override
  Widget build(BuildContext context) {
    repository = Provider.of<UserRepository>(context);
    booking = Provider.of<BookingRepository>(context);
    int numberOfPassenger =
        booking.model.numberOfChildren + booking.model.numberOfAdults;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 5,
          backgroundColor: Colors.black,
          bottom: PreferredSize(
            child: Container(
              height: 60,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "hdh",
                        style: TextStyle(color: Colors.green),
                      ),
                      Text(
                        "hdh",
                        style: TextStyle(color: Colors.green),
                      ),
                      Spacer(),
                      Text(
                        "hdh",
                        style: TextStyle(color: Colors.green),
                      ),
                      Text(
                        "hdh",
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                  Divider(
                    height: 3,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            SizedBox(
              height: 5,
            ),
            (numberOfPassenger > 1)
                ? AnimatedContainer(
                    duration: Duration(seconds: 5),
                    height: 200,
                    width: 250,
                    curve: Curves.fastOutSlowIn,
                    color: Colors.grey,
                    child: GestureDetector(
                        onTap: () {
                          return popupDialog(context);
                        },
                        child: Icon(Icons.add)),
                  )
                : SizedBox(),
            Container(
              // height: 500,
              width: 400,
              color: Colors.white,
              child: Column(children: [
                firstNameField(),
                lastNameField(),
                phoneNumberField(),
                genderDropdownButtonFormField(),
                emailField(),
                SizedBox(
                  height: 30,
                ),
                nextOfKinField(),
                nextOfKinPhoneField(),
                SizedBox(
                  height: 50,
                ),
              ]),
            ),
            proceedButton(context),
          ]),
        ),
      ),
    );
  }

  RaisedButton proceedButton(BuildContext context) {
    return RaisedButton(
        color: Colors.red,
        onPressed: () {
          Navigator.of(context).pushNamed(applyCouponPage);
        });
  }

  ///TODO TST WITH GUEST LOGIN
  String genderValue;
  DropdownButtonFormField<String> genderDropdownButtonFormField() {
    return DropdownButtonFormField<String>(
      value: genderValue,
      items: genderType.map((dynamic value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          genderValue = value;
        });
      },
    );
  }

  firstNameField() {
    return TextFormField(
      controller: firstNamecontroller,
      validator: (value) {
        if (value.isEmpty) {
          return 'error';
        }
        return null;
      },
    );
  }

  lastNameField() {
    return TextFormField(
      controller: lastNamecontroller,
      validator: (value) {
        if (value.isEmpty) {
          return 'error';
        }
        return null;
      },
    );
  }

  phoneNumberField() {
    return TextFormField(
      controller: phoneNumbercontroller,
      validator: (value) {
        if (value.isEmpty) {
          return 'error';
        }
        return null;
      },
    );
  }

  emailField() {
    return TextFormField(
      controller: emailcontroller,
      validator: (value) {
        if (value.isEmpty) {
          return 'error';
        }
        return null;
      },
    );
  }

  nextOfKinField() {
    return TextFormField(
      controller: nextOfkincontroller,
      validator: (value) {
        if (value.isEmpty) {
          return 'error';
        }
        return null;
      },
    );
  }

  nextOfKinPhoneField() {
    return TextFormField(
      controller: kinNumbercontroller,
      validator: (value) {
        if (value.isEmpty) {
          return 'error';
        }
        return null;
      },
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    repository.getSavedProfile().then((_) {
      setState(() {
        firstNamecontroller.text = repository.profile.object.firstName ?? "";
        lastNamecontroller.text = repository.profile.object.lastName ?? "";
        phoneNumbercontroller.text =
            repository.profile.object.phoneNumber ?? "";
        genderValue = repository.profile.object.gender;
        emailcontroller.text = repository.profile.object.email ?? "";
        nextOfkincontroller.text = repository.profile.object.nextOfKin ?? "";
        kinNumbercontroller.text =
            repository.profile.object.nextOfKinPhone ?? "";
      });
    });
  }

   popupDialog(context){
     showDialog(
       context: context,
       builder: (context){
         return AlertDialog(
           title: Text("hahah"),
           content: Text("csjjsnsj"),
           actions: <Widget>[
             Row(
               children: [
                 FlatButton(onPressed: (){}, child: Text("data")),
                 FlatButton(onPressed: (){}, child: Text("data")),
               ],
             ),
           ]
         );
         
       }
       );

   }
}
