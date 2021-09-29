import 'package:Libmot_Mobile/Reusables/text_field.dart';
import 'package:Libmot_Mobile/controllers/booking_repository.dart';
import 'package:Libmot_Mobile/controllers/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:Libmot_Mobile/constants/Buttons/buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'change_password.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({@required this.name});

  final String name;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static getInitial(String name) => name.isNotEmpty
      ? name.trim().split(' ').map((l) => l[0]).take(2).join()
      : '';
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final nKinController = TextEditingController();
  final nkinPhoneController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();
  final genderController = TextEditingController();
  final customerController = TextEditingController();
  bool _enabled = false;

  @override
  void initState() {
    super.initState();
  }

  Widget _showCustomerType(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    //int type;
    return Container(
      padding:
      EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      height: _height * 0.35,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: customerListSheet(),
    );
  }

  customerListSheet() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          color: Theme.of(context).scaffoldBackgroundColor),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Select Customer Type',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
          ),
          Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: Column(
                  children:
                  List<Widget>.generate(customerTypeList.length, (index) {
                    return new ListTile(
                      onTap: () {
                        selectCustomerType(customerTypeList[index]);
                      },
                      title: Text(
                        customerTypeList[index],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight:
                          customerController.text == customerTypeList[index]
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                      trailing:
                      customerController.text == customerTypeList[index]
                          ? Icon(Icons.check,
                          size: 15,
                          color: Theme.of(context).primaryColor)
                          : Text(''),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void selectCustomerType(String option) {
    setState(() {
      customerController.text = option;
    });
    Get.back();
  }

  List<String> customerTypeList = [
    'Employee',
    'Business Class',
    'Student',
    'Others'
  ];
  BookingRepository booking;

  @override
  Widget build(BuildContext context) {
    booking = Provider.of<BookingRepository>(context);
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final user = Provider.of<UserRepository>(context);
    fnameController.text = user.profile.object.firstName;
    lnameController.text = user.profile.object.lastName;
    nKinController.text = user.profile.object.nextOfKin;
    nkinPhoneController.text = user.profile.object.nextOfKinPhone;
    phoneController.text = user.profile.object.phoneNumber;
    emailController.text = user.profile.object.email;
    genderController.text = user.profile.object.gender;
    dobController.text = user.profile.object.dateJoined;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        width: _width,
        height: _height,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
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
                  Text("Profile",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15)),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _enabled = !_enabled;
                      });
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
                          Icons.edit,
                          color: Theme.of(context).primaryColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 90.0,
              height: 90.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2.0),
              ),
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                child: Text(
                  user.profile != null
                      ? '${getInitial('${user.profile.object.firstName ?? 'Guest'} ${user.profile.object.lastName ?? 'USER'}').toString().toUpperCase()}'
                      : 'GU',
                  style: TextStyle(fontSize: 23, color: Colors.white),
                ),
                //backgroundImage: AssetImage('assets/NEDU.jpeg'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(Icons.person_outlined, color: Colors.white),
                    ),
                    Text(
                      '${fnameController.text} ${lnameController.text}',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Icon(Icons.mail_outlined, color: Colors.white),
                    ),
                    Text(
                      '${emailController.text}',
                      style: TextStyle(fontSize: 13, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
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
                  child: SingleChildScrollView(
                    child: Column(children: [
                      InputFormField(
                        prefixIcon: Icon(Icons.phone),
                        label: 'PhoneNumber',
                        enabled: _enabled,
                        controller: phoneController,
                      ),
                      // InputFormField(
                      //   prefixIcon: Icon(Icons.email_outlined),
                      //   label: 'Email',
                      //   enabled: _enabled,
                      //   controller: emailController,
                      // ),
                      InkWell(
                        onTap: () {
                          _enabled
                              ? showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => SingleChildScrollView(
                                child: _showCustomerType(context)),
                          )
                              : print('...');
                        },
                        child: InputFormField(
                          enabled: false,
                          suffixIcon: Icon(Icons.expand_more),
                          label: 'Customer type',
                          controller: customerController,
                        ),
                      ),
                      InputFormField(
                        enabled: _enabled,
                        prefixIcon: Icon(Icons.people_outlined),
                        label: 'Next Of Kin',
                        controller: nKinController,
                      ),
                      InputFormField(
                        enabled: _enabled,
                        prefixIcon: Icon(Icons.person_add_alt_1_outlined),
                        label: 'Next Of Kin PhoneNumber',
                        controller: nkinPhoneController,
                      ),
                      InputFormField(
                        enabled: _enabled,
                        prefixIcon: Icon(Icons.supervisor_account_outlined),
                        label: 'Gender',
                        controller: genderController,
                      ),
                      InputFormField(
                        enabled: _enabled,
                        prefixIcon: Icon(Icons.event_outlined),
                        label: 'Date of birth',
                        controller: dobController,
                        ontap: () async {
                          DateTime selectedTime =
                          await booking.showDob(context);
                          if (selectedTime != null) {
                            dobController.text =
                            '${DateFormat('yMMMd').format(selectedTime)}';
                          }
                        },
                      ),

                      SizedBox(
                        height: 19,
                      ),

                      _enabled
                          ? ButtonReusable(
                        textcolor: Colors.black,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        name: "Update profile",
                        onpressed: () {
                          user.updateProfile(context);
                        },
                      )
                          : ButtonReusable(
                        textcolor: Colors.black,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        name: "Change Password",
                        onpressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ChangePassword()));
                        },
                      ),

                      SizedBox(
                        height: 15,
                      ),
                      ButtonReusable(
                        textcolor: Theme.of(context).primaryColor,
                        name: "Sign Out",
                        color: Colors.white,
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//
//             SizedBox(height: 8.0),
//             Text(
//               'Chinedu',
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 25.0,
//                   color: Colors.white),
//             ),
//             Text(
//               'unfortunate i was born a nigerian',
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18.0,
//                   color: Colors.white),
//             ),
