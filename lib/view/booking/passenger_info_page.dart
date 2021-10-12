import 'dart:ui';

import 'package:Libmot_Mobile/Reusables/appBar.dart';
import 'package:Libmot_Mobile/Reusables/appBar_passenger_info.dart';
import 'package:Libmot_Mobile/Reusables/buttons.dart';
import 'package:Libmot_Mobile/Reusables/text_field.dart';
import 'package:Libmot_Mobile/constants/constants.dart';
import 'package:Libmot_Mobile/constants/dialogs/dialog.dart';
import 'package:Libmot_Mobile/controllers/booking_repository.dart';
import 'package:Libmot_Mobile/controllers/seat_selection_repository.dart';
import 'package:Libmot_Mobile/controllers/user_repository.dart';
import 'package:Libmot_Mobile/models/booking_model.dart';
import 'package:after_layout/after_layout.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'apply_coupon_page.dart';

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
  String code;
  String gender;
  final _formKey = GlobalKey<FormState>();

  final firstNamecontroller = TextEditingController();
  final lastNamecontroller = TextEditingController();
  final phoneNumbercontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final nextOfkincontroller = TextEditingController();
  final kinNumbercontroller = TextEditingController();
  final genderController = TextEditingController();
  final dobController = TextEditingController();
  var beneficiaryController = TextEditingController();
  List<Widget> adultBeneficiaryNames = [];
  List<Widget> childrenBeneficiaryNames = [];

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
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    //BeneficiaryType beneficiaryType;

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          width: _width,
          height: _height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              myWhiteAppBar(context, 'Travel Detail'),
              CustomAppBar(),
              Expanded(
                child: Container(
                  // padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    // borderRadius:
                    // BorderRadius.vertical(top: Radius.circular(45),
                    // ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              beneficiaryCard(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Contact Information",
                                  style: textStyle2,
                                ),
                              ),
                              InputFormField(
                                label: 'First Name',
                                textCapitalization: TextCapitalization.words,
                                controller: firstNamecontroller,
                                onSaved: (value) {
                                  booking.booking.firstName = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'error';
                                  }
                                  return null;
                                },
                              ),
                              InputFormField(
                                label: 'Last Name',
                                textCapitalization: TextCapitalization.words,
                                controller: lastNamecontroller,
                                onSaved: (value) =>
                                    booking.booking.lastName = value,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'error';
                                  }
                                  return null;
                                },
                              ),
                              InputFormField(
                                prefixIcon: CountryCodePicker(
                                  onChanged: (value) => code = value.toString(),
                                  initialSelection: '+234',
                                  favorite: ['+234', 'NG'],
                                  showCountryOnly: false,
                                  showFlag: true,
                                  showOnlyCountryWhenClosed: false,
                                  alignLeft: false,
                                  barrierColor: Colors.red,
                                  textStyle: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                                label: 'Phone Number',
                                keyboardType: TextInputType.phone,
                                controller: phoneNumbercontroller,
                                onSaved: (value) =>
                                    booking.booking.phoneNumber = value,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'error';
                                  } else if (value.length != 11) {
                                    return "phone number must be 11 digits";
                                  }
                                  return null;
                                },
                              ),
                              InputFormField(
                                label: 'Email',
                                keyboardType: TextInputType.emailAddress,
                                controller: emailcontroller,
                                onSaved: (value) =>
                                    booking.booking.email = value,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'error';
                                  }
                                  return null;
                                },
                              ),
                              InkWell(
                                onTap: () async {
                                  DateTime selectedTime =
                                  await booking.showDob(context);
                                  if (selectedTime != null) {
                                    dobController.text =
                                    '${DateFormat('yMMMd').format(selectedTime)}';
                                    booking.booking.DateOfBirth =
                                    "${DateFormat('yyyy-MM-dd').format(selectedTime)}";
                                  }
                                },
                                child: InputFormField(
                                  enabled: false,
                                  controller: dobController,
                                  suffixIcon: Icon(Icons.event_note),
                                  label: 'Date Of Birth-Optional',
                                ),
                              ),
                              InputFormField(
                                label: 'Gender-Optional',
                                keyboardType: TextInputType.name,
                                textCapitalization: TextCapitalization.words,
                                controller: genderController,
                                onSaved: (value) => booking.booking.gender =
                                    (value == "Male") ? 0 : 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Next of Kin Information",
                                  style: textStyle2,
                                ),
                              ),
                              InputFormField(
                                label: 'Full Name',
                                textCapitalization: TextCapitalization.words,
                                controller: nextOfkincontroller,
                                onSaved: (value) =>
                                    booking.booking.nextOfKinName = value,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'error';
                                  }
                                  return null;
                                },
                              ),
                              InputFormField(
                                prefixIcon: CountryCodePicker(
                                  onChanged: (value) => code = value.toString(),
                                  initialSelection: '+234',
                                  favorite: ['+234', 'NG'],
                                  showFlag: true,
                                  showCountryOnly: false,
                                  showOnlyCountryWhenClosed: false,
                                  alignLeft: false,
                                  textStyle: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                                label: 'Phone Number',
                                keyboardType: TextInputType.phone,
                                controller: kinNumbercontroller,
                                onSaved: (value) =>
                                    booking.booking.nextOfKinPhone = value,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'error';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 30),
                              Buttons.coloredButton(
                                context: context,
                                title: "Proceed",
                                onTap: () async {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    booking.booking.beneficiaries = [
                                      ...adultBeneficiary,
                                      ...childrenBeneficiary
                                    ];
                                  }
                                  if (booking.getBuses.numberOfAdults - 1 ==
                                          adultBeneficiaryNames.length &&
                                      booking.getBuses.numberOfChildren ==
                                          childrenBeneficiary.length) {
                                    Get.to(() => ApplyCoupon());
                                  } else {
                                    Get.snackbar("Oops",
                                        "You need to add beneficiaries");
                                  }

                                  // Get.to(() => ApplyCoupon());
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell travllersContainer(_height, _width, travellerType) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => SingleChildScrollView(
            child: bottomSheet(
              context: context,
              height: _height,
              width: _width,
              beneficiaryType: travellerType,
            ),
          ),
        );
      },
      child: TravellersContainer(
          travellerType == BeneficiaryType.adult ? 'Adult(s)' : 'Child(ren)'),
    );
  }

  Container bottomSheet({
    BuildContext context,
    double height,
    double width,
    BeneficiaryType beneficiaryType,
  }) {
    beneficiaryController.clear();
    Beneficiaries beneficiaries = Beneficiaries();
    int seatNumber = myList.last;
    print('beneficiaryType');
    print(BeneficiaryType);
    int index = (beneficiaryType == BeneficiaryType.adult)
        ? adultBeneficiaryNames.length
        : childrenBeneficiaryNames.length;
    // travellingPartner =  (beneficiaryType == BeneficiaryType.adult)
    //     ? 'Adult(s)'
    //     : childrenBeneficiaryNames.length;
    return Container(
      color: Colors.transparent,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
            color: Theme.of(context).scaffoldBackgroundColor),
        height: height * 0.5,
        width: width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: 50,
                      height: 4,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Text(
                  'Add Beneficiary\'s Name',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                SizedBox(height: 15),
                Text(
                  'Add the name of a travelling partner',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                InputFormField(
                  label: 'Full Name',
                  textCapitalization: TextCapitalization.words,
                  controller: beneficiaryController,
                ),
                RadioListBuilder(),
                SizedBox(height: 20),
                Buttons.coloredButton(
                    context: context,
                    title: 'Add Beneficiary',
                    onTap: () {
                      if (beneficiaryController.text != '') {
                        Widget listTile = Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Icon(Icons.account_circle),
                              SizedBox(width: 15),
                              Expanded(
                                child: Text(beneficiaryController.text),
                              ),
                              SizedBox(width: 5),
                              IconButton(
                                icon: Icon(Icons.cancel,
                                    size: 20, color: Colors.redAccent),
                                onPressed: () {
                                  myList.add(seatNumber);
                                  if (beneficiaryType ==
                                      BeneficiaryType.adult) {
                                    adultBeneficiary.remove(beneficiaries);
                                    adultBeneficiaryNames.removeAt(index);
                                  } else {
                                    childrenBeneficiary.remove(beneficiaries);
                                    childrenBeneficiaryNames.removeAt(index);
                                  }

                                  setState(() {});
                                },
                              )
                            ],
                          ),
                        );
                        // Widget listTile = ListTile(
                        //   leading: Icon(Icons.person),
                        //   title: Text(beneficiaryController.text),
                        //   trailing: IconButton(
                        //     icon: Icon(Icons.cancel),
                        //     onPressed: () {
                        //       myList.add(seatNumber);
                        //       if (beneficiaryType == BeneficiaryType.adult) {
                        //         adultBeneficiary.remove(beneficiaries);
                        //         adultBeneficiaryNames.removeAt(index);
                        //       } else {
                        //         childrenBeneficiary.remove(beneficiaries);
                        //         childrenBeneficiaryNames.removeAt(index);
                        //       }
                        //
                        //       setState(() {});
                        //     },
                        //   ),
                        // );
                        beneficiaries.fullName = beneficiaryController.text;

                        beneficiaries.seatNumber = seatNumber;
                        // if (beneficiaryType[index] == 0) {
                        //   beneficiaries.passengerType = 0; //adult passenger
                        //   adultBeneficiaryNames.insert(index, listTile);
                        //   adultBeneficiary.add(beneficiaries);
                        // } else {
                        //   beneficiaries.passengerType = 1; //child passenger
                        //   childrenBeneficiaryNames.insert(index, listTile);
                        //   childrenBeneficiary.add(beneficiaries);
                        // }
                        //
                        //   myList.remove(seatNumber);
                        //
                        setState(() {
                          beneficiaries.fullName = beneficiaryController.text;

                          beneficiaries.seatNumber = seatNumber;

                          if (beneficiaryType == BeneficiaryType.adult) {
                            beneficiaries.passengerType = 0; //adult passenger
                            adultBeneficiaryNames.insert(index, listTile);
                            adultBeneficiary.add(beneficiaries);
                          } else {
                            beneficiaries.passengerType = 1; //child passenger
                            childrenBeneficiaryNames.insert(index, listTile);
                            childrenBeneficiary.add(beneficiaries);
                          }

                          myList.remove(seatNumber);
                        });
                        Get.back();
                      } else
                        Dialogs.showErrorSnackBar(
                            'Error!', 'Beneficiary field is empty');
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///TODO TST WITH GUEST LOGIN

  @override
  void afterFirstLayout(BuildContext context) {
    myList = seatSelection.selectedSeats;
    myList.removeAt(0);
    repository.getSavedProfile().then((_) {
      firstNamecontroller.text = repository.profile.object.firstName ?? "";
      lastNamecontroller.text = repository.profile.object.lastName ?? "";
      phoneNumbercontroller.text = repository.profile.object.phoneNumber ?? "";
      genderController.text = repository.profile.object.gender;
      emailcontroller.text = repository.profile.object.email ?? "";
      nextOfkincontroller.text = repository.profile.object.nextOfKin ?? "";
      kinNumbercontroller.text = repository.profile.object.nextOfKinPhone ?? "";
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  beneficiaryCard() {
    int noOfAdultBeneficiaries = booking.getBuses.numberOfAdults - 1 ?? 0;
    int noOfChildrenBeneficiaries = booking.getBuses.numberOfChildren ?? 0;
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        (booking.getBuses.numberOfAdults > 1)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  (noOfAdultBeneficiaries == adultBeneficiaryNames.length)
                      ? beneficiaryHeader('Adults', Colors.indigo)
                      : Container(),
                  ...adultBeneficiaryNames,
                  (noOfAdultBeneficiaries > adultBeneficiaryNames.length)
                      ? travllersContainer(
                          _height,
                          _width,
                          BeneficiaryType.adult,
                        )
                      : SizedBox()
                ],
              )
            : SizedBox(),
        (noOfChildrenBeneficiaries > 0)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  (noOfChildrenBeneficiaries == childrenBeneficiaryNames.length)
                      ? beneficiaryHeader('Child(ren)', Colors.blueAccent)
                      : Container(),
                  ...childrenBeneficiaryNames,
                  (noOfChildrenBeneficiaries > childrenBeneficiaryNames.length)
                      ? travllersContainer(
                          _height, _width, BeneficiaryType.children)
                      : SizedBox(),
                ],
              )
            : SizedBox(),
      ],
    );
  }

  Padding beneficiaryHeader(title, color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
          color: color,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          )),
    );
  }
}

