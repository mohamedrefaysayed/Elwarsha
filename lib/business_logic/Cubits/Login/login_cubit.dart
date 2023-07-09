import 'package:bloc/bloc.dart';
import 'package:elwarsha/Helper/cahch_helper.dart';
import 'package:elwarsha/Presentation/Screens/Info/Elwarsha_Info.dart';
import 'package:elwarsha/business_logic/Cubits/elwarsha_Info/elwarsha_info_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/getInfo/get_info_cubit.dart';
import 'package:elwarsha/global/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());


  Future<void>LoginUser({required email ,required password,context}) async {
        try {
          emit(LoginLoading());
          await  FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

            await CahchHelper.saveData(key: "userKey", value: await fauth.currentUser!.uid);
            await CahchHelper.saveData(key: "signedIn", value: true);
            await CahchHelper.saveData(key: "signMethod",value: "normal");

            userKey = await fauth.currentUser!.uid;

          emit(LoginSuccess());

        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            emit(LoginFailure(errormessage: 'لايوجد مستخدم لهذا الايميل'));
          } else if (e.code == 'wrong-password') {
            emit(LoginFailure(errormessage: 'الرقم السرى غير صحيح'));
          }
        }catch(e){
          emit(LoginFailure(errormessage: e.toString()));
          print(e.toString());
        }
  }

  Future<void>LoginGoogelUser(context) async {
    try {
      emit(LoginLoading());
      GoogleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await GoogleUser!.authentication;
      if(googleAuth!.accessToken != null && googleAuth.idToken != null){
        final Credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final isSignedUp = await fauth.fetchSignInMethodsForEmail(GoogleUser!.email);

        if(isSignedUp.isNotEmpty){
          UserCredential userCredential = await fauth.signInWithCredential(Credential);
          if (userCredential.user != null) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString("userKey", GoogleUser!.id);
            await CahchHelper.saveData(key: "signedIn", value: true);
            await CahchHelper.saveData(key: "signMethod",value: "");

            userKey = await GoogleUser!.id;
            await BlocProvider.of<GetInfoCubit>(context).getInfo();
            await CahchHelper.saveData(key: "role", value: GetInfoCubit.Info!["role"]);

            Role = GetInfoCubit.Info!["role"];

            emit(LoginSuccess());
          }
        }else{
          await GoogleSignIn().signOut();
          emit(LoginFailure(errormessage: "هذا الايميل غير مسجل من قبل"));
        }


      }
    }on FirebaseException catch(e){
      emit(LoginFailure(errormessage: "حدث خطأ"));
    }
  }
  Future<void>LoginFacebookUser(context) async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
      FacebookUser = await FacebookAuth.instance.getUserData();

      final isSignedUp = await fauth.fetchSignInMethodsForEmail(FacebookUser!["email"]);

      if(isSignedUp.isNotEmpty){
        await fauth.signInWithCredential(facebookAuthCredential);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("userKey", FacebookUser!["id"]);
        await CahchHelper.saveData(key: "signedIn", value: true);
        await CahchHelper.saveData(key: "signMethod",value: "");

        userKey = await FacebookUser!["id"];
        await BlocProvider.of<GetInfoCubit>(context).getInfo();
        await CahchHelper.saveData(key: "role", value: GetInfoCubit.Info!["role"]);

        Role = GetInfoCubit.Info!["role"];

        emit(LoginSuccess());

      }else{
        await FacebookAuth.instance.logOut();
        emit(LoginFailure(errormessage: "هذا الايميل غير مسجل من قبل"));
      }

    }catch(e){
      emit(LoginFailure(errormessage: "حدث خطأ"));
    }
  }

}
