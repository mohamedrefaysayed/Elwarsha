import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../global/global.dart';

part 'confirm_mail_state.dart';

class ConfirmMailCubit extends Cubit<ConfirmMailState> {
  ConfirmMailCubit() : super(ConfirmMailInitial());

  Future<void> Reset_password({required email}) async {
    try {
      emit(ConfirmMailLoading());
      await fauth.sendPasswordResetEmail(email: email);
        emit(ConfirmMailSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        emit(ConfirmMailFailure(errormessage: "هذا الايميل غير موجود"));
      } else if (e.code == "too-many-requests") {
        emit(ConfirmMailFailure(errormessage: "أعد المحاولة بعد دقائق"));
      } else {
        emit(ConfirmMailFailure(errormessage: 'حدث خطأ'));
      }
    }
  }

}