class TravellersContainer extends StatelessWidget {
  final String partner;

  TravellersContainer(this.partner);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 5),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Click here to add travelling $partner',
                  style: TextStyle(fontSize: 13, color: Colors.white),
                ),
              ),
              Icon(
                Icons.add_circle,
                color: Colors.white,
                size: 18,
              ),
              SizedBox(
                width: 15,
              )
            ],
          ),
        ),
        decoration:
            BoxDecoration(color: Colors.blueGrey, boxShadow: <BoxShadow>[
          BoxShadow(
              spreadRadius: 2,
              blurRadius: 2,
              color: Colors.grey.withOpacity(0.3),
              offset: Offset(0.7, 1))
        ]),
      ),
    );
  }
}

enum Gender { male, female }
enum BeneficiaryType { adult, children }
// List<String> BeneficiaryType = [ 'adult', 'children' ];

class RadioListBuilder extends StatefulWidget {
  @override
  RadioListBuilderState createState() {
    return RadioListBuilderState();
  }
}

class RadioListBuilderState extends State<RadioListBuilder> {
  Gender selectedGender = Gender.male;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RadioListTile(
              value: Gender.male,
              title: Text("Male"),
              groupValue: selectedGender,
              onChanged: (Gender value) {
                selectedGender = value;
                setState(() {});
              }),
        ),
        Expanded(
          child: RadioListTile(
              value: Gender.female,
              title: Text("Female"),
              groupValue: selectedGender,
              onChanged: (Gender value) {
                selectedGender = value;
                setState(() {});
              }),
        ),
      ],
    );
  }
}
