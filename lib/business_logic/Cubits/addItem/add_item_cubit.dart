import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:elwarsha/Constents/colors.dart';
import 'package:elwarsha/business_logic/Cubits/elwarsha_Info/elwarsha_info_cubit.dart';
import 'package:elwarsha/global/global.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'add_item_state.dart';

class AddItemCubit extends Cubit<AddItemState> {
  final ImagePicker picker = ImagePicker();

  AddItemCubit() : super(AddItemInitial());
  static File? image;
  String? url;

  static int? price ;
  static int? fixePrice ;
  static String? name ;
  static bool discount = false ;
  static int? discountAmount;
  static String? details ;
  static String? tradeMark ;
  static String? type  = "original";




  Future getImage(ImageSource media) async {

    XFile? selected = await picker.pickImage(source: media);
    if (selected != null) {
      image = File(selected.path);
      print("picked Image");
      await cropImage(imagefile: selected);
      emit(AddItemInitial());
    }
  }

  Future cropImage({required XFile imagefile})async{
    CroppedFile? croppedImage = await ImageCropper().cropImage(sourcePath: imagefile.path,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Edit Photo',
              backgroundColor: mycolors.first_color,
              activeControlsWidgetColor: mycolors.popColor,
              cropFrameColor: mycolors.popColor,
              cropGridColor: mycolors.popColor,
              toolbarColor: mycolors.first_color,
              toolbarWidgetColor: mycolors.popColor,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false
          ),
        ]
    );
    if(croppedImage == null) return null;
    image =  File(croppedImage.path);

  }

  Future uploadImage() async {

    var _firebaseStorage = await FirebaseStorage.instance.ref().child('spareParts').child(userKey!).child(DateTime.now().toString());
    await _firebaseStorage.putFile(image!);
    url = await _firebaseStorage.getDownloadURL();
    print("uploaded Image");
    image = null;

  }

  Future<void>addItem()async{
    try{
      emit(AddItemloading());
      await uploadImage();
      await setItem();

      emit(AddItemSuccess());

    }catch(e){
      emit(AddItemFailuer());
    }
  }


  Future<void>setItem() async {
    try{
      String dockey = DateTime.now().toString();
      await ffire.collection('spareStore')
          .doc("all")
          .collection("data")
          .doc(dockey).set({
        "imagePath":url,
        "price":price,
        "fixePrice":fixePrice,
        "name":name,
        "discount":discount,
        "discountAmount":discountAmount,
        "details":details,
        "rating":0.5,
        "tradeMark":tradeMark,
        "type":type,
        "warshaName": ElwarshaInfoCubit.warshaName,
        "warshaId":userKey,
      });


      await ffire.collection('spareStore').doc(type).collection("data").doc(dockey).set({

      "imagePath":url,
      "price":price,
      "fixePrice":fixePrice,
      "name":name,
      "discount":discount,
      "discountAmount":discountAmount,
      "details":details,
      "rating":0.5,
      "tradeMark":tradeMark,
      "type":type,
      "warshaName": ElwarshaInfoCubit.warshaName,
      "warshaId":userKey,


      });

      discount
          ? await ffire.collection('spareStore').doc("sale").collection("data").doc(dockey).set({

        "imagePath":url,
        "price":price,
        "fixePrice":fixePrice,
        "name":name,
        "discount":discount,
        "discountAmount":discountAmount,
        "details":details,
        "rating":0.5,
        "tradeMark":tradeMark,
        "type":type,
        "warshaName": ElwarshaInfoCubit.warshaName,
        "warshaId":userKey,


      })
          : null;


      await ffire.collection('Elwrash').doc(userKey).collection("spareParts").doc(dockey).set({

    "imagePath":url,
    "price":price,
    "fixePrice":fixePrice,
    "name":name,
    "discount":discount,
    "discountAmount":discountAmount,
    "details":details,
    "rating":0.5,
    "tradeMark":tradeMark,
    "type":type,
    "warshaName": ElwarshaInfoCubit.warshaName,
    "warshaId":userKey,


    });

    } on FirebaseException {
      print("error");
    }

  }

  Future<void>removeItem(dockey,type,isdiscount) async {
    try{
      await ffire.collection('spareStore').doc("all").collection("data").doc(dockey).delete();

      await ffire.collection('spareStore').doc(type).collection("data").doc(dockey).delete();

      isdiscount
          ? await ffire.collection('spareStore').doc("sale").collection("data").doc(dockey).delete()
          : null;

      await ffire.collection('Elwrash').doc(userKey).collection("spareParts").doc(dockey).delete();

    } on FirebaseException {
      print("error");
    }

  }



}
