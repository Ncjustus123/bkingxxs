import 'package:Libmot_Mobile/Reusables/appBar.dart';
import 'package:Libmot_Mobile/Reusables/buttons.dart';
import 'package:Libmot_Mobile/constants/constants.dart';
import 'package:Libmot_Mobile/controllers/booking_repository.dart';
import 'package:Libmot_Mobile/controllers/hire_bus_repository.dart';
import 'package:Libmot_Mobile/constants/dialogs/dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class BusHIreDetailsPage extends StatelessWidget {
  final _formKeyBusHireDetail = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
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
          myAppBar(context, "Hire A Bus"),
          Expanded(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(45))),
                // key: _formKeyBusHire,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey.shade500,
                                    offset: Offset(0.4, 0.4),
                                    blurRadius: 1)
                              ]),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              hireItem('DEPARTURE', hireBus.hireBus.departure),
                              hireItem('ARRIVAL', hireBus.hireBus.destination),
                              hireItem(
                                  'DATE NEEDED', hireBus.hireBus.departureDate),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: _formPage(context),
                      ),
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
        key: _formKeyBusHireDetail,
        child: Column(children: [
          SizedBox(height: 5),
          TextFormFieldWidget(
            obscureText: false,
            controller: firstNameController,
            labelText: 'First Name',
            validator: (value) {
              if (value.isEmpty) {
                return 'Please input your FullName';
              }
              return null;
            },
          ),
          TextFormFieldWidget(
            obscureText: false,
            controller: lastNameController,
            labelText: 'Last Name',
            validator: (value) {
              if (value.isEmpty) {
                return 'Please input your FullName';
              }
              return null;
            },
          ),
          TextFormFieldWidget(
            obscureText: false,
            controller: phoneNumberController,
            keyboardType: TextInputType.phone,
            labelText: 'Phone Number',
            validator: (value) {
              if (value.isEmpty) {
                return 'Please input your Phone Number';
              }
              return null;
            },
          ),
          TextFormFieldWidget(
            obscureText: false,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            labelText: 'Email',
            validator: (value) {
              if (value.isEmpty) {
                return 'Please input your Phone Number';
              }
              return null;
            },
          ),
          TextFormFieldWidget(
            obscureText: false,
            controller: numBusesController,
            keyboardType: TextInputType.number,
            labelText: 'Number of Buses',
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
          TextFormFieldWidget(
            obscureText: false,
            controller: nextKinNameController,
            keyboardType: TextInputType.emailAddress,
            labelText: 'Full Name',
            validator: (value) {
              if (value.isEmpty) {
                return 'Please input the Name of Your Next Of Kin ';
              }
              return null;
            },
          ),
          TextFormFieldWidget(
            obscureText: false,
            controller: nextKinPhoneController,
            keyboardType: TextInputType.number,
            labelText: 'Phone Number',
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
          Buttons.coloredButton(
              context: context,
              title: "Get A Quote",
              onTap: () {
                String today =
                    ('${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day + 1}')
                        .toString();
                print(today);
                if (_formKeyBusHireDetail.currentState.validate()) {
                  _formKeyBusHireDetail.currentState.save();
                  showFetchingData('Making Reservation\nPlease wait');

                  hireBus.hireBus.firstName = firstNameController.text;
                  hireBus.hireBus.lastName = lastNameController.text;
                  hireBus.hireBus.email = emailController.text;
                  hireBus.hireBus.phoneNumber = phoneNumberController.text;
                  hireBus.hireBus.numberOfBuses =
                      int.tryParse(numBusesController.text);
                  hireBus.hireBus.nextOfKinName = nextKinNameController.text;
                  hireBus.hireBus.nextOfKinPhoneNumber =
                      nextKinPhoneController.text;
                  hireBus.hireBus.address = "";
                  hireBus.hireBus.gender = "";
                  hireBus.hireBus.middleName = "";
                  hireBus.hireBus.requestDate = today;

                  hireBus.hireBus.departureDate = hireBus.hireBus.departureDate;
                  print(hireBus.hireBus.toJson());
                  hireBus.postHireBus(context,name:hireBus.hireBus.firstName);
                }

                // dialog(
                //     context,
                //     'Thank You Taiwo',
                //     "We are processing your request. A member of our team will get in toudh with you soon.\n\n"
                //         "For quick information you can send an email to support@libmot.com or call +2349031565022\n\n"
                //         "Thank you for choosing LIBMOT.COM", () {
                //   Get.back();
                // });
              }),
        ]),
      ),
    );
  }

  Padding hireItem(title, desc) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              child: Text(
            '$title : ',
            textAlign: TextAlign.right,
            style: TextStyle(fontWeight: FontWeight.w600),
          )),
          SizedBox(width: 10),
          Expanded(child: Text('$desc')),
        ],
      ),
    );
  }
}
