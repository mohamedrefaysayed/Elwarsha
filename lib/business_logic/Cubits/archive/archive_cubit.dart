import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elwarsha/Presentation/Screens/store/item.dart';
import 'package:elwarsha/global/global.dart';
import 'package:meta/meta.dart';

part 'archive_state.dart';

class ArchiveCubit extends Cubit<ArchiveState> {
  ArchiveCubit() : super(ArchiveInitial());

  static List<Item> archived =[];


  Future<void>addArchivedItems() async {
    try{
      emit(ArchiveLoading());
      archived.forEach((element) async{
        await ffire.collection("customers").
        doc(userKey).collection("archive").
        doc(DateTime.now().toString()).set({
          "imagePath":element.ImgPath,
          "price":element.price,
          "fixePrice":element.fixePrice,
          "name":element.name,
          "discount":element.discount,
          "discountAmount":element.discountAmount,
          "details":element.details,
          "rating":0.5,
          "tradeMark":element.tradeMark,
          "type":element.type,
          "warshaName": element.warshaName,
          "warshaId":element.warshaId,
        });
      });
      emit(ArchiveInitial());
    } on FirebaseException {
      emit(ArchiveInitial());
      print("error");
    }
  }


  Future<void>removeArchivedItem(dockey) async {
    try{
      emit(ArchiveLoading());

      await ffire.collection("customers").doc(userKey).collection("archive").doc(dockey).delete();

      emit(ArchiveInitial());

    } on FirebaseException {
      print("error");
    }

  }

}
