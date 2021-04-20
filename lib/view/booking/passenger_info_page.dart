import 'package:Libmot_Mobile/models/booking_model.dart';
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
    with AfterLayoutMixin<PassengerInfoPage>, SingleTickerProviderStateMixin {
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
  SeatSelectionRepository seatSelection;

  AnimationController _controller;

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 5,
          backgroundColor: Colors.black,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(100),
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
    myList = seatSelection.selectedSeats;
    myList.removeAt(0);
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
    // noOfBenefiaries =
    //     booking.model.numberOfAdults + booking.model.numberOfChildren - 1;
    beneficiaryList = [
      Container(
        padding: EdgeInsets.all(7.5),
        width: 400,
        color: Colors.redAccent,
        child: Text("Extra Adult Traveller(s)"),
      ),
      InkWell(
          onTap: () {
            int seatNumber = myList.first;

            popupDialog(context, beneficiaryList.length - 1, seatNumber);
          },
          child: animationBuilder(Text("Click here to add adult passenger")))
    ];

    // childrenBeneficiaryList = [
    //   Container(
    //     padding: EdgeInsets.all(7.5),
    //     width: 400,
    //     color: Colors.redAccent,
    //     child: Text("Extra Children Traveller(s)"),
    //   ),
    //   InkWell(
    //       onTap: () {
    //         popupDialog(
    //           context,
    //           childrenBeneficiaryList.length - 1,
    //         );
    //       },
    //       child: animationBuilder(Text("Click here to add children passenger")))
    // ];
  }

  var myList = [];
  List<Widget> beneficiaryList = [];

  List<Widget> childrenBeneficiaryList = [];

  List<Beneficiaries> adultBeneficiary = [];

  Widget beneficaryField() {
    return Column(children: [
      (booking.model.numberOfAdults > 1)
          ? Column(
              children: beneficiaryList,
            )
          : SizedBox(),
      (booking.model.numberOfChildren > 0)
          ? Column(
              children: childrenBeneficiaryList,
            )
          : SizedBox(),

      //add children field
    ]);
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

  var beneficiaryController = TextEditingController();
  popupDialog(context, int index, int seatNumber) {
    beneficiaryController.clear();

    Beneficiaries beneficial = Beneficiaries();
    Gender selectedGender = Gender.male;

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
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: ListTile(
                          title: const Text('Male'),
                          leading: Radio<Gender>(
                            value: Gender.male,
                            groupValue: selectedGender,
                            onChanged: (Gender value) {
                              setState(() {
                                beneficial.gender = value.index;
                                selectedGender = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Text('Female'),
                          leading: Radio<Gender>(
                            value: Gender.female,
                            groupValue: selectedGender,
                            onChanged: (Gender value) {
                              setState(() {
                                beneficial.gender = value.index;
                                selectedGender = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  RaisedButton(
                      child: Text("Add traveller"),
                      onPressed: () {
                        Widget listTile = ListTile(
                          leading: Icon(Icons.person),
                          title: Text(beneficiaryController.text),
                          trailing: IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: () {},
                          ),
                        );

                        setState(() {
                          beneficiaryList.insert(index, listTile);

                          beneficial.fullName = beneficiaryController.text;
                          beneficial.passengerType = 0; //TODO: CONFIRM THIS
                          beneficial.seatNumber = seatNumber;
                          myList.remove(seatNumber);

                          adultBeneficiary.add(beneficial);
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
