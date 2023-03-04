// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  bool isLast = false;
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/potato_1.png',
      title: 'On Board 1 Title',
      body: 'On Board 1 body',
    ),
    BoardingModel(
      image: 'assets/images/potato_2.png',
      title: 'On Board 2 Title',
      body: 'On Board 2 body',
    ),
    BoardingModel(
      image: 'assets/images/potato_3.png',
      title: 'On Board 3 Title',
      body: 'On Board 3 body',
    ),
  ];

  void onSubmit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(context, LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('On Boarding'),
          actions: [
            TextButton(
              onPressed: () {
                onSubmit();
              },
              child: Text('Skip'),
            ),
          ],
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: boardController,
                  onPageChanged: (index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                      print('last');
                    } else {
                      setState(() {
                        isLast = false;
                        print('not Last');
                      });
                    }
                  },
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boarding[index]),
                  itemCount: 3,
                ),
              ),
              SizedBox(height: 40.0),
              Row(
                children: [
                  SmoothPageIndicator(
                      controller: boardController,
                      effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: defaultColor,
                        dotHeight: 10.0,
                        expansionFactor: 4,
                        dotWidth: 10.0,
                        spacing: 5.0,
                      ),
                      count: boarding.length),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast == true) {
                        onSubmit();
                      } else {
                        boardController.nextPage(
                          duration: Duration(milliseconds: 800),
                          curve: Curves.bounceOut,
                        );
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Expanded(child: Image(image: AssetImage(model.image))),
          SizedBox(height: 20.0),
          Text(
            model.title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            model.body,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      );
}
