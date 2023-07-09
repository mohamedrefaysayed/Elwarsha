import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:elwarsha/Constents/colors.dart';
import 'package:elwarsha/Presentation/Screens/profile/Profile%20personly.dart';
import 'package:elwarsha/global/global.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'edit_state.dart';

class EditCubit extends Cubit<EditState> {
  static File? image;
  static bool caneditName = true;
  static bool caneditEmail = true;
  static bool isUploading = false;

  String? url;

  EditCubit() : super(EditInitial());

  void changNamestate(){
    caneditName = !caneditName;
    emit(EditInitial());
  }
  void changEmailstate(){
    caneditEmail = !caneditEmail;
    emit(EditInitial());
  }

  final ImagePicker picker = ImagePicker();


  Future getImage(ImageSource media,) async {
    XFile? selected = await picker.pickImage(source: media);
    if (selected != null) {
      image = File(selected.path);
      print("picked Image");
      await cropImage(imagefile: selected);
      emit(EditInitial());
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
  Future uploadImage(context) async {
    isUploading = true;
    emit(EditInitial());
    var _firebaseStorage = await FirebaseStorage.instance.ref().child('Customers').child("ProfilePic").child("$userKey");
     await _firebaseStorage.putFile(image!);
     url = await _firebaseStorage.getDownloadURL();

    print("uploaded Image");
    stordimagePath = image!.path;
    final Prefs = await SharedPreferences.getInstance();
    await Prefs.setString("image", "${image!.path}");
    isUploading = false;
    image = null;
    emit(EditInitial());

  }
  Future SetImage() async {
    await ffire.collection("customers").doc(userKey).update({
      "url": url,
    });
    emit(EditInitial());
  }

  // setAlign(details){
  //   picAlignment += Alignment(details.delta.dx / 200, details.delta.dy / 200);
  //   emit(EditInitial());
  // }
  // void saveAlignmentToFirebase(Alignment alignment) {
  //   String alignmentString = alignmentToString(alignment);
  //   FirebaseFirestore.instance.collection('customers').doc(userKey).update({
  //     'alignment': alignmentString,
  //   });
  // }
  //
  // Future getAlignmentFromFirebase() async {
  //   if(GetInfoCubit.Info!["alignment"]!="orginal") {
  //     String? alignmentString = GetInfoCubit.Info!["alignment"];
  //     List<String> parts = alignmentString!.split(',');
  //     double x = double.parse(parts[0]);
  //     double y = double.parse(parts[1]);
  //     EditCubit.picAlignment = Alignment(x, y);
  //   }
  // }



}
