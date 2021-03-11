import 'package:Libmot_Mobile/repository/hire_bus_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Contact Information"),
            Form(
              key: _formKeyBusHireDetail,
              child: Column(
                children: [
                  firstName(),
                  lastName(),
                  phoneNumber(),
                  email(),
                  numBus(),
                  Text("Next of Kin Information"),
                  nextKinName(),
                  nextKinPhone(),
                  getAQuote(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget firstName() {
    return TextFormField(
      controller: firstNameController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please input a departure address';
        }
        return null;
      },
    );
  }

  Widget lastName() {
    return TextFormField(
      controller: lastNameController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please input a departure address';
        }
        return null;
      },
    );
  }

  Widget phoneNumber() {
    return TextFormField(
      controller: phoneNumberController,
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please input a departure address';
        }
        return null;
      },
    );
  }

  Widget email() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please input a departure address';
        }
        return null;
      },
    );
  }

  Widget numBus() {
    return TextFormField(
      controller: numBusesController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please input a departure address';
        }
        return null;
      },
    );
  }

  Widget nextKinName() {
    return TextFormField(
      controller: nextKinNameController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please input a departure address';
        }
        return null;
      },
    );
  }

  Widget nextKinPhone() {
    return TextFormField(
      controller: nextKinPhoneController,
      //todo: capitalize first name
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please input a departure address';
        }
        return null;
      },
    );
  }

  Widget getAQuote() {
    return ElevatedButton(
      child: Text("Get a Quote"),
      onPressed: () {
        if (_formKeyBusHireDetail.currentState.validate()) {
          hireBus.hireBus.firstName = firstNameController.text;
          hireBus.hireBus.lastName = lastNameController.text;
          hireBus.hireBus.email = emailController.text;
          hireBus.hireBus.phoneNumber = phoneNumberController.text;
          hireBus.hireBus.numberOfBuses = int.tryParse(numBusesController.text);
          hireBus.hireBus.nextOfKinName = nextKinNameController.text;
          hireBus.hireBus.nextOfKinPhoneNumber = nextKinPhoneController.text;
          hireBus.hireBus.address = "";
          hireBus.hireBus.gender = "";
          hireBus.hireBus.middleName = "";
          hireBus.hireBus.requestDate = hireBus.hireBus.departureDate;
          //'${DateFormat('dd MMMM yyyy').format(DateTime.now())}';

          hireBus.hireBus.requestDate = "12 March, 2021";
          hireBus.hireBus.departureDate = "12 March, 2021";
          hireBus.postHireBus();
        }
      },
    );
  }
}
