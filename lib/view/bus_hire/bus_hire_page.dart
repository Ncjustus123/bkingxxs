import 'package:Libmot_Mobile/Reusables/constants.dart';
import 'package:Libmot_Mobile/Reusables/text_field.dart';
import 'package:Libmot_Mobile/repository/hire_bus_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class BusHirePage extends StatefulWidget {
  @override
  _BusHirePageState createState() => _BusHirePageState();
}

class _BusHirePageState extends State<BusHirePage> {
  final _formKeyBusHire = GlobalKey<FormState>();

  final fromController = TextEditingController();

  final toController = TextEditingController();

  final dateController = TextEditingController();

  final busHireDetailsPage = "/busHireDetails";

  TextEditingController departuredateController = TextEditingController();

  HireBusRepository hireBus;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    hireBus = Provider.of<HireBusRepository>(context);

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
                  padding: EdgeInsets.only(right:150),
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
                padding: const EdgeInsets.all(23.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(45))),
                // key: _formKeyBusHire,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      InputFormField(
                        suffixIcon: Icon(Icons.place),
                        label: 'From',
                        controller: fromController,
                      ),
                      InputFormField(
                        suffixIcon: Icon(Icons.place),
                        label: 'To',
                        controller: toController,
                      ),
                      InkWell(
                        onTap: () async {
                          DateTime chosenDate = await showDatePicker(
                            helpText: 'Departure Date',
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(DateTime.now().year,
                                DateTime.now().month, DateTime.now().day),
                            lastDate: DateTime(DateTime.now().year + 2),
                          );
                          if (chosenDate != null) {
                            setState(() {
                              departuredateController.text =
                                  DateFormat('yyyy-MM-dd')
                                      .format(chosenDate)
                                      .toString();
                            });
                          }
                        },
                        child: InputFormField(
                          enabled: false,
                          controller: departuredateController,
                          suffixIcon: Icon(Icons.event_note),
                          label: 'Departure Date',
                        ),
                      ),
                      SizedBox(height: 50,),
                      ButtonReusable(
                        name: "Proceed",
                        onpressed: (){
                           Navigator.of(context).pushNamed(busHireDetailsPage);
                        },
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
