import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:elwarsha/Constents/colors.dart';
import 'package:elwarsha/Helper/MY_SnackBar.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:tflite/tflite.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

part 'image_labling_state.dart';

class ImageLablingCubit extends Cubit<ImageLablingState> {

  final ImagePicker picker = ImagePicker();
  static File? image;
  static bool isprocess = false;
  static String output = "";
  static String confidenc = "";
  ImageLablingCubit() : super(ImageLablingInitial());


  Future getImage(ImageSource media, context) async {

    XFile? selected = await picker.pickImage(source: media);
    if (selected != null) {
      image = File(selected.path);
      print("picked Image");
      await cropImage(imagefile: selected);
      emit(ImageLablingInitial());
    }
  }

  Future cropImage({required XFile imagefile})async {
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

  ProcessImage(BuildContext context) async {
    try {
      if (image != null) {
        var predictions = await Tflite.runModelOnImage(
            path: image!.path,
            imageMean: 127.5,
            imageStd: 127.5,
            numResults: 1,
            threshold: .9,
            asynch: true
        );
        confidenc = ((predictions!.first["confidence"] * 100).toInt()).toString() + "% ";
        output = predictions.first["label"];
        isprocess = true;
        emit(ImageLablingProcess());
      }
    } catch (e) {
      showTopSnackBar(
          Overlay.of(context),
          MySnackBar.error(
              message:
              "! الصورة غير واضحةّ , غير قادر على التحديد"));
    }
  }

  loadmodel() async {
    await Tflite.loadModel(
        model: "assets/TFlite/model.tflite", labels: "assets/TFlite/labels.txt");
  }

  reset(){
    ImageLablingCubit.image = null;
    isprocess = false;
    emit(ImageLablingInitial());
  }

}
