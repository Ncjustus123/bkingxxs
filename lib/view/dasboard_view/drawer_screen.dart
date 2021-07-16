import 'package:Libmot_Mobile/controllers/user_repository.dart';
import 'package:Libmot_Mobile/view/login/login_page.dart';
import 'package:Libmot_Mobile/view/login/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:Libmot_Mobile/view/login/profile_page.dart';

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
                                    fontSize: 32, color: Colors.white),
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
                      '${toBeginningOfSentenceCase(widget.name ?? 'Guest')}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Column(
              children: <Widget>[
                user.profile == null
                    ? menuOption(
                        icon: 'icons/login.jpg',
                        title: 'Log in',
                        onTap: () {
                          Get.offAll(LoginPage());
                        },
                      )
                    : menuOption(
                        icon: 'icons/history.png',
                        title: 'Booking History',
                        onTap: () {},
                      ),
                user.profile == null
                    ? menuOption(
                        icon: 'icons/signup.png',
                        title: 'Sign Up',
                        onTap: () {
                          Get.offAll(SignUpPage());
                        },
                      )
                    : SizedBox(),
                menuOption(
                  icon: 'icons/coupons.png',
                  title: 'Check Booking Status',
                  onTap: () {
                    Navigator.of(context).pushNamed("/checkBookingStatus");
                  },
                ),
                menuOption(
                  icon: 'icons/notification.png',
                  title: 'Notification',
                  onTap: () {},
                ),
                menuOption(
                  icon: 'icons/help.png',
                  title: 'Help & Support',
                  onTap: () {},
                ),
                user.profile == null
                    ? SizedBox()
                    : menuOption(
                        icon: 'icons/coupons.png',
                        title: 'My Coupons',
                        onTap: () {},
                      ),
                menuOption(
                  icon: 'icons/rate us.png',
                  title: 'Rate Us',
                  onTap: () {},
                ),
                menuOption(
                  icon: 'icons/share.png',
                  title: 'Share App',
                  onTap: () {},
                ),
                // GestureDetector(
                //   onTap: () {
                //     user.logout();
                //     Navigator.of(context).pushNamed("/login");
                //   },
                //   child: NewRow(
                //     text: 'LogIn',
                //     icon: Icons.login,
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // GestureDetector(
                //   onTap: () {
                //     user.logout();
                //     Navigator.of(context).pushNamed("/signUpPage");
                //   },
                //   child: NewRow(
                //     text: 'Sign Up',
                //     icon: Icons.person_outline,
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // NewRow(
                //   text: 'Notification',
                //   icon: Icons.notifications_active,
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.of(context).pushNamed("/checkBookingStatus");
                //   },
                //   child: NewRow(
                //     text: 'Check booking Status',
                //     icon: Icons.assignment_turned_in,
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.of(context).pushNamed("/helpSupportPage");
                //   },
                //   child: NewRow(
                //     text: 'Help & Support',
                //     icon: Icons.headset_mic,
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // NewRow(
                //   text: 'Rate App',
                //   icon: Icons.favorite,
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // NewRow(
                //   text: 'Share',
                //   icon: Icons.share,
                // ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
            Spacer(),
            user.profile == null
                ? SizedBox()
                : Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            print("log out");
                            user.logout();
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
        padding: const EdgeInsets.only(bottom: 8.0),
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
