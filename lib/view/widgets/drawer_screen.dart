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
      color: Colors.red,
      child: Padding(
        padding: EdgeInsets.only(top: 50, left: 40, bottom: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Icon(Icons.thumb_up),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Hello Again',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                NewRow(
                  text: 'LogIn',
                  icon: Icons.login,
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    user.logout();

                    Navigator.of(context).pushNamed("/signUpPage");
                  },
                  child: NewRow(
                    text: 'Sign Up',
                    icon: Icons.person_outline,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                NewRow(
                  text: 'Notification',
                  icon: Icons.notifications_active,
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("/checkBookingStatus");
                  },
                  child: NewRow(
                    text: 'Check booking Status',
                    icon: Icons.assignment_turned_in,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("/helpSupportPage");
                  },
                  child: NewRow(
                    text: 'Help & Support',
                    icon: Icons.headset_mic,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                NewRow(
                  text: 'Rate App',
                  icon: Icons.favorite,
                ),
                SizedBox(
                  height: 20,
                ),
                NewRow(
                  text: 'Share',
                  icon: Icons.share,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.logout,
                  color: Colors.white.withOpacity(0.5),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    user.logout();
                    if (user.loggedInStatus == LoggedInStatus.LoggedOut) {
                      Navigator.of(context).pushNamed("/welcome");
                    }
                  },
                  child: Text(
                    'Log out',
                    style: TextStyle(color: Colors.white.withOpacity(0.5)),
                  ),
                )
              ],
            )
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
          color: Colors.white,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
