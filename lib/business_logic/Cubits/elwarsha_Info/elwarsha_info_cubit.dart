import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elwarsha/business_logic/Cubits/map_Picker/map_picker_cubit.dart';
import 'package:elwarsha/global/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'elwarsha_info_state.dart';

class ElwarshaInfoCubit extends Cubit<ElwarshaInfoState> {

  static Map<String, dynamic>? Info ;

  static String? warshaName ;

  // ignore: non_constant_identifier_names
  static String? warshOwnerName ;

  // ignore: non_constant_identifier_names
  static String? warshlicense  ;

  // ignore: non_constant_identifier_names
  static String? warshDesc  ;

  static GeoPoint? warshaLocation ;


  ElwarshaInfoCubit() : super(ElwarshaInfoInitial());

  Future<void>getInfo(context,key) async {
    try{
      emit(ElwarshaInfoLoading());
      await ffire.collection('Elwrash').doc(key).get().then((DocumentSnapshot  value){
        print('warsha data: ${value.data()}');
        Info = value.data() as Map<String, dynamic>;
      }).then((value) {

        warshaName = Info!["warshaName"] ?? "" ;
        warshOwnerName = Info!["warshaOwnerName"] ?? "" ;
        warshlicense = Info!["warshalicense"] ?? "";
        warshDesc = Info!["warshaDesc"] ;
        warshaLocation = Info!["warshalocation"] ?? "";

        BlocProvider.of<MapPickerCubit>(context).addMarker(LatLng(
            ElwarshaInfoCubit.warshaLocation!.latitude,
            ElwarshaInfoCubit.warshaLocation!.longitude));

        emit(ElwarshaInfoSuccess());
      });


    } on FirebaseException {
      emit(ElwarshaInfoFailuer());
    }

  }


  Future<void>setInfo() async {
    try{
      await ffire.collection('Elwrash').doc(userKey).set({

        "warshaName": warshaName,
        "warshaOwnerName": warshOwnerName,
        "warshalicense": warshlicense,
        "warshaDesc": warshDesc,
        "warshalocation": GeoPoint(warshaLocation!.latitude,warshaLocation!.longitude),
        "warshaState":false,
        "warshaKey":userKey,


      });
    } on FirebaseException {
    }

  }

  setState()async{
    await ffire.collection('Elwrash').doc(userKey).update({

      "warshaState":elwarshaState,

    });
  }

}
