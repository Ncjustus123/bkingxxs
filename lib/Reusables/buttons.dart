import 'package:flutter/material.dart';

class Buttons{

  static coloredButton({BuildContext context, title, onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).primaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                )),
          ),
        ),
      ),
    );
  }

  static whiteButton({BuildContext context, title, onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),

      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).primaryColor, width: 0.7),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor,
                  ),
                )),
          ),
        ),
      ),
    );
  }
}