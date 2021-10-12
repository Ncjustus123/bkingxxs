import 'package:Libmot_Mobile/Reusables/text_field.dart';
import 'package:Libmot_Mobile/constants/constants.dart';
import 'package:Libmot_Mobile/models/sign_up_model.dart';
import 'package:Libmot_Mobile/controllers/user_repository.dart';
import 'package:Libmot_Mobile/view/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:Libmot_Mobile/services/networking/internet_utils.dart';
import 'package:Libmot_Mobile/constants/dialogs/dialog.dart';
import 'package:Libmot_Mobile/constants/Buttons/buttons.dart';
import 'package:Libmot_Mobile/Reusables/text_field.dart';

// ignore: must_be_immutable
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final firstNamecontroller = TextEditingController();
  final lastNamecontroller = TextEditingController();
  final gendercontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final phoneNumbercontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmPasswordcontroller = TextEditingController();
  final referralcontroller = TextEditingController();
  bool _passwordVisible = true;
  bool _confirmPasswordVisible = true;
  UserRepository userRepository;
  int gender;
  final _formKeyLogin = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    return Scaffold(
      // backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/background.png"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.red[100].withOpacity(0.2), BlendMode.srcOver),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 20),
                child: Image.asset(
                  "images/LIBMOT LOGO 1.png",
                  height: 55,
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(70),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text("Sign Up",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 25)),
                          ),
                          Text("Sign up with your email and password",
                              style: TextStyle(fontSize: 13)),
                          Center(
                            child: _formPage(user, context),
                          ),
                        ],
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

  Widget _formPage(UserRepository user, context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKeyLogin,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              InputFormField(
                obscure: false,
                controller: firstNamecontroller,
                textCapitalization: TextCapitalization.words,
                label: 'First Name',
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please input your Firstname';
                  }
                  return null;
                },
              ),
              InputFormField(
                controller: lastNamecontroller,
                obscure: false,
                label: 'Last Name',
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please input your Lastname';
                  }
                  return null;
                },
              ),
              InputFormField(
                controller: emailcontroller,
                label: "Email",
                obscure: false,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please input an email';
                  }
                  return null;
                },
              ),
              InputFormField(
                obscure: false,
                label: "Phone number",
                controller: phoneNumbercontroller,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please input a phone number';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => SingleChildScrollView(
                              child: bottomRouteSheet(context)),
                        );
                      },
                      child: InputFormField(
                        label: "Sex-Optional",
                        obscure: false,
                        enabled: false,
                        textCapitalization: TextCapitalization.words,
                        controller: gendercontroller,
                        suffixIcon: Icon(Icons.expand_more),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(child:   InputFormField(
                    obscure: false,
                    controller: referralcontroller,
                    label: "Referral code",
                  ),),
                ],
              ),
              InputFormField(
                controller: passwordcontroller,
                obscure: _passwordVisible,
                label: 'Password',
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please put in your Password';
                  }
                  return null;
                },
                prefixIcon: Icon(Icons.lock_outlined, color: Colors.grey),
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
              InputFormField(
                controller: confirmPasswordcontroller,
                obscure: _confirmPasswordVisible,
                label: 'Confirm Password',
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please confirm the Password';
                  } else if (value != passwordcontroller.text) {
                    return 'Password do not match';
                  }
                  return null;
                },
                prefixIcon: Icon(Icons.lock_outlined, color: Colors.grey),
                suffixIcon: IconButton(
                  icon: Icon(
                    _confirmPasswordVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _confirmPasswordVisible = !_confirmPasswordVisible;
                    });
                  },
                ),
              ),

              SizedBox(
                height: 20,
              ),
              ButtonReusable(
                name: "Sign Up",
                onpressed: () async {
                  FocusScope.of(context).unfocus();
                  register(user, context);
                },
              ),
                     SizedBox(height: 20),
          InkWell(
              onTap: () {
                Navigator.pop(context);
                Get.to(LoginPage());
              },
              child: Text(
                "Already have an account? Sign In",
              )),
              SizedBox(height: 8),
            ]),
        ),
       

    ));
  }

  register(UserRepository user, context) async {
    if (await InternetUtils.checkConnectivity()) {
      if (_formKeyLogin.currentState.validate()) {
        // showLoading(
        //     progressColor: Colors.red,
        //     indicatorColor: Colors.red,
        //     backgroundColor: Colors.white,
        //     textColor: Colors.red,
        //     indicatorType: EasyLoadingIndicatorType.foldingCube,
        //     status: "\nSubmitting.....");

        Map requestObject = SignUpCustomersObject(
          firstName: firstNamecontroller.text,
          lastName: lastNamecontroller.text,
          email: emailcontroller.text,
          referralCode:
              referralcontroller.text == '' ? null : referralcontroller.text,
          password: passwordcontroller.text,
          phoneNumber: phoneNumbercontroller.text,
        ).toJson();
        await user.signUpCustomer(context, requestObject);
        // if (user.loggedInStatus == LoggedInStatus.LoggedIn) {
        //   // Navigator.of(context).pushNamed(dashboardPage);
        //   EasyLoading.dismiss();
        //   Dialogs.showSuccessSnackBar('Successful!', "You are welcome back");
        // } else {
        //   print("An errorOccurred");
        //   EasyLoading.dismiss();
        // }
      } else {
        print("validation not done");
        // EasyLoading.dismiss();
      }
    } else
      Dialogs.showErrorSnackBar(
          'Sorry!', "You do not have internet connection at the moment");
  }

  List<String>genderList = ['Male','Female'];
  Widget bottomRouteSheet(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    //int type;
    return Container(
      padding:
      EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      height: _height * 0.3,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: buildDropList(),
    );
  }

  buildDropList() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          color: Theme.of(context).scaffoldBackgroundColor),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
             'Select Gender - optional',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
          ),
          Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: Column(
                  children: List<Widget>.generate(
                      genderList.length, (index) {
                    return new ListTile(
                      onTap: () {
                        selectFromOption(
                            genderList[index]);
                      },
                      title: Text(
                        genderList[index],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: gendercontroller.text == genderList[index]
                              ? FontWeight.w600
                              : FontWeight.w500,

                        ),
                      ),
                      trailing:  gendercontroller.text == genderList[index]
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

  void selectFromOption(String option) {
    setState(() {
      gendercontroller.text = option;

    });

    Get.back();
  }
}
