import 'package:elwarsha/Presentation/Screens/auth/Login_Screen.dart';
import 'package:elwarsha/business_logic/Cubits/Reset_password/reset_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../../Constents/colors.dart';
import '../../../../Constents/fontsize.dart';
import '../../../../Helper/MyApplication.dart';
import '../../../Helper/MY_SnackBar.dart';
class ResetPassowrd extends StatefulWidget {
  const ResetPassowrd({
    Key? key,
    required this.email,
  }) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final email;

  @override
  State<ResetPassowrd> createState() => _ResetPassowrdState();
}

class _ResetPassowrdState extends State<ResetPassowrd> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ResetPasswordCubit>(context).cantsent();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mycolors.first_color,
        title: const Text(
          'نسيت كلمة السر',
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
              Text(
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
              BlocConsumer<ResetPasswordCubit, ResetPassowrdState>(
                listener: (context, state) {
                    if (state is ResetPasswordFailure) {
                    showTopSnackBar(Overlay.of(context),
                        MySnackBar.error(message: state.errormessage));
                  }else if(state is ResetPasswordSuccess){
                      myApplication.showToast(text: "تم الارسال", color: mycolors.secod_color);
                    }
                },
                builder: (context, state) {
                      return Column(
                        children: [
                          ResetPasswordCubit.cantsend
                              ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: SlideCountdown(
                              onDone: () {
                                BlocProvider.of<ResetPasswordCubit>(context).cansend();
                              },
                              textStyle: TextStyle(
                                  fontSize: myfonts.largfont,
                                  color: Colors.white),
                              duration: const Duration(seconds: 90),
                              decoration: BoxDecoration(
                                color: mycolors.first_color,
                              ),
                            ),
                          )
                              : const SizedBox(height: 110,),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: mycolors.popColor),
                              onPressed: ResetPasswordCubit.cantsend == false ?
                                  () {
                                    BlocProvider.of<ResetPasswordCubit>(context).cantsent();
                                BlocProvider.of<ResetPasswordCubit>(context)
                                    .Reset_password(email: widget.email);
                              }
                                  : null,
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
                        ],
                      );
                },
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
                  onPressed: () async => Navigator.pop(context),
                  child: Text(
                    'إلغاء',
                    style: TextStyle(
                        color: mycolors.popColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              TextButton(
                  onPressed: () {
                    myApplication.keyboardFocus(context);
                    myApplication.navigateToRemove(
                        context,
                         LoginScreen());
                  },
                  child: Text(
                    "تسجيل الدخول",
                    style: TextStyle(
                        color: mycolors.secod_color,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
