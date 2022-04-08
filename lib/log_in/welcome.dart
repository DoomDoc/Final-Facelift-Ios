import 'dart:async';

import 'package:flutter/material.dart';

import '../main.dart';
import '../dialogs.dart';
import '../constants.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int currentPage = 0;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 1500), (Timer timer) {
      if (currentPage < 2) {
        currentPage++;
        pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      } else {
        currentPage = 0;
        pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> contentList = [
      welcomeContent(
        context,
        "Manage your house construction",
        "Upload bills, get ideas, track progress, store plans, make payments, and so much more right from your smartphone…",
        "assets/images/1.png",
        "Welcome,",
      ),
      welcomeContent(
        context,
        "Construction laborers",
        "Appoint, overlook, replace, raise an issue with the on-site laborers in one click from the app.",
        "assets/images/2.png",
        "",
      ),
      welcomeContent(
        context,
        "Building materials",
        "Over 750 highest quality materials & products to choose from 170+ National & International brands directly at your site…",
        "assets/images/3.png",
        "",
      ),
    ];

    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        backgroundColor: const Color(0xffebebeb),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 15,
                child: PageView.builder(
                  itemCount: 3,
                  controller: pageController,
                  onPageChanged: (value) => setState(() => currentPage = value),
                  itemBuilder: (context, index) => contentList[index],
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const HomeNotLoggedInScreen())),
                      child: Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(32),
                        child: Container(
                          height: 60,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: pinkColor,
                          ),
                          child: const Center(child: Text("Let's Go")),
                        ),
                      ),
                    ),
                    const SizedBox(height: 45),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 500),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: 6,
      decoration: BoxDecoration(
        border: Border.all(color: pinkColor),
        color: currentPage == index
            ? pinkColor
            : const Color.fromRGBO(240, 240, 240, 1),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  Widget welcomeContent(BuildContext context, String heading, String text,
      String image, String welcome) {
    return Column(
      children: [
        const Spacer(flex: 2),
        Text(welcome, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.37,
            child: Image.asset(
              image,
              // scale: 0,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Spacer(flex: 3),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            heading,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        const Spacer(flex: 7),
      ],
    );
  }
}
