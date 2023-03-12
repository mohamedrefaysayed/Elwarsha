import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'repair_request_state.dart';

class RepairRequestCubit extends Cubit<RepairRequestState> {
  static String? repair;
  static bool? Car;
  RepairRequestCubit() : super(RepairRequestInitial());

  void set_Repair(String value){
    repair = value;
    emit(RepairRequestInitial());
  }
  void set_Car(bool value){
    Car = value;
    emit(RepairRequestInitial());
  }

}
