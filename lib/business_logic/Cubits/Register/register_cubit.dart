import 'package:bloc/bloc.dart';
import 'package:elwarsha/Helper/chach_helper.dart';
import 'package:elwarsha/business_logic/Cubits/role/role_cubit.dart';
import 'package:elwarsha/global/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  String? Alignment = "orginal";
  RegisterCubit() : super(RegisterInitial());

  Future<void>SignupUser({required password,required name, required email}) async {
    try {
      emit(RegisterLoading());
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
      ).then((value) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("userKey", value.user!.uid);
        await prefs.setString("signMethod", "normal");
        await prefs.setString("role",RoleCubit.role!);
        await CahchHelper.saveData(key: "signedIn", value: true);


        userKey = await prefs.getString("userKey");
        ffire.collection("customers").doc(userKey).set({
          "name": name,
          "email": email,
          "url":null,
          "pass":password,
          "role":RoleCubit.role,
          "alignment": Alignment,
        });
      });

      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'weak-password') {
        emit(RegisterFailuer(errormessage: 'الباسورد ضعيف'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailuer(errormessage: 'هذا الحساب موجود بالفعل'));
      }
    }catch(e){
      emit(RegisterFailuer(errormessage: e.toString()));

    }
  }
  Future<void>SignupGoogelUser(context) async {
    try {
      emit(RegisterLoading());
      GoogleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await GoogleUser!.authentication;
      if(googleAuth!.accessToken != null && googleAuth.idToken != null){
        final Credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final isSignedUp = await fauth.fetchSignInMethodsForEmail(GoogleUser!.email);

        if(isSignedUp.isEmpty){
          UserCredential userCredential = await fauth.signInWithCredential(Credential);
          if (userCredential.user != null) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString("userKey", GoogleUser!.id);
            await prefs.setString("signMethod", "google");
            await prefs.setString("role", RoleCubit.role!);
            await CahchHelper.saveData(key: "signedIn", value: true);


            userKey = await prefs.getString("userKey");

              ffire.collection("customers").doc(userKey).set({
                "name": GoogleUser!.displayName,
                "email": GoogleUser!.email,
                "url":GoogleUser!.photoUrl,
                "pass":userKey,
                "role":RoleCubit.role,
                "alignment": Alignment,
              });



            emit(RegisterSuccess());
          }
        }else{
          await GoogleSignIn().signOut();
          emit(RegisterFailuer(errormessage: "هذا الايميل مسجل من قبل"));
        }

      }
    }on FirebaseException catch(e){
      emit(RegisterFailuer(errormessage: e.code));
    }
  }
  Future<void>SignupFacebookUser(context) async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

      FacebookUser = await FacebookAuth.instance.getUserData();

      final isSignedUp = await fauth.fetchSignInMethodsForEmail(FacebookUser!["email"]);

      if(isSignedUp.isEmpty){
        await fauth.signInWithCredential(facebookAuthCredential);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("userKey", FacebookUser!["id"]);
        await prefs.setString("signMethod", "facebook");
        await prefs.setString("role", RoleCubit.role!);
        await CahchHelper.saveData(key: "signedIn", value: true);


        userKey = await prefs.getString("userKey");


        await ffire.collection("customers").doc(userKey).set({
          "name": FacebookUser!["name"],
          "email": FacebookUser!["email"],
          "url":FacebookUser!["picture"]["data"]["url"],
          "pass":userKey,
          "role":RoleCubit.role,
          "alignment": Alignment,
        });

        emit(RegisterSuccess());

      }else{
        await FacebookAuth.instance.logOut();
        emit(RegisterFailuer(errormessage: "هذا الايميل مسجل من قبل"));
      }
    }catch(e){
      emit(RegisterFailuer(errormessage: "حدث خطأ"));
    }
  }

}
