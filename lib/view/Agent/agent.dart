
import 'package:Libmot_Mobile/Reusables/buttons.dart';
import 'package:Libmot_Mobile/Reusables/text_field.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AgentPage extends StatefulWidget {
  @override
  _AgentPageState createState() => _AgentPageState();
}

class _AgentPageState extends State<AgentPage> {
  String direction;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int indexOfRoute = 0;
  String tripOption = 'One Way';

  @override
  Widget build(BuildContext context) {
    // booking = Provider.of<BookingRepository>(context);
    final _width = MediaQuery
        .of(context)
        .size
        .width;
    final _height = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
        key: _scaffoldKey,
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .primaryColor,
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
                              color: Theme
                                  .of(context)
                                  .primaryColor,
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
                  child: Text("Register as:", style:TextStyle( fontWeight:FontWeight.w700,
                      fontSize: 15,
                      color: Colors.white),),
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
                            indicatorColor: Theme
                                .of(context)
                                .primaryColor),
                        labelStyle: TextStyle(
                          fontSize: 15,
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Theme
                            .of(context)
                            .primaryColor,
                        tabs: [
                          Text("An Individual"),
                          Text("A Cooperation"),
                        ],
                        onTap: (index) {
                          setState(() {
                            indexOfRoute = index;
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
                          color: Theme
                              .of(context)
                              .scaffoldBackgroundColor,
                          borderRadius:
                          BorderRadius.vertical(top: Radius.circular(45))),
                      child: SingleChildScrollView(
                        child: Column(
                            children: [
                              SizedBox(height: 20,),
                              indexOfRoute == 0 ?
                              InputFormField(
                                label: 'First Name',
                                textCapitalization: TextCapitalization.words,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'error';
                                  }
                                  return null;
                                },
                              ): SizedBox(),
                              indexOfRoute == 0 ?
                              InputFormField(
                                label: 'Middle Name',
                                textCapitalization: TextCapitalization.words,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'error';
                                  }
                                  return null;
                                },
                              ):SizedBox(),
                              InputFormField(
                                label: indexOfRoute == 0 ?'last Name':"Comapany Name",
                                textCapitalization: TextCapitalization.words,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'error';
                                  }
                                  return null;
                                },
                              ),
                              InputFormField(
                                label:indexOfRoute == 0 ? 'Address':'Nature of Business',
                                textCapitalization: TextCapitalization.words,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'error';
                                  }
                                  return null;
                                },
                              ),
                              InputFormField(
                                label: indexOfRoute == 0 ?'Phone number':'Company Address',
                                textCapitalization: TextCapitalization.words,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'error';
                                  }
                                  return null;
                                },
                              ),
                              InputFormField(
                                label:indexOfRoute == 0 ? 'Email':'Company Phone no',
                                textCapitalization: TextCapitalization.words,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'error';
                                  }
                                  return null;
                                },
                              ),
                              InputFormField(
                                label: indexOfRoute == 0 ?'Gender':'Company Email',
                                textCapitalization: TextCapitalization.words,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'error';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 10,),
                             indexOfRoute == 0 ? Text("Next of Kin Informtion", style:TextStyle( fontWeight:FontWeight.w700,
                                  fontSize: 17,
                                  color: Colors.black),):SizedBox(),
                              SizedBox(height: 5,),
                              indexOfRoute == 0 ?
                              InputFormField(
                                label: 'Full Name',
                                textCapitalization: TextCapitalization.words,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'error';
                                  }
                                  return null;
                                },
                              ):SizedBox(),
                              indexOfRoute == 0 ?
                              InputFormField(
                                label: 'Phone Number',
                                textCapitalization: TextCapitalization.words,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'error';
                                  }
                                  return null;
                                },
                              ):SizedBox(),
                              SizedBox(height: 20,),
                              Buttons.coloredButton(
                                context: context,
                                title: "Apply",
                                onTap: (){}
                              ),

                            ]
                        ),
                      ),
                    ),

                  ),
                ),
              ]),
            )));
  }
}
