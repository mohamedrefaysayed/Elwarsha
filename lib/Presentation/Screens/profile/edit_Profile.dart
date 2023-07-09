// ignore_for_file: file_names
import 'dart:io';
import 'package:elwarsha/Constents/colors.dart';
import 'package:elwarsha/Constents/fontsize.dart';
import 'package:elwarsha/Helper/MyApplication.dart';
import 'package:elwarsha/business_logic/Cubits/edit/edit_cubit.dart';
import 'package:elwarsha/global/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../Helper/MY_SnackBar.dart';
import '../../../business_logic/Cubits/getInfo/get_info_cubit.dart';
import 'Profile personly.dart';

// ignore: camel_case_types
// ignore: camel_case_types, must_be_immutable
class Profile_edit extends StatelessWidget {
  Profile_edit({super.key});

  // ignore: non_constant_identifier_names
  String? name = GetInfoCubit.Info!['name'];

  String? email = GetInfoCubit.Info!['email'];

  String? pass = GetInfoCubit.Info!['pass'];

  // ignore: non_constant_identifier_names
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: mycolors.first_color,
          title: Text("تعديل الملف الشخصى",
              style: TextStyle(
                  fontSize: 22,
                  color: mycolors.titleFont,
                  fontWeight: FontWeight.bold)),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              EditCubit.caneditEmail = true;
              EditCubit.caneditName = true;
              EditCubit.image = null;
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: mycolors.secod_color,
            ),
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            EditCubit.caneditEmail = true;
            EditCubit.caneditName = true;
            EditCubit.image = null;
            return true;
          },
          child: BlocBuilder<EditCubit, EditState>(
            builder: (context, state) {
              return Container(
                  color: mycolors.first_color,
                  child: ListView(children: [
                    Container(
                      padding: EdgeInsetsDirectional.all(
                          myApplication.widthClc(25, context)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: EditCubit.isUploading
                                  ? Container(
                                  height: 200,
                                  child: Center(
                                    child: myApplication.myloading(context),
                                  ))
                                  : Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: mycolors.secod_color,
                                    width: 1.0,
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 100,
                                  backgroundColor: Colors.white,
                                  child: SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: Hero(
                                      tag: "profilePic",
                                      child: ClipOval(
                                          child: EditCubit.image != null
                                            ? FittedBox(
                                            fit: BoxFit.cover,
                                            child: Image.file(
                                              File(EditCubit.image!.path),
                                            ),
                                          )
                                            : (stordimagePath != null
                                              ? FittedBox(
                                            fit: BoxFit.cover,
                                            child: Image.file(
                                              File(stordimagePath!),
                                            ),
                                          )
                                              : (GetInfoCubit.Info!['url'] != null
                                              ? FittedBox(
                                            fit: BoxFit.cover,
                                            child: Image.network(
                                              GetInfoCubit.Info!['url'],
                                              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                                return Icon(Icons.person,color: mycolors.secod_color,size: myApplication.widthClc(100, context),);
                                              },
                                            ),
                                          )
                                              : Icon(Icons.person,color: mycolors.secod_color,size: myApplication.widthClc(100, context),)))

                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                myApplication.imageDialog(context,"prof");
                              },
                              onLongPress: () {
                                myApplication.zoomoutImageialog(context);
                              },
                            ),
                            Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: myApplication.hightClc(20, context),
                                  ),
                                  const Text(
                                    'الاسم',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: myApplication.hightClc(20, context),
                                  ),
                                  TextFormField(
                                    onChanged: (val) {
                                      name = val;
                                    },
                                    style: TextStyle(
                                      color: EditCubit.caneditName
                                          ? Colors.grey
                                          : Colors.black,
                                    ),
                                    readOnly: EditCubit.caneditName,
                                    initialValue: GetInfoCubit.Info!['name'],
                                    keyboardType: TextInputType.emailAddress,
                                    textAlign: TextAlign.end,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'أدخل الاسم';
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: IconButton(
                                        icon: Icon(
                                          EditCubit.caneditName
                                              ? Icons.edit
                                              : Icons.edit_off,
                                          color: mycolors.secod_color,
                                        ),
                                        onPressed: () {
                                          BlocProvider.of<EditCubit>(context)
                                              .changNamestate();
                                        },
                                      ),
                                      contentPadding:
                                      const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 10),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: const OutlineInputBorder(),
                                      hintText: 'ادخل الاسم',
                                    ),
                                  ),
                                  SizedBox(
                                    height: myApplication.hightClc(30, context),
                                  ),
                                  const Text(
                                    'الايميل',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: myApplication.hightClc(20, context),
                                  ),
                                  TextFormField(
                                    style: TextStyle(color: Colors.grey),
                                    readOnly: true,
                                    initialValue: GetInfoCubit.Info!['email'],
                                    textAlign: TextAlign.end,
                                    decoration: InputDecoration(
                                      contentPadding:
                                      const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 10),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: const OutlineInputBorder(),
                                      hintText: 'ادخل الايميل',
                                      labelStyle:
                                      const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(
                                    height: myApplication.hightClc(60, context),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: myApplication.widthClc(
                                            50, context)),
                                    child: SizedBox(
                                      height:
                                      myApplication.hightClc(40, context),
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white),
                                        onPressed: () async {
                                          print("mohamed");
                                          myApplication.keyboardFocus(context);
                                          GetInfoCubit.Info!["pass"] ==
                                              userKey.toString()
                                              ? {
                                            showTopSnackBar(
                                                Overlay.of(context),
                                                MySnackBar.error(
                                                    message:
                                                    "لا يمكن تغيير الرقم السرى لهذا الحساب")),
                                          }
                                              : myApplication.confirmPassword(
                                              context,
                                              "تغيير كلمة السر",
                                              pass);
                                        },
                                        child: Text(
                                          'تغيير الرقم السرى',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: myfonts.smallfont,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: myApplication.hightClc(60, context),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: myApplication.hightClc(50, context),
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                        onPressed: () async {
                          myApplication.keyboardFocus(context);
                          if (formKey.currentState!.validate()) {
                            // if(EditCubit.picAlignment != alignmentval){
                            //   showTopSnackBar(
                            //       Overlay.of(context),
                            //       MySnackBar.success(
                            //         message: "تم الحفظ",
                            //       ));
                            //   BlocProvider.of<EditCubit>(context).saveAlignmentToFirebase(EditCubit.picAlignment);
                            //   Navigator.pop(context);
                            // }
                            if (EditCubit.image != null) {
                              await BlocProvider.of<EditCubit>(context).uploadImage(context).whenComplete(() => Navigator.pop(context));
                              await BlocProvider.of<EditCubit>(context).SetImage();

                              showTopSnackBar(
                                  Overlay.of(context),
                                  MySnackBar.success(
                                    message: "تم الحفظ",
                                  ));
                            }
                            // if (email != GetInfoCubit.Info!['email']) {
                            //   showTopSnackBar(
                            //       Overlay.of(context),
                            //       MySnackBar.success(
                            //         message: "تم الحفظ",
                            //       ));
                            //   fauth.currentUser?.updateEmail(email!);
                            // }
                            if (name != GetInfoCubit.Info!['name']) {
                              showTopSnackBar(
                                  Overlay.of(context),
                                  MySnackBar.success(
                                    message: "تم الحفظ",
                                  ));
                              ffire
                                  .collection("customers")
                                  .doc(userKey)
                                  .update({
                                "name": name,
                              });
                              Navigator.pop(context);
                            }
                            // EditCubit.caneditEmail = true;
                            EditCubit.caneditName = true;
                          }
                        },
                        child: const Text(
                          'حفظ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ]));
            },
          ),
        ),
    );
  }
}

