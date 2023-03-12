import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../global/global.dart';

part 'get_info_state.dart';

class GetInfoCubit extends Cubit<GetInfoState> {
  static Map<String, dynamic>? Info ;
  GetInfoCubit() : super(GetInfoLoading());

   Future<void>getInfo() async {
    try{
      await ffire.collection('customers').doc(userKey).get().then((DocumentSnapshot  value){
        print('Customer data: ${value.data()}');
        Info = value.data() as Map<String, dynamic>;
      });
      emit(GetInfoSucsses());
    } on FirebaseException catch(e){
      emit(GetInfoFailuer());
    }

  }
  Future<void>updateInfo({required  First_name,required Second_name,required Email,required url}) async {
    try{
      ffire.collection("customers").doc(userKey as String?).set({
        "fristname": First_name,
        "secondname": Second_name,
        "email": Email,
        "url":url,
      });
    } on FirebaseException {
    }
  }
   Loading(){
    emit(GetInfoLoading());
  }

}
