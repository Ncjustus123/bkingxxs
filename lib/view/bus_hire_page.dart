import 'package:Libmot_Mobile/repository/hire_bus_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BusHirePage extends StatelessWidget {
  final _formKeyBusHire = GlobalKey<FormState>();
  final fromController = TextEditingController();
  final toController = TextEditingController();
  final dateController = TextEditingController();

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
                fromField(),
                toField(),
                dateField(context),
                proceedButton(),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  fromField() {
    return TextFormField(
      controller: fromController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please input a departure address';
        }
        return null;
      },
    );
  }

  toField() {
    return TextFormField(
      controller: toController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please input a destination address';
        }
        return null;
      },
      onTap: () {},
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

        dateController.text = '${DateFormat('yMMMd').format(selectedTime)}';
      },
    );
  }

  proceedButton() {
    return ElevatedButton(
      child: Text("Proceed"),
      onPressed: () {
        // hireBus.hireBus.
      },
    );
  }
}
