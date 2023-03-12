// ignore_for_file: file_names
import 'dart:io';

import 'package:elwarsha/Constents/colors.dart';
import 'package:elwarsha/Constents/fontsize.dart';
import 'package:elwarsha/business_logic/Cubits/carInfo/car_info_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/getInfo/get_info_cubit.dart';
import 'package:elwarsha/global/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart' show Fluttertoast, Toast, ToastGravity;
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../business_logic/Cubits/edit/edit_cubit.dart';
import 'MY_SnackBar.dart';
class CustomSearchDelegate extends SearchDelegate{

  TextStyle get searchieldStyle => TextStyle(

  );
  InputDecorationTheme get searchFieldDecorationTheme => InputDecorationTheme(
  );
  List<String> searchTerms = [
    "Apple",
    "Banana",
    "Mango",
    "Pear",
    "Watermelons",
    "Blueberries",
    "Pineapples",
    "Strawberries",
    "محمد رفاعى",
    "ايه جمعه",
    "جمعه",
    "رفاعى",
    "ايمان",
  ];

// first overwrite to
// clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return Container(
      color: mycolors.first_color,
      child: ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result,),
          );
        },
      ),
    );
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return Container(
      color: mycolors.first_color,
      child: ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result,style: TextStyle(color: Colors.grey)),
          );
        },
      ),
    );
  }

}

// ignore: camel_case_types
class myApplication {
  // static Future<bool> checkInternet() async {
  //   var result = await Connectivity().checkConnectivity();
  //   if (result == ConnectivityResult.mobile ||
  //       result == ConnectivityResult.wifi) {
  //     final flag = true;
  //     return flag;
  //   } else {
  //     final flag = false;
  //     return flag;
  //   }
  // }

  static double hightClc( int myHeight,BuildContext context) {
    return MediaQuery.of(context).size.height * myHeight / 856.7272727272727;
  }

  static double widthClc( int myWidth,BuildContext context) {
    return MediaQuery.of(context).size.width * myWidth / 392.72727272727275;
  }

