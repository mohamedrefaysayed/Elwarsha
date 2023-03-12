import 'package:bloc/bloc.dart';
import 'package:elwarsha/Helper/MyApplication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../../global/global.dart';
part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPassowrdState> {
  static bool cantsend = false;
  ResetPasswordCubit() : super(ResetPasswordInitial());

  Future<void> Reset_password({required email}) async {
    cantsend = true;
    try {
      await fauth.sendPasswordResetEmail(email: email);
      myApplication.showToast(text: "تم الارسال", color: Colors.white);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        emit(ResetPasswordFailure(errormessage: "هذا الايميل غير موجود"));
      } else if (e.code == "too-many-requests") {
        emit(ResetPasswordFailure(errormessage: "أعد المحاولة بعد دقائق"));
      } else {
        emit(ResetPasswordFailure(errormessage: 'حدث خطأ'));
      }
    }
  }
  void cansend(){
    cantsend = false;
    emit(ResetPasswordInitial());
  }
  void cantsent(){
    cantsend = true;
    emit(ResetPasswordInitial());
  }


}
