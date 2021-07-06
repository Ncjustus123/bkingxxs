import 'package:flutter/material.dart';

import 'Reusables/constants.dart';

class NetworkDialog{
static noNetwork(context, String title, content,onpressed) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => Dialog(
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Icon(
              Icons.wifi_off,
              color: Colors.green,
              size: 90,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              content,
              style: TextStyle(fontSize: 13),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Spacer(),
            SmallButtonReusable(
              name: "Retry",
              onpressed: onpressed,
            ),
          ],
        ),
      ),
    ),
  );
}
}