import 'package:bloc/bloc.dart';
import 'package:elwarsha/global/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());


  Future<void>LoginUser({required email ,required password}) async {
        try {
          emit(LoginLoading());
          await  FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
          emit(LoginSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            emit(LoginFailure(errormessage: 'لايوجد مستخدم لهذا الايميل'));
          } else if (e.code == 'wrong-password') {
            emit(LoginFailure(errormessage: 'الرقم السرى غير صحيح'));
          }
        }catch(e){
          emit(LoginFailure(errormessage: 'حدث خطأ'));

        }
  }
  Future<void>LoginGoogelUser() async {

    try {
      emit(LoginLoading());
      await GoogleSignIn().signIn().then((value) async {
        GoogleUser = value;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("userKey", GoogleUser!.id);
        ffire.collection("customers").doc(userKey as String?).set({
          "fristname": GoogleUser!.displayName,
          "secondname": "",
          "email": GoogleUser!.email,
          "url":GoogleUser!.photoUrl,
        });
      });
      emit(LoginSuccess());
    }catch(e){
      emit(LoginFailure(errormessage: "حدث خطأ"));
    }
  }
  Future<void>LoginFacebookUser() async {
    try {
      await FacebookAuth.instance.login();
        FacebookUser = await FacebookAuth.instance.getUserData();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("userKey", FacebookUser!["id"]);

      ffire.collection("customers").doc(userKey as String?).set({
        "fristname": FacebookUser!["name"],
        "secondname": "",
        "email": FacebookUser!["email"],
        "url":FacebookUser!["picture"]["data"]["url"],
      });
      emit(LoginSuccess());
    }catch(e){
      emit(LoginFailure(errormessage: "حدث خطأ"));
    }
  }


}
