import 'package:Libmot_Mobile/Reusables/buttons.dart';
import 'package:Libmot_Mobile/Reusables/text_field.dart';
import 'package:Libmot_Mobile/controllers/agent_provider.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AgentPage extends StatefulWidget {
  @override
  _AgentPageState createState() => _AgentPageState();
}

class _AgentPageState extends State<AgentPage> {
  String direction;

  //final _scaffoldKey = new GlobalKey<FormState>();
  int indexOfRoute = 0;
  int agentType = 0;
  String tripOption = 'One Way';
  final firstname = TextEditingController();
  final middlename = TextEditingController();
  final lasttname = TextEditingController();
  final address = TextEditingController();
  final phonenumber = TextEditingController();
  final email = TextEditingController();
  final gender = TextEditingController();
  final nextofkinfullname = TextEditingController();
  final nextofkinphonenumber = TextEditingController();
  final companyname = TextEditingController();
  final natureofbusiness = TextEditingController();
  final companyaddress = TextEditingController();
  final companyphoneno = TextEditingController();
  final companyemail = TextEditingController();

  AgentProvider agent;

  @override
  Widget build(BuildContext context) {
    agent = Provider.of<AgentProvider>(context);
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              width: _width,
              height: _height,
              child: Column(children: [
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
                      Text(
                        'Become an Agent',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 160),
                  child: Text(
                    "Register as:",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                ),
                SizedBox(width: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: DefaultTabController(
                    length: 2,
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: TabBar(
                        indicator: BubbleTabIndicator(
                            tabBarIndicatorSize: TabBarIndicatorSize.tab,
                            indicatorHeight: 20,
                            indicatorRadius: 20,
                            indicatorColor: Theme.of(context).primaryColor),
                        labelStyle: TextStyle(
                          fontSize: 15,
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Theme.of(context).primaryColor,
                        tabs: [
                          Text("An Individual"),
                          Text("A Cooperation"),
                        ],
                        onTap: (index) {
                          setState(() {
                            indexOfRoute = index;
                            agentType = index;
                          });
                          // booking.getBuses.tripType = index ?? 0 ;
                          // booking.tripTypeChange(index);
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
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
                          SizedBox(
                            height: 20,
                          ),
                          indexOfRoute == 0
                              ? InputFormField(
                                  label: 'First Name',
                                  textCapitalization: TextCapitalization.words,
                                  controller: firstname,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'error';
                                    }
                                    return null;
                                  },
                                )
                              : SizedBox(),
                          indexOfRoute == 0
                              ? InputFormField(
                                  label: 'Middle Name',
                                  textCapitalization: TextCapitalization.words,
                                  controller: middlename,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'error';
                                    }
                                    return null;
                                  },
                                )
                              : SizedBox(),
                          InputFormField(
                            label: indexOfRoute == 0
                                ? 'last Name'
                                : "Comapany Name",
                            textCapitalization: TextCapitalization.words,
                            controller:
                                indexOfRoute == 0 ? lasttname : companyname,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'error';
                              }
                              return null;
                            },
                          ),
                          InputFormField(
                            label: indexOfRoute == 0
                                ? 'Address'
                                : 'Nature of Business',
                            textCapitalization: TextCapitalization.words,
                            controller:
                                indexOfRoute == 0 ? address : natureofbusiness,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'error';
                              }
                              return null;
                            },
                          ),
                          InputFormField(
                            label: indexOfRoute == 0
                                ? 'Phone number'
                                : 'Company Address',
                            textCapitalization: TextCapitalization.words,
                            controller: indexOfRoute == 0
                                ? phonenumber
                                : companyaddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'error';
                              }
                              return null;
                            },
                          ),
                          InputFormField(
                            label: indexOfRoute == 0
                                ? 'Email'
                                : 'Company Phone no',
                            textCapitalization: TextCapitalization.words,
                            controller:
                                indexOfRoute == 0 ? email : companyphoneno,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'error';
                              }
                              return null;
                            },
                          ),
                          InputFormField(
                            label:
                                indexOfRoute == 0 ? 'Gender' : 'Company Email',
                            textCapitalization: TextCapitalization.words,
                            controller:
                                indexOfRoute == 0 ? gender : companyemail,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'error';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          indexOfRoute == 0
                              ? Text(
                                  "Next of Kin Informtion",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17,
                                      color: Colors.black),
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 5,
                          ),
                          indexOfRoute == 0
                              ? InputFormField(
                                  label: 'Full Name',
                                  textCapitalization: TextCapitalization.words,
                                  controller: nextofkinfullname,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'error';
                                    }
                                    return null;
                                  },
                                )
                              : SizedBox(),
                          indexOfRoute == 0
                              ? InputFormField(
                                  label: 'Phone Number',
                                  textCapitalization: TextCapitalization.words,
                                  controller: nextofkinphonenumber,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'error';
                                    }
                                    return null;
                                  },
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 20,
                          ),
                          Buttons.coloredButton(
                              context: context,
                              title: "Apply",
                              onTap: () {
                                print("agentType");
                                print(agentType);
                                (indexOfRoute == 0) ? individual() : company();
                                agent.agentRequest();
                              }),
                        ]),
                      ),
                    ),
                  ),
                ),
              ]),
            )));
  }

  individual() {
    agent.agentModel.email = email.text;
    agent.agentModel.address = address.text;
    agent.agentModel.agentType = agentType;
    agent.agentModel.firstName = firstname.text;
    agent.agentModel.lastName = lasttname.text;
    agent.agentModel.middleName = middlename.text;
    agent.agentModel.nextOfKin = nextofkinfullname.text;
    agent.agentModel.nextOfKinPhone = nextofkinphonenumber.text;
    agent.agentModel.gender = gender.text == "Male" ? 0: 1;
    agent.agentModel.natureOfBusiness = null;
    agent.agentModel.businessPhone = null;
    agent.agentModel.companyAddress = null;
    agent.agentModel.companyEmail = null;
    agent.agentModel.companyName = null;
    agent.agentModel.phone = phonenumber.text;
  }

  company() {
    agent.agentModel.businessPhone = companyphoneno.text;
    agent.agentModel.companyAddress = companyaddress.text;
    agent.agentModel.companyEmail = companyemail.text;
    agent.agentModel.companyName = companyname.text;
    agent.agentModel.natureOfBusiness = natureofbusiness.text;
    agent.agentModel.phone = null;
    agent.agentModel.firstName = null;
    agent.agentModel.lastName = null;
    agent.agentModel.middleName = null;
    agent.agentModel.nextOfKin = null;
    agent.agentModel.nextOfKinPhone = null;
    agent.agentModel.gender = null;
    agent.agentModel.email = null;
    agent.agentModel.address = null;
    agent.agentModel.agentType = agentType;
  }
}
