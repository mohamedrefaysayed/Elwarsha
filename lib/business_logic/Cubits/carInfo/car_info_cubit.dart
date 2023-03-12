// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../global/global.dart';

part 'car_info_state.dart';

class CarInfoCubit extends Cubit<CarInfoState> {
  static Map<String, dynamic>? Info ;

  // ignore: non_constant_identifier_names
  static String? Car ;

  // ignore: non_constant_identifier_names
  static String? Model ;

  // ignore: non_constant_identifier_names
  static String? EnginCap ;

  // ignore: non_constant_identifier_names
  static String? EnginPow ;

  // ignore: non_constant_identifier_names
  static String? StructType ;

  static String? agency ;

  CarInfoCubit() : super(CarInfoLoading());
  Future<void>setInfo({required  Car,required Model,required EnginCap,required EnginPow,required StructType,required agency}) async {
    try{
      await ffire.collection('customers').doc(userKey).collection("car").doc("data").set({

        "car": Car,
        "model": Model,
        "enginCap": EnginCap,
        "enginPow": EnginPow,
        "structType": StructType,
        "agency" : agency,

      });
    } on FirebaseException {
    }

  }
  Future<void>updateInfo({required  Car,required Model,required EnginCap,required EnginPow,required StructType,required agency}) async {
    try{
      await ffire.collection('customers').doc(userKey).collection("car").doc("data").update({

        "car": Car,
        "model": Model,
        "enginCap": EnginCap,
        "enginPow": EnginPow,
        "structType": StructType,
        "agency" : agency,

      });
    } on FirebaseException {
    }
  }

  Future<void>getInfo() async {
    try{
      await ffire.collection('customers').doc(userKey).collection("car").doc("data").get().then((DocumentSnapshot  value){
        print('Car data: ${value.data()}');
        Info = value.data() as Map<String, dynamic>;
      }).then((value){
        emit(CarInfoSucsses());
        Car = Info!["car"];
         Model = Info!["model"];
         EnginCap = Info!["enginCap"];
         EnginPow = Info!["enginPow"];
         StructType = Info!["structType"];
         agency = Info!["agency"];
      });
    } on FirebaseException {
      emit(CarInfoFailuer());
    }

  }


  void settype(String value){
    Car = value;
    emit(CarInfoInitial());

  }
  void setmodle(String value){
    Model = value;
    emit(CarInfoInitial());

  }
  void setcap(String value){
    EnginCap = value;
    emit(CarInfoInitial());

  }
  void setpow(String value){
    EnginPow = value;
    emit(CarInfoInitial());

  }
  void setstruct(String value){
    StructType = value;
    emit(CarInfoInitial());

  }
  void setagency(String value){
    agency = value;
    emit(CarInfoInitial());

  }



}
