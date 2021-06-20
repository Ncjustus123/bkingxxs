import 'package:Libmot_Mobile/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: EdgeInsets.only(top: 50, left: 25, bottom: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:30.0),
              child: Row(
                children: <Widget>[
                  Container(
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                          child: Text(
                        'DP',
                        style: TextStyle(fontSize: 32, color: Colors.white),
                      )),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Hello! Chinedu',
                    style: TextStyle(color: Colors.black87, fontSize: 22),
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                menuOption(
                  icon: 'icons/history.png',
                  title: 'Booking History',
                  onTap: () {},
                ),
                menuOption(
                  icon: 'icons/help.png',
                  title: 'Help & Support',
                  onTap: () {},
                ),
                menuOption(
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
                SizedBox(height: 100),
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
                  height: 20,
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(color: Colors.black),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
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
        padding: const EdgeInsets.only(bottom: 12.0),
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
