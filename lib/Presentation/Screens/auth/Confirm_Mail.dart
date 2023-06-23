import 'package:elwarsha/business_logic/Cubits/Confirm_mail/confirm_mail_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../../Constents/colors.dart';
import '../../../../Constents/fontsize.dart';
import '../../../../Helper/MyApplication.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import '../../../../global/global.dart';
import '../../../Helper/MY_SnackBar.dart';
import 'Reset_Password.dart';

class ConfirmMail extends StatelessWidget {
  ConfirmMail({
    Key? key,
  }) : super(key: key);

  final formkey = GlobalKey<FormState>();
  final email = TextEditingController();

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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: mycolors.first_color,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_sharp,
              color: mycolors.secod_color,
              size: 30,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'تأكيد الايميل',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<ConfirmMailCubit, ConfirmMailState>(
          listener: (context, state) {
             if(state is ConfirmMailSuccess){
              myApplication.push_up(context,ResetPassowrd(email: email.text, title: 'نسيت كلمة السر', type: 'password',));
            }else if(state is ConfirmMailFailure ){
              load = false;
              showTopSnackBar(Overlay.of(context),
                  MySnackBar.error(message: state.errormessage));            }
          },
          builder: (context, state) {
            if(state is ConfirmMailLoading){
              return Center(
                child: myApplication.myloading(context),
              );
            }else{
              return Form(
                key: formkey,
                child: Container(
                  color: mycolors.first_color,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 150,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'الإيميل',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
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
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: const OutlineInputBorder(),
                                hintText: 'أدخل الايميل الخاص بك',
                              ),
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white),
                              onPressed: ()  {
                                if(formkey.currentState!.validate()) {
                                  myApplication.keyboardFocus(context);
                                  BlocProvider.of<ConfirmMailCubit>(context).Reset_password(email: email.text);
                                }
                              },
                              child: Text(
                                "أرسال رمز التحقق",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: myfonts.largfont),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              );

            }
          },
        ),
      ),
    );
  }
}
