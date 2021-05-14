import 'package:Libmot_Mobile/repository/hire_bus_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class BusHirePage extends StatelessWidget {
  final _formKeyBusHire = GlobalKey<FormState>();
  final fromController = TextEditingController();
  final toController = TextEditingController();
  final dateController = TextEditingController();
  final busHireDetailsPage = "/busHireDetails";

  HireBusRepository hireBus;

  @override
  Widget build(BuildContext context) {
    hireBus = Provider.of<HireBusRepository>(context);

    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Text("bus hire page"),
          Form(
            key: _formKeyBusHire,
            child: Column(
              children: [
                fromField(context),
                toField(context),
                dateField(context),
                proceedButton(context),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  fromField(BuildContext context) {
    return TextFormField(
        readOnly: true,
        controller: fromController,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please input a departure address';
          }
          return null;
        },
        onTap: () async {
          fromController.text = await hireBus.getAddress(context);
        });
  }

  toField(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: toController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please input a destination address';
        }
        return null;
      },
      onTap: () async {
        toController.text = await hireBus.getAddress(context);
      },
    );
  }

  dateField(context) {
    final now = DateTime.now();
    return TextFormField(
      readOnly: true,
      controller: dateController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please select departure date';
        }
        return null;
      },
      onTap: () async {
        DateTime selectedTime = await showDatePicker(
            context: context,
            initialDate: now.add(Duration(days: 1)), //tomorrow initial date
            firstDate: now,
            lastDate: now.add(Duration(days: 14)), //open for only two weeks
            helpText: "Select travelling date");

        dateController.text =
            '${DateFormat('dd MMMM yyyy').format(selectedTime)}';

        print(dateController.text);
        print(hireBus.hireBus.departureDate);
      },
    );
  }

  proceedButton(context) {
    return ElevatedButton(
      child: Text("Proceed"),
      onPressed: () {
        if (_formKeyBusHire.currentState.validate()) {
          hireBus.hireBus.departure = fromController.text;
          hireBus.hireBus.destination = toController.text;
          hireBus.hireBus.departureDate = dateController.text;

          Navigator.of(context).pushNamed(busHireDetailsPage);
        }
      },
    );
  }
}
