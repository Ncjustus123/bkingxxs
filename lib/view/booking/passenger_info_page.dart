import 'package:Libmot_Mobile/models/booking_model.dart';
import 'package:Libmot_Mobile/repository/booking_repository.dart';
import 'package:Libmot_Mobile/repository/seat_selection_repository.dart';
import 'package:Libmot_Mobile/repository/user_repository.dart';
import 'package:Libmot_Mobile/view/widgets/appBar_passenger_info.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PassengerInfoPage extends StatefulWidget {
  @override
  _PassengerInfoPageState createState() => _PassengerInfoPageState();
}

class _PassengerInfoPageState extends State<PassengerInfoPage>
    with AfterLayoutMixin<PassengerInfoPage>, SingleTickerProviderStateMixin {
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
  SeatSelectionRepository seatSelection;

  AnimationController _controller;

  var myList = [];

  List<Beneficiaries> adultBeneficiary = [];
  List<Beneficiaries> childrenBeneficiary = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      duration: Duration(seconds: 3),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    repository = Provider.of<UserRepository>(context);
    booking = Provider.of<BookingRepository>(context);
    seatSelection = Provider.of<SeatSelectionRepository>(context);

    return Scaffold(
      appBar: appBarPassengerInfo(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            SizedBox(
              height: 5,
            ),
            beneficaryField(),
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
            proceedButton(context),
          ]),
        ),
      ),
    );
  }

  RaisedButton proceedButton(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        booking.booking.beneficiaries = [
          ...adultBeneficiary,
          ...childrenBeneficiary
        ];
        booking.savePassengerInfo(context);
      },
    );
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
        booking.booking.gender = (value == "male") ? 0 : 1;
      },
    );
  }

  firstNameField() {
    return TextFormField(
      controller: firstNamecontroller,
      onChanged: (value) {
        booking.booking.firstName = value;
      },
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
      onChanged: (value) => booking.booking.lastName = value,
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
      onChanged: (value) => booking.booking.phoneNumber = value,
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
      onChanged: (value) => booking.booking.email,
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
      onChanged: (value) => booking.booking.nextOfKinName,
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
      onChanged: (value) => booking.booking.nextOfKinPhone,
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
    myList = seatSelection.selectedSeats;
    myList.removeAt(0);
    repository.getSavedProfile().then((_) {
      firstNamecontroller.text = repository.profile.object.firstName ?? "";
      lastNamecontroller.text = repository.profile.object.lastName ?? "";
      phoneNumbercontroller.text = repository.profile.object.phoneNumber ?? "";
      genderValue = repository.profile.object.gender;
      emailcontroller.text = repository.profile.object.email ?? "";
      nextOfkincontroller.text = repository.profile.object.nextOfKin ?? "";
      kinNumbercontroller.text = repository.profile.object.nextOfKinPhone ?? "";
    });
  }

  Widget beneficaryField() {
    int noOfAdultBeneficiaries = booking.model.numberOfAdults - 1 ?? 0;
    int noOfChildrenBeneficiaries = booking.model.numberOfChildren ?? 0;

    return Column(children: [
      (booking.model.numberOfAdults > 1)
          ? Column(
              children: [
                info("Extra Adult Traveller(s)"),
                ...beneficiaryNames,
                (noOfAdultBeneficiaries > beneficiaryNames.length)
                    ? InkWell(
                        onTap: () {
                          popupDialog(context, BeneficiaryType.adult);
                        },
                        child: animationBuilder(
                            Text("Click here to add adult passenger")))
                    : SizedBox()
              ],
            )
          : SizedBox(),
      (noOfChildrenBeneficiaries > 0)
          ? Column(
              children: [
                info("Extra Children Traveller(s)"),
                ...childrenBeneficiaryNames,
                (noOfChildrenBeneficiaries > childrenBeneficiaryNames.length)
                    ? InkWell(
                        onTap: () {
                          popupDialog(context, BeneficiaryType.children);
                        },
                        child: animationBuilder(
                            Text("Click here to add adult passenger")))
                    : SizedBox()
              ],
            )
          : SizedBox(),

      //add children field
    ]);
  }

  Container info(String info) {
    return Container(
      padding: EdgeInsets.all(7.5),
      width: 400,
      color: Colors.redAccent,
      child: Text(info),
    );
  }

  Widget animationBuilder(Widget textChild) {
    return AnimatedBuilder(
      animation:
          CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.all(7.5),
          width: 400,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.blue.withOpacity(1 - _controller.value),
          ),
          //height: 300,
          //width: 200,
          child: textChild,
        );
      },
    );
  }

  List<Widget> beneficiaryNames = [];
  List<Widget> childrenBeneficiaryNames = [];

  var beneficiaryController = TextEditingController();
  popupDialog(BuildContext context, BeneficiaryType beneficiaryType) {
    beneficiaryController.clear();

    Beneficiaries beneficial = Beneficiaries();
    Gender selectedGender = Gender.male;
    int seatNumber = myList.last;
    int index = (beneficiaryType.index == 0)
        ? beneficiaryNames.length
        : childrenBeneficiaryNames.length;
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: 200,
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Name of traveller",
                    ),
                    controller: beneficiaryController,
                  ),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Row(
                        children: <Widget>[
                          Expanded(
                            child: RadioListTile(
                              title: const Text('Male'),
                              value: Gender.male,
                              groupValue: selectedGender,
                              onChanged: (Gender value) {
                                beneficial.gender = value.index;
                                selectedGender = value;
                                setState(() {});
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              title: const Text('Female'),
                              groupValue: selectedGender,
                              value: Gender.female,
                              onChanged: (Gender value) {
                                beneficial.gender = value.index;
                                selectedGender = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  ElevatedButton(
                      child: Text("Add traveller"),
                      onPressed: () {
                        Widget listTile = ListTile(
                          leading: Icon(Icons.person),
                          title: Text(beneficiaryController.text),
                          trailing: IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: () {
                              myList.add(seatNumber);
                              if (beneficiaryType.index == 0) {
                                adultBeneficiary.remove(beneficial);
                                beneficiaryNames.removeAt(index);
                              } else {
                                childrenBeneficiary.remove(beneficial);
                                childrenBeneficiaryNames.removeAt(index);
                              }

                              setState(() {});
                            },
                          ),
                        );

                        setState(() {
                          beneficial.fullName = beneficiaryController.text;
                          beneficial.passengerType = 0; //TODO: CONFIRM THIS
                          beneficial.seatNumber = seatNumber;

                          if (beneficiaryType.index == 0) {
                            beneficiaryNames.insert(index, listTile);
                            adultBeneficiary.add(beneficial);
                          } else {
                            childrenBeneficiaryNames.insert(index, listTile);
                            childrenBeneficiary.add(beneficial);
                          }

                          myList.remove(seatNumber);
                        });
                        Navigator.pop(context);
                      })
                ],
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
}

enum Gender { male, female }
enum BeneficiaryType { adult, children }
