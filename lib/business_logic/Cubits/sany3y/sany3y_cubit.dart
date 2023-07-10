import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elwarsha/global/global.dart';
import 'package:meta/meta.dart';

part 'sany3y_state.dart';

class Sany3yCubit extends Cubit<Sany3yState> {
  Sany3yCubit() : super(Sany3yInitial());


  static String? Specialization ;
  static String? AnotherSpecialization ;

  static Map<String, dynamic>? Info ;


  Future<void>SaveSpecialization()async{
    await ffire.collection("customers").doc(userKey).update({
      "Specialization": Specialization == "أخرى" ? AnotherSpecialization : Specialization,
      "rating": Random().nextDouble() * 5,
      "inWarsha":false,
      "warshaName":"",
      "warshaId":"",
    });
  }

  Future<void>getInfo(sany3yId) async {
    try{
      emit(Sany3yLoading());
      await ffire.collection('customers').doc(sany3yId).get().then((DocumentSnapshot  value){
        print('Customer data: ${value.data()}');
        Info = value.data() as Map<String, dynamic>;
      });

      emit(Sany3yInitial());
    } on FirebaseException catch(_){
      emit(Sany3yInitial());
    }

  }


}
