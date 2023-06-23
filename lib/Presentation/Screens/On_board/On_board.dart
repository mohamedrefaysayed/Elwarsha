import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:elwarsha/Constents/fontsize.dart';

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
      backgroundColor: mycolors.fontColor,
      appBar: AppBar(
        backgroundColor: mycolors.first_color,
        elevation: 0.0,
        leading: TextButton(
          style: ButtonStyle(
          ),
          onPressed: () => onboard.jumpToPage(2),
          child:  Text(
            'تخط ',
            style: TextStyle(fontSize: myfonts.largfont,color: Colors.white60),
          ),
        ),

      ),
      body: Container(
        decoration: BoxDecoration(
          color: mycolors.first_color,
        ),
        padding: const EdgeInsets.only(bottom: 50),
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, mycolors.first_color],
              stops: [0.35, 3.5],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: PageView(
            onPageChanged: (index) {
              setState(() => isLastPage = index == 2);
            },
            controller: onboard,
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: myApplication.hightClc(155, context),
                          width: myApplication.widthClc(155, context),
                          child: Image.asset(
                            "assets/images/Icon.png",
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: myApplication.hightClc(150, context),
                          width: myApplication.widthClc(150, context),
                          child: Image.asset(
                            "assets/images/Icon.png",
                            color: mycolors.popColor,
                          ),
                        ),
                        SizedBox(
                          height: myApplication.hightClc(145, context),
                          width: myApplication.widthClc(145, context),

                          child: Image.asset(
                            "assets/images/Icon.png",
                            color: mycolors.secod_color,

                          ),
                        ),
                        SizedBox(
                          height: myApplication.hightClc(145, context),
                          width: myApplication.widthClc(145, context),

                          child: Image.asset(
                            "assets/images/blackScrew.png",
                            color: mycolors.popColor,

                          ),
                        ),


                      ],
                    ),
                    Image.asset(
                      "assets/images/Hybrid car-bro 1.png",
                      height: 355.0,
                      width: 322.0,
                    ),
                     SizedBox(
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
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: myApplication.hightClc(155, context),
                          width: myApplication.widthClc(155, context),
                          child: Image.asset(
                            "assets/images/Icon.png",
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: myApplication.hightClc(150, context),
                          width: myApplication.widthClc(150, context),
                          child: Image.asset(
                            "assets/images/Icon.png",
                            color: mycolors.popColor,
                          ),
                        ),
                        SizedBox(
                          height: myApplication.hightClc(145, context),
                          width: myApplication.widthClc(145, context),

                          child: Image.asset(
                            "assets/images/Icon.png",
                            color: mycolors.secod_color,

                          ),
                        ),
                        SizedBox(
                          height: myApplication.hightClc(145, context),
                          width: myApplication.widthClc(145, context),

                          child: Image.asset(
                            "assets/images/blackScrew.png",
                            color: mycolors.popColor,

                          ),
                        ),


                      ],
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
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: myApplication.hightClc(155, context),
                          width: myApplication.widthClc(155, context),
                          child: Image.asset(
                            "assets/images/Icon.png",
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: myApplication.hightClc(150, context),
                          width: myApplication.widthClc(150, context),
                          child: Image.asset(
                            "assets/images/Icon.png",
                            color: mycolors.popColor,
                          ),
                        ),
                        SizedBox(
                          height: myApplication.hightClc(145, context),
                          width: myApplication.widthClc(145, context),

                          child: Image.asset(
                            "assets/images/Icon.png",
                            color: mycolors.secod_color,

                          ),
                        ),
                        SizedBox(
                          height: myApplication.hightClc(145, context),
                          width: myApplication.widthClc(145, context),

                          child: Image.asset(
                            "assets/images/blackScrew.png",
                            color: mycolors.popColor,

                          ),
                        ),


                      ],
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
          : Container(
        color: mycolors.fontColor,
        width: double.infinity,
              height: MediaQuery.of(context).size.height - 776,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: mycolors.first_color,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SmoothPageIndicator(
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
                    TextButton(
                      onPressed: () => onboard.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      ),
                      child:  Text(
                        'التالى',
                        style: TextStyle(fontSize: myfonts.largfont,color: Colors.white60),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
