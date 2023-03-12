import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
part 'edit_state.dart';

class EditCubit extends Cubit<EditState> {
  static XFile? image;
  static bool caneditName = true;
  static bool caneditEmail = true;


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


  Future getImage(ImageSource media, context) async {
    var pic = await picker.pickImage(source: media);
    image = pic;
    emit(EditInitial());
  }
  // Future<String> uploadImage(File file) async {
  //   final fileName = (file.path);
  //   // final reference = FirebaseStorage.ref().child('images/$fileName');
  //   final uploadTask = reference.putFile(file);
  //   final snapshot = await uploadTask.whenComplete(() => null);
  //   final downloadUrl = await snapshot.ref.getDownloadURL();
  //   return downloadUrl;
  // }




}
