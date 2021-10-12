import 'package:Libmot_Mobile/controllers/user_repository.dart';
import 'package:Libmot_Mobile/services/database/user_preference.dart';
import 'package:Libmot_Mobile/view/booking/booking_history.dart';
import 'package:Libmot_Mobile/view/help_support/help_support_page.dart';
import 'package:Libmot_Mobile/view/login/login_page.dart';
import 'package:Libmot_Mobile/view/login/sign_up_page.dart';
import 'package:Libmot_Mobile/view/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:Libmot_Mobile/view/login/profile_page.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerScreen extends StatefulWidget {
  DrawerScreen({@required this.name});

  final String name;
  static final loginpage = "/login";

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  static getInitial(String name) => name.isNotEmpty
      ? name.trim().split(' ').map((l) => l[0]).take(2).join()
      : '';
  bool loggedIn;
  String text = 'Libra Motors';
  String subject =
      'I travel conveniently with Libra Motors,\nYou can make booking online using the web https://libmot.com/ , or get the mobile app on\n\nAndroid playstore https://play.google.com/store/apps/details?id=com.libramotors.libmot&hl=en&gl=US or\n\niOS appstore https://apps.apple.com/ng/app/libmot-com/id1463064075';

  _onShare({context}) async {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final preference = await UserPreference.getInstance();
    await Share.share(subject,
        subject: subject,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    loggedIn = preference.isLoggedIn() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: EdgeInsets.only(top: 50, left: 25, bottom: 70),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(right: 250),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ProfilePage(
                                        name: user.profile != null
                                            ? '${user.profile.object.lastName ?? 'Guest'}'
                                            : 'Guest',
                                      )));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: Text(
                                user.profile != null
                                    ? '${getInitial('${user.profile.object.lastName} ${user.profile.object.firstName}').toString().toUpperCase()}'
                                    : 'GT',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => ProfilePage(
                                name: user.profile != null
                                    ? '${user.profile.object.lastName ?? 'Guest'}'
                                    : 'Guest',
                              )));
                    },
                    child: Text(
                      '${toBeginningOfSentenceCase(widget.name)}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Expanded(
              child: Column(
                children: <Widget>[
                  user.profile == null
                      ? menuOption(
                    icon: 'icons/login.jpg',
                    title: 'Log in',
                    onTap: () {
                      Get.offAll(() => LoginPage());
                    },
                  )
                      : SizedBox(),
                  user.profile == null
                      ? SizedBox()
                      : menuOption(
                    icon: 'icons/history.png',
                    title: 'Booking History',
                    onTap: () {
                      Get.to(() => BookingHistory());
                    },
                  ),
                  user.profile == null
                      ? menuOption(
                    icon: 'icons/signup.png',
                    title: 'Sign Up',
                    onTap: () {
                      Get.offAll(() => SignUpPage());
                    },
                  )
                      : SizedBox(),

                       menuOption(
                    icon: 'icons/wallet.png',
                    title: 'Wallet',
                    onTap: () {
                      if(user.profile != null) {
                        print("loggedIn");
                        Get.to( WalletPage());
                      }else{
                        Get.snackbar("Opps", "login to Access Wallet");
                      }

                    },
                  ),
                  menuOption(
                    icon: 'icons/coupons.png',
                    title: 'Check Booking Status',
                    onTap: () {
                      Navigator.of(context).pushNamed("/checkBookingStatus");
                    },
                  ),
                  menuOption(
                    icon: 'icons/help.png',
                    title: 'Help & Support',
                    onTap: () {
                      Get.to(() => HelpSupportPage());

                    },
                  ),
                  menuOption(
                    icon: 'icons/share.png',
                    title: 'Share App',
                    onTap: () {
                      _onShare(context: context);
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            user.profile == null
                ? SizedBox()
                : Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      print("log out");
                      user.logout(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(color: Colors.black),
                      child: Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: Text(
                          'Log out',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Row(
            //   children: <Widget>[
            //     Icon(
            //       Icons.logout,
            //       color: Colors.white.withOpacity(0.5),
            //     ),
            //     SizedBox(
            //       width: 10,
            //     ),
            //     GestureDetector(
            //       onTap: () {
            //         user.logout();
            //         if (user.loggedInStatus == LoggedInStatus.LoggedOut) {
            //           Navigator.of(context).pushNamed("/welcome");
            //         }
            //       },
            //       child: Text(
            //         'Log out',
            //         style: TextStyle(color: Colors.white.withOpacity(0.5)),
            //       ),
            //     )
            //   ],
            // )
          ],
        ),
      ),
    );
  }

  InkWell menuOption({icon, onTap, title}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Row(
          children: [
            Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.2)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    icon,
                    height: 23,
                    width: 23,
                  ),
                )),
            SizedBox(width: 15),
            Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 16),
                )),
          ],
        ),
      ),
    );
  }
}

class NewRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const NewRow({
    Key key,
    this.icon,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.black,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.black),
        )
      ],
    );
  }
}
