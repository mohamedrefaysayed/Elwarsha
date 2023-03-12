// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, duplicate_ignore

import 'dart:async';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../Constents/colors.dart';
import '../../../Helper/MyApplication.dart';
import '../Main_Screen/MainScreen.dart';
import '../On_board/On_board.dart';
import '../../../global/global.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../auth/Login_Screen.dart';
import '../auth/verfyEmailPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
    required this.showHome,
  }) : super(key: key);
  final bool showHome;
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1500), () async {
      if (widget.showHome) {
        if (fauth.currentUser != null) {
          if (!fauth.currentUser!.emailVerified) {
            myApplication.navigateToRemove(context, const verfyEmailPage());
          } else {
            myApplication.navigateToRemove(context, const MainScreen());
          }
        } else if(await FacebookAuth.instance.accessToken!= null || await GoogleSignIn().isSignedIn()){
            myApplication.navigateToRemove(context, const MainScreen());
        }else {
          // ignore: use_build_context_synchronously
          myApplication.navigateToRemove(context,  LoginScreen());
        }
      } else {
        myApplication.navigateToRemove(context, const Onboard());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: mycolors.first_color,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: myApplication.hightClc(255, context),
                      width: myApplication.widthClc(255, context),
                      child: Image.asset(
                        "assets/images/Icon.png",
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: myApplication.hightClc(250, context),
                      width: myApplication.widthClc(250, context),
                      child: Image.asset(
                        "assets/images/Icon.png",
                        color: mycolors.popColor,
                      ),
                    ),
                    SizedBox(
                      height: myApplication.hightClc(245, context),
                      width: myApplication.widthClc(245, context),

                      child: Image.asset(
                        "assets/images/Icon.png",
                        color: mycolors.secod_color,

                      ),
                    ),
                    SizedBox(
                      height: myApplication.hightClc(245, context),
                      width: myApplication.widthClc(245, context),

                      child: Image.asset(
                        "assets/images/blackScrew.png",
                        color: mycolors.popColor,

                      ),
                    ),


                  ],
                ),
                const SizedBox(
                  height: 200,
                ),
                // Image.asset("assets/images/logo.gif", height: 200.0, width: 200.0,),
                Stack(
                  children: [
                    SizedBox(
                      width: 99,
                      height: 97,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballPulse,
                        strokeWidth: 3,
                        colors: [mycolors.secod_color],
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballPulse,
                        strokeWidth: 3,
                        colors: [mycolors.popColor],
                      ),
                    ),


                  ],
                ),
              ],
            ),

            // CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>(Colors.white),),
          ],
        ),
      ),
    );
  }
}
