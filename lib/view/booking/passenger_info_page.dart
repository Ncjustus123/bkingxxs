import 'dart:ui';
import 'package:Libmot_Mobile/Reusables/buttons.dart';
import 'package:country_code_picker/country_code_picker.dart';

import 'package:Libmot_Mobile/Reusables/appBar.dart';
import 'package:Libmot_Mobile/Reusables/constants.dart';
import 'package:Libmot_Mobile/Reusables/text_field.dart';
import 'package:Libmot_Mobile/models/booking_model.dart';
import 'package:Libmot_Mobile/models/get_buses_response.dart';
import 'package:Libmot_Mobile/repository/booking_repository.dart';
import 'package:Libmot_Mobile/repository/seat_selection_repository.dart';
import 'package:Libmot_Mobile/repository/user_repository.dart';
import 'package:Libmot_Mobile/view/widgets/appBar_passenger_info.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    int noOfAdultBeneficiaries = booking.getBuses.numberOfAdults - 1 ?? 0;

    int noOfChildrenBeneficiaries = booking.getBuses.numberOfChildren ?? 0;
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
              (booking.getBuses.numberOfAdults > 1)
                  ? Column(
                      children: [
                        TravellersContainer(
                          "Extra Adult Traveller(s)",
                          Theme.of(context).scaffoldBackgroundColor,
                          Colors.black,
                          Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                        ...adultBeneficiaryNames,
                        (noOfAdultBeneficiaries > adultBeneficiaryNames.length)
                            ? travllersContainer(
                                _height,
                                _width,
                              )
                            : SizedBox()
                      ],
                    )
                  : SizedBox(),
              (noOfChildrenBeneficiaries > 0)
                  ? Column(
                      children: [
                        TravellersContainer(
                          "Extra Child Traveller(s)",
                          Theme.of(context).scaffoldBackgroundColor,
                          Colors.black,
                          Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                        ...childrenBeneficiaryNames,
                        (noOfChildrenBeneficiaries >
                                childrenBeneficiaryNames.length)
                            ? travllersContainer(
                                _height,
                                _width,
                              )
                            : SizedBox()
                      ],
                    )
                  : SizedBox(),
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
                        child: Column(children: [
                          SizedBox(
                            height: 5,
                          ),
                          // beneficaryField(),
                          Center(
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
                              textStyle:
                                  TextStyle(fontSize: 14, color: Colors.black),
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
                            onSaved: (value) => booking.booking.email = value,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'error';
                              }
                              return null;
                            },
                          ),
                          InputFormField(
                            label: 'Gender',
                            keyboardType: TextInputType.name,
                            suffixIcon: Icon(Icons.expand_more),
                            textCapitalization: TextCapitalization.words,
                            controller: genderController,
                            onSaved: (value) => booking.booking.gender = value,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'error';
                              }
                              return null;
                            },
                          ),

                          SizedBox(
                            height: 15,
                          ),
                          Center(
                              child: Text(
                            "Next of Kin Information",
                            style: textStyle2,
                          )),
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
                              textStyle:
                                  TextStyle(fontSize: 14, color: Colors.black),
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
                          ButtonReusable(
                            onpressed: () async {
                              if (_formKey.currentState.validate()) {
                                booking.booking.beneficiaries = [
                                  ...adultBeneficiary,
                                  ...childrenBeneficiary
                                ];
                                _formKey.currentState.save();
                                booking.savePassengerInfo(context);
                              }
                              Get.to(() => ApplyCoupon());
                            },
                            name: "Proceed",
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

  InkWell travllersContainer(
    _height,
    _width,
  ) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => SingleChildScrollView(
            child: bottomSheet(
              context:context,
             height:_height,
              width:_width,
            ),
          ),
        );
      },
      child: TravellersContainer(
        'Click here to add travelling partner(s)',
        Colors.black54,
        Colors.white,
        Icon(
          Icons.add_circle,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

 

  Container bottomSheet(
   { BuildContext context,
    double height,
    double width,
    BeneficiaryType beneficiaryType,}
  ) {
    beneficiaryController.clear();
    Beneficiaries beneficiaries = Beneficiaries();
    int seatNumber = myList.last;
    int index = (beneficiaryType.index == 0)
        ? adultBeneficiaryNames.length
        : childrenBeneficiaryNames.length;
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
                InputFormField(
                  label: 'Gender',
                  textCapitalization: TextCapitalization.words,
                  suffixIcon: Icon(Icons.expand_more),
                  controller: genderController,
                ),
                SizedBox(height: 20),
                Buttons.coloredButton(
                    context: context,
                    title: 'Add Beneficiary',
                    onTap: () {
                      Widget listTile = ListTile(
                        leading: Icon(Icons.person),
                        title: Text(beneficiaryController.text),
                        trailing: IconButton(
                          icon: Icon(Icons.cancel), 
                          onPressed: () {
                            myList.add(seatNumber);
                            if (beneficiaryType.index == 0) {
                              adultBeneficiary.remove(beneficiaries);
                              adultBeneficiaryNames.removeAt(index);
                            } else {
                              childrenBeneficiary.remove(beneficiaries);
                              childrenBeneficiaryNames.removeAt(index);
                            }

                            setState(() {});
                          },
                        ),
                      );

                      setState(() {
                        beneficiaries.fullName = beneficiaryController.text;

                        beneficiaries.seatNumber = seatNumber;

                        if (beneficiaryType.index == 0) {
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
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox proceedButton(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 50.0,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            booking.booking.beneficiaries = [
              ...adultBeneficiary,
              ...childrenBeneficiary
            ];
            _formKey.currentState.save();
            booking.savePassengerInfo(context);
          }
        },
        child: Text("Proceed"),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.red),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }

  ///TODO TST WITH GUEST LOGIN

  @override
  void afterFirstLayout(BuildContext context) {
    //myList = seatSelection.selectedSeats;
    //myList.removeAt(0);
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


  

  // popupDialog(BuildContext context, BeneficiaryType beneficiaryType) {
  //   beneficiaryController.clear();
  //   Beneficiaries beneficial = Beneficiaries();
  //   Gender selectedGender = Gender.male;
  //   int seatNumber = myList.last;
  //   int index = (beneficiaryType.index == 0)
  //       ? adultBeneficiaryNames.length
  //       : childrenBeneficiaryNames.length;
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return Dialog(
  //           child: Container(
  //             height: 200,
  //             child: Column(
  //               children: [
  //                 TextField(
  //                   decoration: InputDecoration(
  //                     hintText: "Name of traveller",
  //                   ),
  //                   controller: beneficiaryController,
  //                 ),
  //                 StatefulBuilder(
  //                   builder: (BuildContext context, StateSetter setState) {
  //                     return Row(
  //                       children: <Widget>[
  //                         Expanded(
  //                           child: RadioListTile(
  //                             title: const Text('Male'),
  //                             value: Gender.male,
  //                             groupValue: selectedGender,
  //                             onChanged: (Gender value) {
  //                               beneficial.gender = value.index;
  //                               selectedGender = value;
  //                               setState(() {});
  //                             },
  //                           ),
  //                         ),
  //                         Expanded(
  //                           child: RadioListTile(
  //                             title: const Text('Female'),
  //                             groupValue: selectedGender,
  //                             value: Gender.female,
  //                             onChanged: (Gender value) {
  //                               beneficial.gender = value.index;
  //                               selectedGender = value;
  //                               setState(() {});
  //                             },
  //                           ),
  //                         ),
  //                       ],
  //                     );
  //                   },
  //                 ),
  //                 ElevatedButton(
  //                     child: Text("Add traveller"),
  //                     onPressed: () {
  //                       Widget listTile = ListTile(
  //                         leading: Icon(Icons.person),
  //                         title: Text(beneficiaryController.text),
  //                         trailing: IconButton(
  //                           icon: Icon(Icons.cancel),
  //                           onPressed: () {
  //                             myList.add(seatNumber);
  //                             if (beneficiaryType.index == 0) {
  //                               adultBeneficiary.remove(beneficial);
  //                               adultBeneficiaryNames.removeAt(index);
  //                             } else {
  //                               childrenBeneficiary.remove(beneficial);
  //                               childrenBeneficiaryNames.removeAt(index);
  //                             }

  //                             setState(() {});
  //                           },
  //                         ),
  //                       );

  //                       setState(() {
  //                         beneficial.fullName = beneficiaryController.text;

  //                         beneficial.seatNumber = seatNumber;

  //                         if (beneficiaryType.index == 0) {
  //                           beneficial.passengerType = 0; //adult passenger
  //                           adultBeneficiaryNames.insert(index, listTile);
  //                           adultBeneficiary.add(beneficial);
  //                         } else {
  //                           beneficial.passengerType = 1; //child passenger
  //                           childrenBeneficiaryNames.insert(index, listTile);
  //                           childrenBeneficiary.add(beneficial);
  //                         } 

  //                         myList.remove(seatNumber);
  //                       });
  //                       Navigator.pop(context);
  //                     })
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
}

class TravellersContainer extends StatelessWidget {
  final String title;
  final Color color;
  final Color textColor;
  final Icon icon;
  TravellersContainer(this.title, this.color, this.textColor, this.icon);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(color: textColor, fontSize: 13),
                ),
              ),
              icon,
            ],
          ),
        ),
        decoration: BoxDecoration(color: color, boxShadow: <BoxShadow>[
          BoxShadow(
              spreadRadius: 3,
              blurRadius: 3,
              color: Colors.grey.withOpacity(0.3),
              offset: Offset(2, 3))
        ]),
      ),
    );
  }
}

enum Gender { male, female }
enum BeneficiaryType { adult, children }
