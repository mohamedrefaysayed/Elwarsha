import 'package:bloc/bloc.dart';
import 'package:elwarsha/global/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void>SignupUser({required email ,required password,required First_name,required Second_name, required Email}) async {
    try {
      emit(RegisterLoading());
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
      ).then((value) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("userKey", value.user!.uid);
        ffire.collection("customers").doc(userKey as String?).set({
          "fristname": First_name.text,
          "secondname": Second_name.text,
          "email": Email.text,
          "url":"image",
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

}
