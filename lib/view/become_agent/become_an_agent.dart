import 'package:Libmot_Mobile/models/agent_Registration_model.dart';
import 'package:Libmot_Mobile/repository/agent_provider.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BecomeAnAgent extends StatefulWidget {
  @override
  _BecomeAnAgentState createState() => _BecomeAnAgentState();
}

class _BecomeAnAgentState extends State<BecomeAnAgent> {
  int index = 0;

  final _individualFormkey = GlobalKey<FormState>();

  final _coporationFormKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();

  final middleNameController = TextEditingController();

  final lastNameController = TextEditingController();

  final addressController = TextEditingController();

  final genderController = TextEditingController();

  final phoneNumberController = TextEditingController();

  final emailController = TextEditingController();

  final nextOfKinNameController = TextEditingController();

  final nextOfKinNumberController = TextEditingController();

  final companyNameController = TextEditingController();

  final natureBusinessController = TextEditingController();

  final companyAddressController = TextEditingController();

  final companyPhoneController = TextEditingController();

  final companyEmailController = TextEditingController();

  Widget switchBetween;

  AgentProvider agentProvider;
  AgentRegistration agentRegistration = AgentRegistration();

  @override
  void initState() {
    switchBetween = individualForm();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    agentProvider = Provider.of<AgentProvider>(context);

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text("Register as:"),
            DefaultTabController(
              length: 2,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TabBar(
                    indicator: BubbleTabIndicator(
                        tabBarIndicatorSize: TabBarIndicatorSize.tab,
                        indicatorHeight: 35,
                        indicatorColor: Colors.red),
                    labelStyle: TextStyle(
                      fontSize: 15,
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Text("An Individual"),
                      Text("A Cooperation"),
                    ],
                    onTap: (i) {
                      setState(() {
                        (i == 0)
                            ? switchBetween = individualForm()
                            : switchBetween = coporationForm();
                        index = i;
                      });
                    }),
              ),
            ),
            AnimatedSwitcher(
              child: switchBetween,
              duration: const Duration(milliseconds: 400),
            ),
          ],
        ),
      ),
    ));
  }

  Widget individualForm() {
    return Form(
      key: _individualFormkey,
      child: Column(
        children: [
          firstName(),
          middleName(),
          lastName(),
          address(),
          gender(),
          phoneNumber(),
          email(),
          nextOfKinName(),
          nextOfKinNumber(),
          applyButton(),
        ],
      ),
    );
  }

  Widget coporationForm() {
    return Form(
      key: _coporationFormKey,
      child: Column(
        children: [
          companyName(),
          businessNature(),
          companyAddress(),
          companyPhone(),
          companyEmail(),
          applyButton(),
        ],
      ),
    );
  }

  Widget firstName() {
    return TextFormField(
        controller: firstNameController,
        validator: (value) {
          if (value.isEmpty) {
            return "Please fill in your first name";
          }
          return null;
        });
  }

  Widget middleName() {
    return TextFormField(
        controller: middleNameController,
        validator: (value) {
          if (value.isEmpty) {
            return "Please fill in your midle name";
          }
          return null;
        });
  }

  Widget lastName() {
    return TextFormField(
        controller: lastNameController,
        validator: (value) {
          if (value.isEmpty) {
            return "Please fill in your last name";
          }
          return null;
        });
  }

  Widget address() {
    return TextFormField(
        controller: addressController,
        validator: (value) {
          if (value.isEmpty) {
            return "Please fill in your address";
          }
          return null;
        });
  }

  Widget gender() {
    return TextFormField(
        controller: genderController,
        validator: (value) {
          if (value.isEmpty) {
            return "Please fill in your gender";
          }
          return null;
        });
  }

  Widget phoneNumber() {
    return TextFormField(
        controller: phoneNumberController,
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value.isEmpty) {
            return "Please fill in your phone number";
          }
          return null;
        });
  }

  Widget email() {
    return TextFormField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value.isEmpty) {
            return "Please fill in your email";
          }
          return null;
        });
  }

  Widget nextOfKinName() {
    return TextFormField(
        controller: nextOfKinNameController,
        validator: (value) {
          if (value.isEmpty) {
            return "Please fill in the name of your next of kin";
          }
          return null;
        });
  }

  Widget nextOfKinNumber() {
    return TextFormField(
        controller: nextOfKinNumberController,
        validator: (value) {
          if (value.isEmpty) {
            return "Please fill in the number of your next of kin";
          }
          return null;
        });
  }

  Widget companyName() {
    return TextFormField(
        controller: companyNameController,
        validator: (value) {
          if (value.isEmpty) {
            return "Please fill in your company name";
          }
          return null;
        });
  }

  Widget businessNature() {
    return TextFormField(
        controller: natureBusinessController,
        validator: (value) {
          if (value.isEmpty) {
            return "Please tell us the nature of your business";
          }
          return null;
        });
  }

  Widget companyAddress() {
    return TextFormField(
        controller: companyAddressController,
        validator: (value) {
          if (value.isEmpty) {
            return "Please fill in the address of your company";
          }
          return null;
        });
  }

  Widget companyPhone() {
    return TextFormField(
        controller: companyPhoneController,
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value.isEmpty) {
            return "Please fill in your company's phone number";
          }
          return null;
        });
  }

  Widget companyEmail() {
    return TextFormField(
        controller: companyEmailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value.isEmpty) {
            return "Please fill in your company's email";
          }
          return null;
        });
  }

  Widget applyButton() {
    return ElevatedButton(
      child: Text("Apply"),
      onPressed: () {
        (index == 0)
            ? {
                if (_individualFormkey.currentState.validate())
                  {fillIndividualRegistrationModel()}
              }
            : {
                if (_coporationFormKey.currentState.validate())
                  {fillCoporationRegistrationModel()}
              };
      },
    );
  }

  fillIndividualRegistrationModel() {
    agentRegistration.firstName = firstNameController.text;
    agentRegistration.middleName = middleNameController.text;
    agentRegistration.lastName = lastNameController.text;
    agentRegistration.address = addressController.text;
    agentRegistration.email = emailController.text;
    //agentRegistration.gender = firstNameController.text;  //female 0, male 1
    agentRegistration.phone = phoneNumberController.text;
    agentRegistration.nextOfKin = nextOfKinNameController.text;
    agentRegistration.nextOfKinPhone = firstNameController.text;

    agentRegistration.companyName = null;
    agentRegistration.natureOfBusiness = null;
    agentRegistration.companyAddress = null;
    agentRegistration.companyEmail = null;
    agentRegistration.businessPhone = null;

    agentRegistration.agentType = index;

    agentProvider.agentRequest(agentRegistration);
  }

  fillCoporationRegistrationModel() {
    agentRegistration.companyName = companyNameController.text;
    agentRegistration.natureOfBusiness = natureBusinessController.text;
    agentRegistration.companyAddress = companyAddressController.text;
    agentRegistration.companyEmail = companyEmailController.text;
    agentRegistration.businessPhone = companyPhoneController.text;

    agentRegistration.firstName = null;
    agentRegistration.middleName = null;
    agentRegistration.lastName = null;
    agentRegistration.address = null;
    agentRegistration.gender = null;
    agentRegistration.phone = null;
    agentRegistration.email = null;
    agentRegistration.nextOfKin = null;
    agentRegistration.nextOfKinPhone = null;

    agentRegistration.agentType = index;

    agentProvider.agentRequest(agentRegistration);
  }

  @override
  void dispose() {
    companyEmailController.dispose();
    companyPhoneController.dispose();
    companyAddressController.dispose();
    natureBusinessController.dispose();
    companyNameController.dispose();
    nextOfKinNumberController.dispose();
    nextOfKinNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    genderController.dispose();
    addressController.dispose();
    lastNameController.dispose();
    middleNameController.dispose();
    firstNameController.dispose();

    super.dispose();
  }
}
