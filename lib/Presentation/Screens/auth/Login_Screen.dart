// ignore_for_file: must_be_immutable

import 'package:elwarsha/Constents/fontsize.dart';
import 'package:elwarsha/Helper/MY_SnackBar.dart';
import 'package:elwarsha/Helper/cahch_helper.dart';
import 'package:elwarsha/Presentation/Screens/Main_Screen/MainScreen.dart';
import 'package:elwarsha/business_logic/Cubits/Login/login_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/Passwors_Obscure/pass_op_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/getInfo/get_info_cubit.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../../Constents/colors.dart';
import '../../../../Helper/MyApplication.dart';
import '../../../../global/global.dart';
import 'Confirm_Mail.dart';
import 'Regester_Screen.dart';

class LoginScreen extends StatelessWidget {

  bool emailtrans = false;

  final formkey = GlobalKey<FormState>();

  final email = TextEditingController();

  final password = TextEditingController();

  LoginScreen({super.key});

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
        resizeToAvoidBottomInset: false,

        backgroundColor: mycolors.first_color,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: mycolors.first_color,
          title:  Text(
            'تسجيل الدخول',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: myfonts.largfont,
            ),
          ),
          centerTitle: true,
        ),
        body: WillPopScope(
          onWillPop: () => myApplication.onWillPop(context),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
               if (state is LoginSuccess) {
                showTopSnackBar(Overlay.of(context),
                    MySnackBar.success(message: "تم تسجيل الدخول بنجاح"));
                myApplication.navigateToRemove(context, MainScreen());

                String signmethod = CahchHelper.getData(key: "signMethod");

                if(signmethod == "normal"){

                  BlocProvider.of<GetInfoCubit>(context).getInfo();
                  print(GetInfoCubit.Info);
                  CahchHelper.saveData(key: "role", value: GetInfoCubit.Info!["role"]);
                }

                Role = GetInfoCubit.Info!["role"];
              } else if (state is LoginFailure) {
                showTopSnackBar(Overlay.of(context),
                    MySnackBar.error(message: state.errormessage));
                load = false;
              }
            },
            builder: (context, state) {
              if(state is LoginLoading){
                return Center(
                  child: myApplication.myloading(context),
                );
              }
              else{
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
                                  height: myApplication.hightClc(100, context),
                                  child: Image.asset("assets/images/الورشة.png",color: mycolors.popColor,)),
                              SizedBox(
                                  height: myApplication.hightClc(95, context),
                                  child: Image.asset("assets/images/الورشة.png",color: mycolors.secod_color,)),
                            ],
                          ),
                        ),
                        Container(
                          margin:  EdgeInsets.symmetric(horizontal: myApplication.widthClc(24, context)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'الإيميل',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: myfonts.mediumfont, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: myApplication.hightClc(10, context),
                              ),
                              SizedBox(
                                height: myApplication.hightClc(84, context),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: email,
                                  textAlign: TextAlign.end,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'أدخل الإيميل';
                                    } else if (!EmailValidator.validate(value)) {
                                      return '! أدخل أيميل صالح';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(),
                                    hintText: 'أدخل الايميل الخاص بك',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: myApplication.hightClc(20, context),
                              ),
                              Text(
                                'الرقم السرى',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: myfonts.mediumfont, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: myApplication.hightClc(10, context),
                              ),
                              SizedBox(
                                height: myApplication.hightClc(84, context),
                                child: BlocBuilder<PassOpCubit, PassOpState>(

                                  builder: (context, state) => TextFormField(
                                    controller: password,
                                    textAlign: TextAlign.end,
                                    obscureText: PassOpCubit.passwordVisible,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'أدخل الرقم السرى';
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: InputDecoration(
                                      prefixIcon: IconButton(
                                        color: mycolors.secod_color,
                                        icon: Icon(
                                            PassOpCubit.passwordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                        onPressed: () {
                                          BlocProvider.of<PassOpCubit>(context).changstate();
                                        },
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: const OutlineInputBorder(),
                                      hintText: 'أدخل الرقم السرى الخاص بك',
                                    ),
                                    onChanged: (value) {
                                      BlocProvider.of<PassOpCubit>(context).scure();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: myApplication.hightClc(10, context),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    myApplication.keyboardFocus(context);
                                    myApplication.push_up(context, ConfirmMail());
                                  },
                                  child: Text(
                                    "هل نسيت كلمة السر ؟",
                                    style: TextStyle(
                                        color: mycolors.secod_color,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: myApplication.hightClc(60, context),
                        ),
                        SizedBox(
                          height: myApplication.hightClc(20, context),
                        ),
                        SizedBox(
                          height: myApplication.hightClc(50, context),
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white),
                            onPressed: () async{
                              myApplication.keyboardFocus(context);
                              if (formkey.currentState!.validate()) {
                                await BlocProvider.of<LoginCubit>(context).LoginUser(
                                    email: email.text.trim(),
                                    password: password.text.trim());
                                // signInWithEmail();
                              }
                            },
                            child: const Text(
                              'دخول',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),

                        SizedBox(height: myApplication.hightClc(20, context),),
                        Center(child: Text("أو",style: TextStyle(fontSize: myfonts.smallfont,fontWeight: FontWeight.bold),)),
                        Center(child: Text("يمكنك الدخول ب",style: TextStyle(fontSize: myfonts.smallfont,fontWeight: FontWeight.bold),)),
                        SizedBox(height: myApplication.hightClc(20, context),),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              child: Image.asset("assets/images/Icons/facebook.png",
                                height: myApplication.hightClc(40, context),
                              ),
                              onTap: () async {
                                await BlocProvider.of<LoginCubit>(context).LoginFacebookUser(context);
                              },
                            ),
                            SizedBox(width: myApplication.widthClc(50, context),),
                            InkWell(
                              child: Image.asset("assets/images/Icons/google.png",
                                height: myApplication.hightClc(40, context),
                              ),
                              onTap: () async {
                                await BlocProvider.of<LoginCubit>(context).LoginGoogelUser(context);
                              },
                            ),


                          ],
                        ),

                        SizedBox(
                          height: myApplication.hightClc(20, context),
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
                                  myApplication.navigateToRemove(context,RegisterScreen());

                                },
                                child: Text(
                                  "إنشاء حساب",
                                  style: TextStyle(
                                      color: mycolors.secod_color,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                            const Text(
                              'لا تمتلك حساب ؟',
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
