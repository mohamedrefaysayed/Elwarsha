// ignore: file_names
import 'dart:async';
import 'package:elwarsha/business_logic/Cubits/Verfy_email/verifyemail_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Constents/colors.dart';
import '../../../../Constents/fontsize.dart';
import '../../../../Helper/MyApplication.dart';
import '../../../../global/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../Info/Car_Info.dart';
import 'Login_Screen.dart';

// ignore: camel_case_types
class verfyEmailPage extends StatefulWidget {
  const verfyEmailPage({Key? key,this.firstname,this.secondname,  this.email}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final firstname;
  // ignore: prefer_typing_uninitialized_variables
  final secondname;
  // ignore: prefer_typing_uninitialized_variables
  final email;


  @override
  State<verfyEmailPage> createState() => _verfyEmailPageState();
}

// ignore: camel_case_types
class _verfyEmailPageState extends State<verfyEmailPage> {
  Timer? timer;

  @override
  void initState() {
    super.initState();

    VerifyemailCubit.isEmailverified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!VerifyemailCubit.isEmailverified) {
      BlocProvider.of<VerifyemailCubit>(context).sendvervEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => BlocProvider.of<VerifyemailCubit>(context).checkemailvervy(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }


  Future signout() async {
    await FirebaseAuth.instance.currentUser!.delete();
    await ffire.collection("customers").doc(userKey).delete();
    // ignore: use_build_context_synchronously
    myApplication.navigateToRemove(context, LoginScreen()) ;
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<VerifyemailCubit, VerifyemailState>(
  builder: (context, state) {
    return VerifyemailCubit.isEmailverified
        ? CarInfo()
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: mycolors.first_color,
              title: const Text(
                'تفعيل الحساب',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              centerTitle: true,
            ),
            body: Container(
              color: mycolors.first_color,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.email == null
                    ? Text(
                      "لقد تم ارسال رابط تغيير كلمة السر على حسابك",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: myfonts.largfont,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )
                    : Text(
                      "لقد تم ارسال رابط تغيير كلمة السر على \n${widget.email} ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: myfonts.largfont,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    VerifyemailCubit.canResendEmail
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: SlideCountdown(
                              onDone: BlocProvider.of<VerifyemailCubit>(context).cansend,
                              textStyle: TextStyle(
                                  fontSize: myfonts.largfont,
                                  color: Colors.white),
                              duration: const Duration(seconds: 90),
                              decoration: BoxDecoration(
                                color: mycolors.first_color,
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: mycolors.popColor),
                        onPressed: VerifyemailCubit.canResendEmail ? (){
                          BlocProvider.of<VerifyemailCubit>(context).checkemailvervy();
                          BlocProvider.of<VerifyemailCubit>(context).cantsent();
                        }: null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'إعادة الارسال',
                              style: TextStyle(
                                  color: mycolors.secod_color,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.email_outlined,
                              color: mycolors.secod_color,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 15,
                          backgroundColor: mycolors.first_color,
                        ),
                        onPressed: () async => signout(),
                        child: Text(
                          'إلغاء',
                          style: TextStyle(
                              color: mycolors.popColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  },
);
}