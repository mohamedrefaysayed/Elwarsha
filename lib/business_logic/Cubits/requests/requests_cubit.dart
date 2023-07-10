import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:elwarsha/business_logic/Cubits/elwarsha_Info/elwarsha_info_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/getInfo/get_info_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/sany3y/sany3y_cubit.dart';
import 'package:elwarsha/global/global.dart';
import 'package:meta/meta.dart';

part 'requests_state.dart';

class RequestsCubit extends Cubit<RequestsState> {
  RequestsCubit() : super(RequestsInitial());


  Future<void>addRequest(warshaId)async {
    try{
      emit(RequestsLoading());
      await ffire.collection("Elwrash").doc(warshaId).collection("requests").doc(userKey).set({
        "sany3yName": GetInfoCubit.Info!["name"],
        "sany3yId": userKey,
        "Specialization": GetInfoCubit.Info!["Specialization"],
        "rating": 1.5,
      });

      emit(RequestsInitial());
    }catch(e){
      emit(RequestsInitial());

    }

  }

  Future<void>aceptRequest(String sany3yId,String sany3yName,String Specialization,double rating) async {
    try{
      emit(RequestsLoading());

      await ffire.collection("Elwrash").doc(userKey).collection("sanay3ya").doc(sany3yId).set({
        "sany3yName":sany3yName,
        "Specialization":Specialization,
        "sany3yId":sany3yId,
        "rating":rating,
        "fixCount":Random().nextInt(20),
      });
      await ffire.collection("Elwrash").doc(userKey).collection("requests").doc(sany3yId).delete();
      await ffire.collection("customers").doc(sany3yId).update({
        "inWarsha":true,
        "warshaName":ElwarshaInfoCubit.Info!["warshaName"],
        "warshaId":userKey,
      });

      emit(RequestsInitial());
    }catch(e){
      emit(RequestsInitial());

    }
  }
}
