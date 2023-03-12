import '../../../Constents/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Helper/MyApplication.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';

import '../auth/Login_Screen.dart';

class Onboard extends StatefulWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  final onboard = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mycolors.first_color,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: mycolors.first_color,
        ),
        padding: const EdgeInsets.only(bottom: 50),
        child: PageView(
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2);
          },
          controller: onboard,
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/الورشة.png",
                    height: 100.0,
                    width: 100.0,
                  ),
                  Image.asset(
                    "assets/images/Hybrid car-bro 1.png",
                    height: 355.0,
                    width: 322.0,
                  ),
                  const SizedBox(
                      height: 140,
                      width: 300,
                      child: Text(
                        'يساعدك على طلب ورشة متنقلة \n و حل مشاكل أعطال سيارتك ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: mycolors.first_color,
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/الورشة.png",
                    height: 100.0,
                    width: 100.0,
                  ),
                  Image.asset(
                    "assets/images/Discount-pana 1.png",
                    height: 355.0,
                    width: 322.0,
                  ),
                  const SizedBox(
                      height: 140,
                      width: 300,
                      child: Text(
                        'خدمة معرفة تكلفة التصليح قبل الطلب وعروض وخصومات على قطع الغيار ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: mycolors.first_color,
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/الورشة.png",
                    height: 100.0,
                    width: 100.0,
                  ),
                  Image.asset(
                    "assets/images/City driver-pana 1.png",
                    height: 355.0,
                    width: 322.0,
                  ),
                  const SizedBox(
                      height: 140,
                      width: 300,
                      child: Text(
                        'يتميز التطبيق بخاصية البحث من خلال الكاميرا ومعرفة خط سير الورشة إليك ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? Container(
              decoration: BoxDecoration(
                color: mycolors.first_color,
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: mycolors.first_color,
                  minimumSize: const Size.fromHeight(80),
                ),
                child: const Text('البدء',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                onPressed: () async {
                  // ignore: non_constant_identifier_names
                  final Prefs = await SharedPreferences.getInstance();
                  Prefs.setBool('showHome', true);
                  // ignore: use_build_context_synchronously
                  myApplication.push_size(context,  LoginScreen());
                },
              ),
            )
          : SizedBox(
              height: MediaQuery.of(context).size.height - 800,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: mycolors.first_color,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => onboard.jumpToPage(2),
                      child: const Text(
                        'تخطى',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Center(
                      child: SmoothPageIndicator(
                          controller: onboard, // PageController
                          count: 3,
                          effect: WormEffect(
                              dotColor: Colors.white,
                              activeDotColor: mycolors.secod_color),
                          onDotClicked: (index) => onboard.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn,
                              ) // your preferred effect
                          ),
                    ),
                    TextButton(
                      onPressed: () => onboard.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      ),
                      child: const Text(
                        'التالى',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
