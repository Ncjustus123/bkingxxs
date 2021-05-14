import 'package:flutter/material.dart';

Widget appBarPassengerInfo() {
  return PreferredSize(
    preferredSize: Size.fromHeight(85),
    child: AppBar(
      automaticallyImplyLeading: false,
      elevation: 5,
      backgroundColor: Colors.black,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Container(
          height: 60,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "hdh",
                    style: TextStyle(color: Colors.green),
                  ),
                  Text(
                    "hdh",
                    style: TextStyle(color: Colors.green),
                  ),
                  Spacer(),
                  Text(
                    "hdh",
                    style: TextStyle(color: Colors.green),
                  ),
                  Text(
                    "hdh",
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
              Divider(
                height: 3,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
