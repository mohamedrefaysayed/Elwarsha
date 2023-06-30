import 'package:elwarsha/Constents/fontsize.dart';
import 'package:elwarsha/Helper/MY_SnackBar.dart';
import 'package:elwarsha/Presentation/Screens/Info/Car_Info.dart';
import 'package:elwarsha/Presentation/Screens/Info/Elwarsha_Info.dart';
import 'package:elwarsha/Presentation/Screens/Info/Sane3y_Data.dart';
import 'package:elwarsha/Presentation/Screens/auth/Login_Screen.dart';
import 'package:elwarsha/Presentation/Screens/auth/verfyEmailPage.dart';
import 'package:elwarsha/business_logic/Cubits/Passwors_Obscure/pass_op_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/Register/register_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../../global/global.dart';
import 'package:email_otp/email_otp.dart';
import 'package:email_validator/email_validator.dart';
import '../../../../Constents/colors.dart';
import '../../../../Helper/MyApplication.dart';
import 'package:flutter/material.dart';
import '../../../business_logic/Cubits/role/role_cubit.dart';


// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  bool emailconfirm = false;

  final formkey = GlobalKey<FormState>();

  final otp1Controller = TextEditingController();

  final otp2Controller = TextEditingController();

  final otp3Controller = TextEditingController();

  final otp4Controller = TextEditingController();

  // ignore: non_constant_identifier_names
  final name = TextEditingController();

  final email = TextEditingController();

  final password = TextEditingController();

  EmailOTP myauth = EmailOTP();

  bool customreg = false;

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: mycolors.first_color,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: mycolors.first_color,
          title: Text(
            'إنشاء حساب',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: myfonts.largfont,
            ),
          ),
          centerTitle: true,
        ),
        body: WillPopScope(
          onWillPop: () => myApplication.onWillPop(context),
          child: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterLoading) {
                load = true;
              } else if (state is RegisterSuccess) {
                showTopSnackBar(Overlay.of(context), MySnackBar.success(message: "تم إنشاء الحساب بنجاح",));
                if(customreg){
                  if(RoleCubit.role == "سائق سيارة"){
                    myApplication.navigateToRemove(context, CarInfo(isregerster: true,));
                  }else if(RoleCubit.role == "صاحب ورشة"){
                      myApplication.navigateToRemove(context, elwarshaInfo(isregerster: true,));
                    }else{
                    myApplication.navigateToRemove(context, Sane3yData());
                  }

                }else{
                  myApplication.navigateToRemove(context, verfyEmailPage(name: name.text, email: email.text,));
                }

              } else if (state is RegisterFailuer) {
                showTopSnackBar(Overlay.of(context),
                    CustomSnackBar.error(message: state.errormessage));
                load = false;
              } else {}
            },
            builder: (context, state) {
              if (state is RegisterLoading) {
                return Center(
                  child: myApplication.myloading(context),
                );
              } else {
                return Form(
                  key: formkey,
                  child: Container(
                    color: mycolors.first_color,
                    child: ListView(
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              SizedBox(
                                  height: myApplication.hightClc(95, context),
                                  child: Image.asset(
                                    "assets/images/الورشة.png",
                                    color: mycolors.popColor,
                                  )),
                              SizedBox(
                                  height: myApplication.hightClc(90, context),
                                  child: Image.asset(
                                    "assets/images/الورشة.png",
                                    color: mycolors.secod_color,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          margin:const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'الاسم',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: myfonts.mediumfont,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height:
                                myApplication.hightClc(10, context),
                              ),
                              TextFormField(
                                controller: name,
                                textAlign: TextAlign.end,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'أدخل أسمك';
                                  } else if (RegExp(r'\d')
                                      .hasMatch(value)) {
                                    return '! أدخل أسم صالح';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  contentPadding:
                                  const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder:
                                  const OutlineInputBorder(),
                                  hintText: 'أدخل أسمك',
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // const Text(
                              //   'الاسم الثانى',
                              //   textAlign: TextAlign.end,
                              //   style: TextStyle(
                              //       fontSize: 20, fontWeight: FontWeight.bold),
                              // ),
                              // const SizedBox(
                              //   height: 5,
                              // ),
                              // TextFormField(
                              //   controller: Second_name,
                              //   textAlign: TextAlign.end,
                              //   validator: (value) {
                              //     if (value!.isEmpty) {
                              //       return 'أدخل أسم العائلة';
                              //     } else if (RegExp(r'\d').hasMatch(value)) {
                              //       return '! أدخل أسم صالح';
                              //     } else {
                              //       return null;
                              //     }
                              //   },
                              //   decoration: InputDecoration(
                              //     contentPadding: const EdgeInsets.symmetric(
                              //         vertical: 5, horizontal: 10),
                              //     filled: true,
                              //     fillColor: Colors.white,
                              //     border: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(10.0),
                              //     ),
                              //     focusedBorder: const OutlineInputBorder(),
                              //     hintText: 'أدخل أسمك الثانى / اسم العائلة',
                              //   ),
                              // ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'الايميل',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: email,
                                textAlign: TextAlign.end,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'أدخل الإيميل';
                                  } else if (!EmailValidator.validate(
                                      value)) {
                                    return '! أدخل أيميل صالح';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  contentPadding:
                                  const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder:
                                  const OutlineInputBorder(),
                                  hintText: 'أدخل الايميل الخاص بك',
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                'الرقم السرى',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              BlocConsumer<PassOpCubit, PassOpState>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  return Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                    children: [
                                      TextFormField(
                                        controller: password,
                                        textAlign: TextAlign.end,
                                        obscureText:
                                        PassOpCubit.passwordVisible,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'أدخل الرقم السرى';
                                          } else if (value.length < 6) {
                                            return '!الرقم السرى قصير جدا';
                                          } else {
                                            return null;
                                          }
                                        },
                                        onChanged: (value) {
                                          BlocProvider.of<PassOpCubit>(
                                              context)
                                              .scure();
                                        },
                                        keyboardType:
                                        TextInputType.visiblePassword,
                                        decoration: InputDecoration(
                                          contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 5,
                                              horizontal: 10),
                                          prefixIcon: IconButton(
                                            color: mycolors.secod_color,
                                            icon: Icon(PassOpCubit
                                                .passwordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                            onPressed: () {
                                              BlocProvider.of<
                                                  PassOpCubit>(
                                                  context)
                                                  .changstate();
                                            },
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                10.0),
                                          ),
                                          focusedBorder:
                                          const OutlineInputBorder(),
                                          hintText:
                                          'أدخل الرقم السرى الخاص بك',
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        'تأكيد الرقم السرى',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        textAlign: TextAlign.end,
                                        obscureText:
                                        PassOpCubit.passwordVisible,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'أدخل الرقم السرى';
                                          } else if (value !=
                                              password.text) {
                                            return '!الرقم السرى غير مطابق';
                                          } else {
                                            return null;
                                          }
                                        },
                                        onChanged: (value) {
                                          BlocProvider.of<PassOpCubit>(
                                              context)
                                              .scure();
                                        },
                                        keyboardType:
                                        TextInputType.visiblePassword,
                                        decoration: InputDecoration(
                                          contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 5,
                                              horizontal: 10),
                                          prefixIcon: IconButton(
                                            color: mycolors.secod_color,
                                            icon: Icon(PassOpCubit
                                                .passwordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                            onPressed: () {
                                              BlocProvider.of<
                                                  PassOpCubit>(
                                                  context)
                                                  .changstate();
                                            },
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                10.0),
                                          ),
                                          focusedBorder:
                                          const OutlineInputBorder(),
                                          hintText:
                                          'أدخل تأكيد الرقم السرى',
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),

                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white),
                            onPressed: () async {
                              myApplication.keyboardFocus(context);
                              if (formkey.currentState!.validate()) {
                                myApplication.roleDialog(context, (){
                                  if(RoleCubit.role != null){
                                    BlocProvider.of<RegisterCubit>(context)
                                        .SignupUser(
                                        password: password.text.trim(),
                                        name: name.text.trim(),
                                        email: email.text.trim());
                                  }else{
                                    showTopSnackBar(Overlay.of(context), const MySnackBar.error(message: "يجب اختيار الدور")
                                    );
                                  }
                                });
                              }
                            },
                            child: const Text(
                              'تسجيل',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: myApplication.hightClc(20, context),
                        ),
                        Center(
                            child: Text(
                              "أو",
                              style: TextStyle(
                                  fontSize: myfonts.smallfont,
                                  fontWeight: FontWeight.bold),
                            )),
                        Center(
                            child: Text(
                              "يمكنك التسجيل ب",
                              style: TextStyle(
                                  fontSize: myfonts.smallfont,
                                  fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          height: myApplication.hightClc(20, context),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              child: Image.asset(
                                "assets/images/Icons/facebook.png",
                                height: myApplication.hightClc(40, context),
                              ),
                              onTap: () async {
                                myApplication.roleDialog(context, (){
                                  if(RoleCubit.role != null){
                                    customreg =true;
                                    BlocProvider.of<RegisterCubit>(context)
                                        .SignupFacebookUser(context);
                                  }else{
                                    showTopSnackBar(Overlay.of(context), const MySnackBar.error(message: "يجب اختيار الدور")
                                    );
                                  }
                                });

                              },
                            ),
                            SizedBox(
                              width: myApplication.widthClc(50, context),
                            ),
                            InkWell(
                              child: Image.asset(
                                "assets/images/Icons/google.png",
                                height: myApplication.hightClc(40, context),
                              ),
                              onTap: () async {
                                myApplication.roleDialog(context, (){
                                  if(RoleCubit.role != null){
                                    customreg =true;
                                    BlocProvider.of<RegisterCubit>(context)
                                        .SignupGoogelUser(context);
                                  }else{
                                    showTopSnackBar(Overlay.of(context), const MySnackBar.error(message: "يجب اختيار الدور")
                                    );
                                  }
                                });

                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () {
                                  FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  myApplication.navigateToRemove(
                                      context, LoginScreen());
                                },
                                child: Text(
                                  "تسجيل الدخول",
                                  style: TextStyle(
                                      color: mycolors.secod_color,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                            const Text(
                              'تمتلك حساب ؟',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
