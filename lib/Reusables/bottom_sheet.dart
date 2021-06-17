import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'buttons.dart';

class BottomCard extends StatefulWidget {
  // const BottomCard();

  @override
  _BottomCardState createState() => _BottomCardState();
}

class _BottomCardState extends State<BottomCard> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.transparent,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
            color: Theme.of(context).scaffoldBackgroundColor),
        height: _height * 0.5,
        width: _width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: 50,
                      height: 4,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Text(
                  'Travellers',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                SizedBox(height: 15),
                Text(
                  'Select the number of persons travelling',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    TravellersOptions(
                      title: 'Adult(s)',
                    ),
                    //travellerOption(context, 'Adult(s)'),
                    SizedBox(width: 15),
                    //travellerOption(context, 'Children(ren)'),
                    TravellersOptions(
                      title: 'Children(ren)',
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Buttons.coloredButton(
                  context: context,
                  title: 'Proceed',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

class TravellersOptions extends StatelessWidget {
  final String title;
  const TravellersOptions({this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        Center(
            child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        )),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            addButton(context: context, icon: Icons.add, onTap: () {}),
            Expanded(
                child: TextFormField(
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            )),
            addButton(context: context, icon: Icons.remove, onTap: () {}),
          ],
        ),
      ],
    ));
  }

  addButton({BuildContext context, icon, onTap}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        elevation: 1.5,
        shape: CircleBorder(),
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  offset: Offset(0.5, 0.9),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                  child: Icon(
                icon,
                color: Theme.of(context).primaryColor,
                size: 20,
              )),
            ),
          ),
        ),
      ),
    );
  }
}
