import 'package:Libmot_Mobile/Reusables/constants.dart';
import 'package:Libmot_Mobile/Reusables/text_field.dart';
import 'package:Libmot_Mobile/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'change_password.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({@required this.name});
  final String name;
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
   static getInitial(String name)=>name.isNotEmpty?name.trim().split(' ').map((l)=>l[0]).take(2).join():'';
  bool _enabled = false;
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final user = Provider.of<UserRepository>(context);
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
                        _enabled = true;
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
                   user.profile!=null? '${getInitial('${user.profile.object.lastName??'Guest'} ${user.profile.object.firstName??'Guest'}').toString().toUpperCase()}':'GT',
                  style: TextStyle(fontSize: 23),
                ),
                //backgroundImage: AssetImage('assets/NEDU.jpeg'),
              ),
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
                        //controller: fromController,
                      ),
                      InputFormField(
                        prefixIcon: Icon(Icons.email_outlined),
                        label: 'Email',
                        enabled: _enabled,
                        //controller: fromController,
                      ),
                      InputFormField(
                        enabled: _enabled,
                        prefixIcon: Icon(Icons.person_add_alt_1_outlined),
                        label: 'Next Of Kin',
                        //controller: fromController,
                      ),
                      InputFormField(
                        enabled: _enabled,
                        prefixIcon: Icon(Icons.phone),
                        label: 'Next Of Kin PhoneNumber',
                        //controller: fromController,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ButtonReusable(
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
                        height: 10,
                      ),
                      ButtonReusable(
                        textcolor: Colors.white,
                        name: "Sign Out",
                        color: Theme.of(context).primaryColor,
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
