import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../global/global.dart';
part 'get_info_state.dart';

class GetInfoCubit extends Cubit<GetInfoState> {
  static Map<String, dynamic>? Info ;


  GetInfoCubit() : super(GetInfoLoading());

   Future<void>getInfo() async {
    try{
      emit(GetInfoLoading());
      await ffire.collection('customers').doc(userKey).get().then((DocumentSnapshot  value){
        print('Customer data: ${value.data()}');
        Info = value.data() as Map<String, dynamic>;
      });

      emit(GetInfoSucsses());
    } on FirebaseException catch(_){
      emit(GetInfoFailuer());
    }

  }
   Loading(){
    emit(GetInfoLoading());
  }

}
