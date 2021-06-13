import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatelessWidget {
  List imagePages = [
    OnboardingWidget(
      image: "images/Bookings.png",
      name: "BOOKINGS ",
      description: "Click here to get tickets ",
    ),
    OnboardingWidget(
        image: "images/Extensive Features.png",
        name: "EXTENSIVE FEATURES",
        description: "Amazing features for our customers"),
    OnboardingWidget(
        image: "images/Exclusive Offers.png",
        name: "EXCLUSIVE FEATURES",
        description:
            "We've got some exclusive offers for our customers you don't want to miss"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Container(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 300.0,
                    autoPlay: false,
                  ),
                  items: imagePages.map((e) {
                    return Builder(builder: (BuildContext context) {
                      return Container(
                        // height: MediaQuery.of(context).size.height,
                        // width: MediaQuery.of(context).size.width,
                        child: e,
                      );
                    });
                  }).toList(),
                ),
              ),
              SizedBox(
                width: 300.0,
                height: 50.0,
                child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Get Started"),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )))),
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingWidget extends StatelessWidget {
  final String image;
  final String name;
  final String description;
  const OnboardingWidget({
    @required this.image,
    @required this.name,
    @required this.description,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/Lekki-Ikoyi Link Bridge 1.png"),
          fit: BoxFit.cover,
        ),),
      //color: Colors.white,
      child: Column(
        children: [
          Expanded(
              child: Image.asset(
            image,
            height: 800,
          )),
          SizedBox(height: 20),
          Column(
            children: [
              Text(
                name,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                description,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