  static navigateTo(Widget page, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: ((context) => page)));
  }

  static navigateToRemove(BuildContext context, Widget widget, {data}) =>
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ),
        (Route<dynamic> route) => false,
      );
  static navigateToReplace(BuildContext context, Widget page) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: ((context) => page)));
  }

  static showToast({
    required String text,
    required color,
  }) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor: Colors.blueGrey,
      fontSize: 16,
    );
  }

  static push_fade(BuildContext context, Widget widget, {data}) =>
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => widget,
          transitionDuration: Duration(milliseconds: 250),
          transitionsBuilder: (_, a, b, c) =>
              FadeTransition(opacity: a, child: c),
        ),
      );
  static push_scale(BuildContext context, Widget widget, {data}) =>
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => widget,
          transitionDuration: Duration(milliseconds: 250),
          transitionsBuilder: (_, a, __, c) =>
              ScaleTransition(scale: a, child: c),
        ),
      );
  static push_size(BuildContext context, Widget widget, {data}) =>
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => widget,
          transitionDuration: Duration(milliseconds: 250),
          transitionsBuilder: (_, a, __, c) => Align(
            child: SizeTransition(
              sizeFactor: a,
              child: c,
              axisAlignment: 0.0,
            ),
          ),
        ),
      );
  static push_rotation(BuildContext context, Widget widget, {data}) =>
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => widget,
          transitionDuration: Duration(milliseconds: 250),
          transitionsBuilder: (_, a, __, c) => RotationTransition(
            turns: a,
            child: c,
          ),
        ),
      );
  static push_right(BuildContext context, Widget widget, {data}) =>
      Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) => widget,
            transitionDuration: Duration(milliseconds: 250),
            transitionsBuilder: (_, a, __, c) => SlideTransition(
                  position:
                      Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                          .animate(a),
                  child: c,
                )),
      );
  static push_left(BuildContext context, Widget widget, {data}) =>
      Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) => widget,
            transitionDuration: Duration(milliseconds: 250),
            transitionsBuilder: (_, a, __, c) => SlideTransition(
                  position:
                      Tween(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
                          .animate(a),
                  child: c,
                )),
      );
  static push_up(BuildContext context, Widget widget, {data}) => Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) => widget,
            transitionDuration: Duration(milliseconds: 250),
            transitionsBuilder: (_, a, __, c) => SlideTransition(
                  position:
                      Tween(begin: Offset(0.0, -1.0), end: Offset(0.0, 0.0))
                          .animate(a),
                  child: c,
                )),
      );
  static push_down(BuildContext context, Widget widget, {data}) =>
      Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) => widget,
            transitionDuration: Duration(milliseconds: 250),
            transitionsBuilder: (_, a, __, c) => SlideTransition(
                  position:
                      Tween(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
                          .animate(a),
                  child: c,
                )),
      );

  static keyboardFocus(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
  // static tabd(BuildContext context) {
  //   return KeyboardVisibilityBuilder(
  //       builder: (context, isKeyboardVisible) {
  //         return Text(
  //           'The keyboard is: ${isKeyboardVisible ? 'VISIBLE' : 'NOT VISIBLE'}',
  //         );
  //       }
  //   );
  // }

  static loading(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext c) {
        return AlertDialog(
            backgroundColor: Colors.white.withOpacity(0),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  color: mycolors.popColor.withOpacity(0),
                  height: 50,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ));
      },
    );
  }

  static myloading(BuildContext context) {
    return CircularProgressIndicator(
      color: mycolors.secod_color,
    );
  }

  static mydialog(BuildContext context,quz,onconfirm()){
    QuickAlert.show(
      onConfirmBtnTap: (){
        Navigator.pop(context);
        onconfirm();},
      title: quz,
      titleColor: Colors.white,
      confirmBtnColor: mycolors.secod_color,
      confirmBtnText: "نعم",
      cancelBtnText: "الغاء",
      backgroundColor: mycolors.first_color,
      customAsset: "assets/images/1024.png",
      context: context, type: QuickAlertType.confirm,
    );
  }

  static agencydialog(BuildContext context,agencyName,agencyAddress,agencyPhone,agency){


    QuickAlert.show(
      widget: Column(
        children: [
          TextFormField(
            textAlign: TextAlign.end,
            style: TextStyle(
                color: Colors.white
            ),
            initialValue: agencyName.toString(),

            onChanged: (val){
              agencyName = val;
            },
            strutStyle: StrutStyle.disabled,
            decoration: InputDecoration(
              labelStyle: TextStyle(),
              label: Align(
                alignment: Alignment.centerRight,
                child: Text("اسم التوكيل"),
              ),
            ),
          ),
          TextFormField(
            textAlign: TextAlign.end,
            style: TextStyle(
                color: Colors.white
            ),
            initialValue: agencyAddress.toString(),
            onChanged: (val){
              agencyAddress = val;
            },
            strutStyle: StrutStyle.disabled,
            decoration: InputDecoration(
              labelStyle: TextStyle(),
              label: Align(
                alignment: Alignment.centerRight,
                child: Text("عنوان التوكيل"),
              ),
            ),
          ),
          TextFormField(
            textAlign: TextAlign.end,
            style: TextStyle(
                color: Colors.white
            ),
            initialValue: agencyPhone.toString(),
            keyboardType: TextInputType.phone,
            onChanged: (val){
              agencyPhone = val;
            },
            strutStyle: StrutStyle.disabled,
            decoration: InputDecoration(
              labelStyle: TextStyle(),
              label: Align(
                alignment: Alignment.centerRight,
                child: Text("رقم التوكيل"),
              ),
            ),
          ),
        ],
      ),
      onConfirmBtnTap: (){
        showTopSnackBar(Overlay.of(context),
            MySnackBar.success(message: "تم الحفظ"));
        myApplication.keyboardFocus(context);
        Navigator.pop(context);
        ffire.collection("customers").doc(userKey).collection("car").doc("data").update({
          "agencyName": agencyName,
          "agencyAddress": agencyAddress,
          "agencyPhone": agencyPhone,
          "agency" : agency,
        });
        BlocProvider.of<CarInfoCubit>(context).getInfo();

        },

      title: "تابعة للتوكيل",
      titleColor: Colors.white,
      confirmBtnColor: mycolors.secod_color,
      confirmBtnText: "حفظ",
      cancelBtnText: "الغاء",
      backgroundColor: mycolors.first_color,
      customAsset: "assets/images/1024.png",
      context: context, type: QuickAlertType.confirm,
    );

        }


  static zoomoutImageialog(BuildContext context){
    showDialog(context: context, builder: (BuildContext context){
      return Container(
        child: SimpleDialog(
          backgroundColor: mycolors.popColor,
          alignment: Alignment.center,
          children: [
           Container(
              height: myApplication.hightClc(350, context),
                width: myApplication.widthClc(350, context),
                child: EditCubit.image == null
                    ? Image.network(GetInfoCubit.Info!['url'],
                  fit: BoxFit.contain,
                  height: myApplication.hightClc(500, context),
                  width: myApplication.widthClc(500, context),
                )
                    : Image.file(File(EditCubit.image!.path),
                  fit: BoxFit.contain,
                  height: myApplication.hightClc(500, context),
                  width: myApplication.widthClc(500, context),
                ),


                ),
          ],

        ),
      );
    });
  }

  static imageDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: mycolors.popColor,
            shape:
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)),
            title: Text('من فضلك اختر مكان الصورة',style: TextStyle(color: Colors.white),),
            alignment: Alignment.center,
            content: Container(
              margin: EdgeInsets.symmetric(horizontal: myApplication.widthClc(40, context)),
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white),
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      BlocProvider.of<EditCubit>(context).getImage(ImageSource.gallery,context);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('معرض الصور',style: TextStyle(color:  mycolors.first_color,fontSize: myfonts.smallfont),),
                        Icon(Icons.image,color: mycolors.secod_color,),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white),
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      BlocProvider.of<EditCubit>(context).getImage(ImageSource.camera,context);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('الكاميرا',style: TextStyle(color:  mycolors.first_color,fontSize: myfonts.smallfont),),
                        Icon(Icons.camera,color: mycolors.secod_color,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }



  static paydialog(BuildContext context,quz,onconfirm()){
    QuickAlert.show(
      onConfirmBtnTap: (){
        Navigator.pop(context);
        onconfirm();},
      title: quz,
      titleColor: Colors.white,
      confirmBtnColor: mycolors.secod_color,
      confirmBtnText: "نعم",
      cancelBtnText: "الغاء",
      backgroundColor: mycolors.first_color,
      customAsset: "assets/images/1024.png",
      context: context, type: QuickAlertType.confirm,
    );
  }


  static Future<bool> onWillPop(BuildContext context) {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      showTopSnackBar(Overlay.of(context),
          MySnackBar.error(message: "اضغط مره اخرى للخروج"));
      return Future.value(false);
    }
    return Future.value(true);
  }

}


