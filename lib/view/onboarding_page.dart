import 'package:Libmot_Mobile/repository/user_repository.dart';
import 'package:Libmot_Mobile/resources/database/user_preference.dart';
import 'package:Libmot_Mobile/view/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingInfo {
  final imageAsset;
  final title;
  final description;

  OnBoardingInfo(this.imageAsset, this.title, this.description);
}

class OnBoardingController extends GetxController {
  var selectedPageIndex = 0.obs;

  bool get isLastPage => selectedPageIndex.value == onBoardingPages.length - 1;
  var pageController = PageController();

  forwardAction() {
    if (isLastPage) {
    } else
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
  }

  List<OnBoardingInfo> onBoardingPages = [
    OnBoardingInfo('images/Bookings.png', 'BOOKINGS',
        'Amazing Booking System to make your travels remarkable'),
    OnBoardingInfo('images/Extensive Features.png', 'EXTENSIVE FEATURES',
        'Amazing Features for our customers'),
    OnBoardingInfo('images/Exclusive offers.png', 'EXCLUSIVE OFFERS',
        'We’ve got some exclusive offers for our customers that you don’t want to miss out')
  ];
}

class OnBoardingPage extends StatelessWidget {
  final _controller = OnBoardingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            child: Image.asset('images/background.png', fit: BoxFit.fill),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          PageView.builder(
              controller: _controller.pageController,
              onPageChanged: _controller.selectedPageIndex,
              itemCount: _controller.onBoardingPages.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        _controller.onBoardingPages[index].imageAsset,
                        width: size.width * 0.75,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 15),
                      Text(
                        _controller.onBoardingPages[index].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 64.0),
                        child: Text(
                          _controller.onBoardingPages[index].description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                );
              }),
          Positioned(
            bottom: 45,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _controller.onBoardingPages.length,
                      (index) => Obx(() {
                        return Container(
                          margin: const EdgeInsets.all(3),
                          width: _controller.selectedPageIndex.value == index
                              ? 50
                              : 20,
                          height: _controller.selectedPageIndex.value == index
                              ? 4
                              : 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: _controller.selectedPageIndex.value == index
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                            // shape: BoxShape.circle,
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      _controller.isLastPage
                          ? goToWelcome()
                          : _controller.forwardAction();
                    },
                    child: Obx(() {
                      return Container(
                          decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  offset: Offset(0.2, 0.3))
                            ],
                            border: Border.all(color: Colors.white, width: 0.7),
                            borderRadius: BorderRadius.circular(5),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 15),
                            child: Center(
                              child: Text(
                                _controller.isLastPage ? 'Get Started' : 'Next',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ),
                          ));
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  goToWelcome() async {
    final preference = await UserPreference.getInstance();
    preference.firstTimeUser();
  }
}
