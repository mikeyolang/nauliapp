import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nauliapp/Constants/images.dart';
import 'package:nauliapp/Models/onboarding_itens.dart';
import 'package:nauliapp/Screens/Onboarding/dot_indicator.dart';
import 'package:nauliapp/Screens/Onboarding/onboarding_content.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _pageIndex = 0;
  Timer? _timer;
  @override
  void initState() {
    _pageController = PageController();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageIndex < 2) {
        _pageIndex++;
      } else {
        _pageIndex = 0;
      }
      _pageController.animateToPage(
        _pageIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
    super.initState();
  }

  final List<OnboardingItems> _onboardingItems = [
    OnboardingItems(
      title: "Welcome To Nauli App",
      description: "Lorem20",
      imagePath: onboardImageOne,
    ),
    OnboardingItems(
      title: "Welcome To Nauli App",
      description: "Lorem20",
      imagePath: onboardImageOne,
    ),
    OnboardingItems(
      title: "Welcome To Nauli App",
      description: "Lorem20",
      imagePath: onboardImageOne,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerry = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: mediaQuerry.height,
          width: mediaQuerry.width,
          padding: const EdgeInsets.all(20),
          // Bachkground Gradient
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                tileMode: TileMode.clamp),
          ),
          child: Column(
            children: [
              // Carousel Area
              Expanded(
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      _pageIndex = value;
                    });
                  },
                  itemCount: _onboardingItems.length,
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    return OnboardingContent(
                      image: _onboardingItems[index].imagePath,
                      title: _onboardingItems[index].title,
                      description: _onboardingItems[index].description,
                    );
                  },
                ),
              ),
              // Bottom Area
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < _onboardingItems.length; i++)
                    if (i == _pageIndex)
                      const DotIndicator(
                        isActive: true,
                      )
                    else
                      const DotIndicator(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: mediaQuerry.width,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.lightGreen,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    "Log In",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: mediaQuerry.width,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.lightGreen,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Register"),
                ),
              ),
              SizedBox(
                height: mediaQuerry.height / 17.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
