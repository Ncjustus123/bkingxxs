import 'package:Libmot_Mobile/Reusables/constants.dart';
import 'package:Libmot_Mobile/Reusables/text_field.dart';
import 'package:Libmot_Mobile/repository/hire_bus_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:Libmot_Mobile/Reusables/bottom_sheet.dart';

// ignore: must_be_immutable
class BusHIreDetailsPage extends StatelessWidget {
  final _formKeyBusHireDetail = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final numBusesController = TextEditingController();
  final nextKinNameController = TextEditingController();
  final nextKinPhoneController = TextEditingController();

  HireBusRepository hireBus;

  @override
  Widget build(BuildContext context) {
    hireBus = Provider.of<HireBusRepository>(context);
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      width: _width,
      height: _height,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      // border: Border.all(width: 0.8, color: Colors.black),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Icon(
                        Icons.west,
                        color: Theme.of(context).primaryColor,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 150),
                  child: Text("Hire A Bus",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15)),
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(45))),
                // key: _formKeyBusHire,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _formPage(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _formPage(context) {
    return SingleChildScrollView(
      child: Form(
        child: Column(children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Destination: Lagos to PH  Date: June 12",
            style: textStyle2,
          ),
          SizedBox(
            height: 10,
          ),
          TextFormFeildWidget(
            obscureText: false,
            controller: fullNameController,
            lableText: 'Full Name',
            validator: (value) {
              if (value.isEmpty) {
                return 'Please input your FullName';
              }
              return null;
            },
          ),
          TextFormFeildWidget(
            obscureText: false,
            controller: phoneNumberController,
            keyboardType: TextInputType.phone,
            lableText: 'Phone Number',
            validator: (value) {
              if (value.isEmpty) {
                return 'Please input your Phone Number';
              }
              return null;
            },
          ),
          TextFormFeildWidget(
            obscureText: false,
            controller: numBusesController,
            keyboardType: TextInputType.emailAddress,
            lableText: 'Email',
            validator: (value) {
              if (value.isEmpty) {
                return 'Please input your Phone Number';
              }
              return null;
            },
          ),
          TextFormFeildWidget(
            obscureText: false,
            controller: phoneNumberController,
            keyboardType: TextInputType.number,
            lableText: 'Number of Buses',
            validator: (value) {
              if (value.isEmpty) {
                return 'Please input the Number of Buses';
              }
              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Next Of Kin Information",
            style: textStyle1,
          ),
          SizedBox(
            height: 10,
          ),
          TextFormFeildWidget(
            obscureText: false,
            controller: nextKinNameController,
            keyboardType: TextInputType.emailAddress,
            lableText: 'Full Name',
            validator: (value) {
              if (value.isEmpty) {
                return 'Please input the Name of Your Next Of Kin ';
              }
              return null;
            },
          ),
          TextFormFeildWidget(
            obscureText: false,
            controller: nextKinPhoneController,
            keyboardType: TextInputType.number,
            lableText: 'Phone Number',
            validator: (value) {
              if (value.isEmpty) {
                return 'Please input your Next Of Kin Phone Number';
              }
              return null;
            },
          ),
          SizedBox(
            height: 30,
          ),
          ButtonReusable(
            name: "Get A Quote",
            onpressed: () => dialog(
                context,
                'Thank You Taiwo',
                "We are processing your request. A member of our team will get in toudh with you soon.\n\n"
                    "For quick information you can send an email to support@libmot.com or call +2349031565022\n\n"
                    "Thank you for choosing LIBMOT.COM"),
          ),
        ]),
      ),
    );
  }

  // Widget getAQuote() {
  //   return ElevatedButton(
  //     child: Text("Get a Quote"),
  //     onPressed: () {
  //       if (_formKeyBusHireDetail.currentState.validate()) {
  //         hireBus.hireBus.firstName = firstNameController.text;
  //         hireBus.hireBus.lastName = lastNameController.text;
  //         hireBus.hireBus.email = emailController.text;
  //         hireBus.hireBus.phoneNumber = phoneNumberController.text;
  //         hireBus.hireBus.numberOfBuses = int.tryParse(numBusesController.text);
  //         hireBus.hireBus.nextOfKinName = nextKinNameController.text;
  //         hireBus.hireBus.nextOfKinPhoneNumber = nextKinPhoneController.text;
  //         hireBus.hireBus.address = "";
  //         hireBus.hireBus.gender = "";
  //         hireBus.hireBus.middleName = "";
  //         hireBus.hireBus.requestDate = hireBus.hireBus.departureDate;
  //         //'${DateFormat('dd MMMM yyyy').format(DateTime.now())}';

  //         hireBus.hireBus.requestDate = "12 March, 2021";
  //         hireBus.hireBus.departureDate = "12 March, 2021";
  //         hireBus.postHireBus();
  //       }
  //     },
  //   );
  // }
}
