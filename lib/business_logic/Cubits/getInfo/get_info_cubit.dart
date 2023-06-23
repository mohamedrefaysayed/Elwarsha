import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elwarsha/business_logic/Cubits/edit/edit_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/elwarsha_Info/elwarsha_info_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
    } on FirebaseException catch(e){
      emit(GetInfoFailuer());
    }

  }
   Loading(){
    emit(GetInfoLoading());
  }

}
