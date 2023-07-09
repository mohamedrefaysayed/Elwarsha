import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elwarsha/Presentation/Screens/store/item.dart';
import 'package:elwarsha/global/global.dart';
import 'package:meta/meta.dart';

part 'fav_state.dart';

class FavCubit extends Cubit<FavState> {
  FavCubit() : super(FavInitial());


  Future<void>setFavItem(Item item) async {
    try{
      emit(FavLoading());
      String dockey = DateTime.now().toString();
      await ffire.collection("customers").
      doc(userKey).collection("fav").
      doc(dockey).set({
        "imagePath":item.ImgPath,
        "price":item.price,
        "fixePrice":item.fixePrice,
        "name":item.name,
        "discount":item.discount,
        "discountAmount":item.discountAmount,
        "details":item.details,
        "rating":0.5,
        "tradeMark":item.tradeMark,
        "type":item.type,
        "warshaName": item.warshaName,
        "warshaId":item.warshaId,
      });
      emit(FavInitial());
    } on FirebaseException {
      emit(FavInitial());
      print("error");
    }
  }


  Future<void>removeFavItem(dockey) async {
    try{
      emit(FavLoading());

      await ffire.collection("customers").doc(userKey).collection("fav").doc(dockey).delete();

      emit(FavInitial());

    } on FirebaseException {
      print("error");
    }

  }



}
