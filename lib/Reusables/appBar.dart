import 'package:flutter/material.dart';
import 'package:get/get.dart';

Padding myAppBar(BuildContext context,title) {
  return Padding(
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
              boxShadow: <BoxShadow>[
                BoxShadow(color: Colors.grey.withOpacity(0.3),offset: Offset(0.2,0.4))
              ]
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
          title,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Colors.white),
        ),
        SizedBox(width: 35),
      ],
    ),
  );
}

Padding myWhiteAppBar(BuildContext context,title) {
  return Padding(
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
              color: Theme.of(context).primaryColor,
              boxShadow: <BoxShadow>[
                BoxShadow(color: Colors.grey.withOpacity(0.3),offset: Offset(0.2,0.4))
              ]
            ),
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Icon(
                Icons.west,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Colors.black),
        ),
        SizedBox(width: 35),
      ],
    ),
  );
}
