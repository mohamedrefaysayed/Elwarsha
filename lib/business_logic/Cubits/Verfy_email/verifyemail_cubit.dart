import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:elwarsha/Constents/colors.dart';
import 'package:elwarsha/Helper/MyApplication.dart';
import 'package:elwarsha/global/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'verifyemail_state.dart';

class VerifyemailCubit extends Cubit<VerifyemailState> {
  static bool isEmailverified = false;
  static bool canResendEmail = false;
  Timer? timer;


  VerifyemailCubit() : super(VerifyemailInitial());

  Future checkemailvervy() async {
    await currentFirebaseUser!.reload();
    isEmailverified = FirebaseAuth.instance.currentUser!.emailVerified;
    emit(VerifyemailInitial());
  }

  Future sendvervEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      myApplication.showToast(text: "تم الارسال", color: mycolors.secod_color);
    } on FirebaseAuthException catch (e) {
      if (e.code == "too-many-requests") {
        emit(VerifyemailFailure(errormessage: "أعد المحاولة بعد دقائق"));
      } else {
        print(e);
      }
    }
  }

  void cansend() {
    canResendEmail = true;
    emit(VerifyemailInitial());
  }

  void cantsent() {
    canResendEmail = false;
    emit(VerifyemailInitial());

  }
}
