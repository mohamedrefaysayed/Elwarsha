// ignore_for_file: file_names, empty_catches, non_constant_identifier_names, depend_on_referenced_packages
import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:elwarsha/Constents/colors.dart';
import 'package:elwarsha/Constents/fontsize.dart';
import 'package:elwarsha/Presentation/Screens/auth/Reset_Password.dart';
import 'package:elwarsha/business_logic/Cubits/Map/map_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/carInfo/car_info_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/getInfo/get_info_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/role/role_cubit.dart';
import 'package:elwarsha/global/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart' show Fluttertoast, Toast, ToastGravity;
import 'package:image_picker/image_picker.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../Presentation/Screens/profile/Profile personly.dart';
import '../business_logic/Cubits/edit/edit_cubit.dart';
import 'MY_SnackBar.dart';


class CustomSearchDelegate extends SearchDelegate {
  TextStyle get searchieldStyle => const TextStyle();
  @override
  InputDecorationTheme get searchFieldDecorationTheme => const InputDecorationTheme();
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
        icon: const Icon(Icons.clear),
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
      icon: const Icon(Icons.arrow_back),
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
            title: Text(
              result,
            ),
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
            title: Text(result, style: const TextStyle(color: Colors.grey)),
          );
        },
      ),
    );
  }
}

// ignore: camel_case_types
class myApplication {
  static Future<bool> checkInternet() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      final flag = true;
      return flag;
    } else {
      final flag = false;
      return flag;
    }
  }

  static double hightClc(int myHeight, BuildContext context) {
    return MediaQuery.of(context).size.height * myHeight / 856.7272727272727;
  }

  static double widthClc(int myWidth, BuildContext context) {
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

  static Future push_fade(BuildContext context, Widget widget, {data}) async => Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => widget,
          transitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (_, a, b, c) =>
              FadeTransition(opacity: a, child: c),
        ),
      );
  static push_scale(BuildContext context, Widget widget, {data}) =>
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => widget,
          transitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (_, a, __, c) =>
              ScaleTransition(scale: a, child: c),
        ),
      );
  static Future push_size(BuildContext context, Widget widget, {data}) =>
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => widget,
          transitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (_, a, __, c) => Align(
            child: SizeTransition(
              sizeFactor: a,
              axisAlignment: 0.0,
              child: c,
            ),
          ),
        ),
      );
  static push_rotation(BuildContext context, Widget widget, {data}) =>
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => widget,
          transitionDuration: const Duration(milliseconds: 250),
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
            transitionDuration: const Duration(milliseconds: 250),
            transitionsBuilder: (_, a, __, c) => SlideTransition(
                  position:
                      Tween(begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
                          .animate(a),
                  child: c,
                )),
      );
  static push_left(BuildContext context, Widget widget, {data}) =>
      Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) => widget,
            transitionDuration: const Duration(milliseconds: 250),
            transitionsBuilder: (_, a, __, c) => SlideTransition(
                  position:
                      Tween(begin: const Offset(-1.0, 0.0), end: const Offset(0.0, 0.0))
                          .animate(a),
                  child: c,
                )),
      );
  static push_up(BuildContext context, Widget widget, {data}) => Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) => widget,
            transitionDuration: const Duration(milliseconds: 250),
            transitionsBuilder: (_, a, __, c) => SlideTransition(
                  position:
                      Tween(begin: const Offset(0.0, -1.0), end: const Offset(0.0, 0.0))
                          .animate(a),
                  child: c,
                )),
      );
  static push_down(BuildContext context, Widget widget, {data}) =>
      Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) => widget,
            transitionDuration: const Duration(milliseconds: 250),
            transitionsBuilder: (_, a, __, c) => SlideTransition(
                  position:
                      Tween(begin: const Offset(0.0, 1.0), end: const Offset(0.0, 0.0))
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

  static myloading(BuildContext context) {
    return CircularProgressIndicator(
      color: mycolors.secod_color,
    );
  }

  // static myConfirmationdialog(context, quz, onconfirm()) {
  //   QuickAlert.show(
  //     onConfirmBtnTap: () {
  //       Navigator.pop(context);
  //       onconfirm();
  //     },
  //     title: quz,
  //     titleColor: Colors.white,
  //     confirmBtnColor: mycolors.secod_color,
  //     confirmBtnText: "نعم",
  //     cancelBtnText: "الغاء",
  //     backgroundColor: mycolors.first_color,
  //     customAsset: "assets/images/1024.png",
  //     context: context,
  //     type: QuickAlertType.confirm,
  //   );
  // }

  static agencydialog(context, agencyName, agencyAddress, agencyPhone, agency) {
   AwesomeDialog(
     padding: const EdgeInsets.all(30),
     dialogType: DialogType.noHeader,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("تابعة للتوكيل",style: TextStyle(color: Colors.white,fontSize: myfonts.mediumfont),),
          const SizedBox(height: 30,),
          TextFormField(
            textAlign: TextAlign.end,
            style: const TextStyle(color: Colors.white),
            initialValue: agencyName,
            onChanged: (val) {
              agencyName = val;
            },
            strutStyle: StrutStyle.disabled,
            decoration: InputDecoration(
              labelStyle: const TextStyle(),
              label: Align(
                alignment: Alignment.centerRight,
                child: Text("اسم التوكيل",style: TextStyle(color: mycolors.secod_color,fontSize: myfonts.mediumfont),),
              ),
            ),
          ),
          TextFormField(
            textAlign: TextAlign.end,
            style: const TextStyle(color: Colors.white),
            initialValue: agencyAddress,
            onChanged: (val) {
              agencyAddress = val;
            },
            strutStyle: StrutStyle.disabled,
            decoration: InputDecoration(
              labelStyle: const TextStyle(),
              label: Align(
                alignment: Alignment.centerRight,
                child: Text("عنوان التوكيل",style: TextStyle(color: mycolors.secod_color,fontSize: myfonts.mediumfont)),
              ),
            ),
          ),
          TextFormField(
            textAlign: TextAlign.end,
            style: const TextStyle(color: Colors.white),
            initialValue: agencyPhone,
            keyboardType: TextInputType.phone,
            onChanged: (val) {
              agencyPhone = val;
            },
            strutStyle: StrutStyle.disabled,
            decoration: InputDecoration(
              labelStyle: const TextStyle(),
              label: Align(
                alignment: Alignment.centerRight,
                child: Text("رقم التوكيل",style: TextStyle(color: mycolors.secod_color,fontSize: myfonts.mediumfont)),
              ),
            ),
          ),
          const SizedBox(height: 30,),
        ],
      ),
      btnOkOnPress: () {
        showTopSnackBar(
            Overlay.of(context), MySnackBar.success(message: "تم الحفظ"));
        myApplication.keyboardFocus(context);
        ffire
            .collection("customers")
            .doc(userKey)
            .collection("car")
            .doc("agency")
            .set({
          "agencyName": agencyName,
          "agencyAddress": agencyAddress,
          "agencyPhone": agencyPhone,
        });
        ffire
            .collection("customers")
            .doc(userKey)
            .collection("car")
            .doc("data")
            .update({
          "agency": agency,
        });
        BlocProvider.of<CarInfoCubit>(context).getAgencyInfo();
      },
      btnOkColor: mycolors.secod_color,
      btnOkText: "حفظ",
      btnCancelText: "الغاء",
     btnCancelColor: mycolors.first_color,
     btnCancelOnPress: (){},
      dialogBackgroundColor: mycolors.popColor,
      context: context,
    ).show();
  }

  static confirmPassword(context, title, passowrd) {
    String? userpass;
    AwesomeDialog(
      animType: AnimType.bottomSlide,
      padding: const EdgeInsets.all(20),
      dialogType: DialogType.noHeader,
          body: Column(
            children: [
              TextFormField(
                cursorColor: Colors.white,
                textAlign: TextAlign.end,
                style: const TextStyle(color: Colors.white),
                onChanged: (val) {
                  userpass = val;
                },
                strutStyle: StrutStyle.disabled,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(),
                  label: Align(
                    alignment: Alignment.center,
                    child: Text("الرقم السرى",style: TextStyle(color: mycolors.secod_color,fontSize: myfonts.mediumfont)),
                  ),
                ),
              ),
              const SizedBox(height: 30,),
            ],
          ),
      btnOkOnPress: () {
        if (userpass == passowrd) {
          showTopSnackBar(
              Overlay.of(context),
              MySnackBar.success(
                message: "تم التأكيد",
              ));
          Navigator.pop(context);
          myApplication.push_up(
              context,
              ResetPassowrd(
                  email: GetInfoCubit.Info!["email"],
                  title: "تغيير الرقم السرى",
                  type: "password"));
        } else {
          showTopSnackBar(
              Overlay.of(context),
              const MySnackBar.error(
                message: "الرقم السرى غير صحيح",
              ));
        }
      },
      title: title,
      titleTextStyle: TextStyle(color: Colors.white,fontSize: myfonts.mediumfont),
      btnOkColor: mycolors.secod_color,
      btnOkText: "تأكيد",
      btnCancelText: "الغاء",
      btnCancelOnPress: (){},
      btnCancelColor: mycolors.first_color,
      dialogBackgroundColor: mycolors.popColor,
      context: context,
    ).show();
  }

  static zoomoutImageialog(context) {
    AwesomeDialog(
      autoHide: const Duration(seconds: 3),
      dialogType: DialogType.noHeader,
      dialogBackgroundColor: Colors.white10.withOpacity(0),
      body: SizedBox(
        height: myApplication.hightClc(350, context),
        width: myApplication.widthClc(350, context),
        child: Hero(
          tag: "profilePic",
          child: ClipRRect(
              child: stordimagePath != null
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
                  : Icon(Icons.person,color: mycolors.secod_color,size: myApplication.widthClc(100, context),))






          ),
        )
      ),
      context: context,
    ).show();
  }

  static myConfirmationdialog(context, quz, Function() onconfirm) {
    AwesomeDialog(
        autoHide: const Duration(seconds: 5),
        context: context,
        animType: AnimType.topSlide,
        dialogBackgroundColor: mycolors.popColor,
        dialogType: DialogType.warning,
        title: quz,
        titleTextStyle:
            TextStyle(color: Colors.white, fontSize: myfonts.mediumfont),
        btnCancelOnPress: () {},
        btnCancelText: "الغاء",
        btnCancelColor: mycolors.first_color,
        btnOkOnPress: () {
          onconfirm();
        },
        btnOkText: "تأكيد",
        btnOkColor: mycolors.secod_color)
      .show();
  }

  static imageDialog(context) {
    AwesomeDialog(
      dialogType: DialogType.noHeader,
      dialogBackgroundColor: mycolors.popColor,
      body: Container(
        margin: EdgeInsets.symmetric(
            horizontal: myApplication.widthClc(40, context)),
        height: MediaQuery.of(context).size.height / 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'من فضلك اختر مكان الصورة',
              style:
                  TextStyle(color: Colors.white, fontSize: myfonts.mediumfont),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              //if user click this button, user can upload image from gallery
              onPressed: () {
                Navigator.pop(context);
                BlocProvider.of<EditCubit>(context)
                    .getImage(ImageSource.gallery, context);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'معرض الصور',
                    style: TextStyle(
                        color: mycolors.first_color,
                        fontSize: myfonts.smallfont),
                  ),
                  Icon(
                    Icons.image,
                    color: mycolors.secod_color,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              //if user click this button. user can upload image from camera
              onPressed: () {
                Navigator.pop(context);
                BlocProvider.of<EditCubit>(context)
                    .getImage(ImageSource.camera, context);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'الكاميرا',
                    style: TextStyle(
                        color: mycolors.first_color,
                        fontSize: myfonts.smallfont),
                  ),
                  Icon(
                    Icons.camera,
                    color: mycolors.secod_color,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      context: context,
    ).show();
  }

  static markerDialog(context,lat,lng,olat,olng,onDetails){
    AwesomeDialog(
      width: myApplication.widthClc(300, context),
        context: context,
      dialogType: DialogType.noHeader,
      dialogBackgroundColor: mycolors.popColor,
      body: SizedBox(
        height: myApplication.hightClc(150, context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              style: TextButton.styleFrom(backgroundColor: mycolors.first_color),
              onPressed: (){
                myApplication.openMapsSheet(context,lat,lng,olat,olng);
              },
              icon: Icon(Icons.navigation_outlined,color: mycolors.secod_color,),
              label: Text("بدء رحلة",style: TextStyle(color: Colors.white,fontSize: myfonts.smallfont),),),
            TextButton.icon(
              style: TextButton.styleFrom(backgroundColor: mycolors.first_color),
              onPressed: (){
                onDetails();
              },
              icon: Icon(Icons.details,color: mycolors.secod_color,),
              label: Text("عرض التفاصيل",style: TextStyle(color: Colors.white,fontSize: myfonts.smallfont)),),
          ],
        ),
      )

    ).show();
  }

  static openMapsSheet(context,lat,lng,olat,olng) async {
    try {
      final coords = Coords(lat,lng);
      final Ocoords = Coords(olat,olng);

      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        backgroundColor: mycolors.popColor,
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Wrap(
                children: <Widget>[
                  for (var map in availableMaps)
                    ListTile(
                      onTap: () {
                        map.showDirections(destination: coords,origin: Ocoords);
                        Navigator.pop(context);
                        Navigator.pop(context);
            },
                      title: Text(map.mapName,style: const TextStyle(color: Colors.white),),
                      leading: CircleAvatar(
                        backgroundColor: mycolors.popColor,
                          radius: 10.0,
                          child: Image.asset("assets/images/mapIcon.png"),
                      ),

                    ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
    }
  }

  static radioButtonBuilder(value,groupValue,onChanged){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(value,style: TextStyle(color: Colors.white,fontSize: myfonts.smallfont)),
        const SizedBox(width: 10,),
        Radio(
          activeColor: mycolors.secod_color,
            value: value, groupValue: groupValue, onChanged: onChanged),
      ],
    );
  }

  static roleDialog(context,onpressed) {
    AwesomeDialog(
      width: 350,
      dialogType: DialogType.noHeader,
      dialogBackgroundColor: mycolors.popColor,
      body: BlocBuilder<RoleCubit, RoleState>(
  builder: (context, state) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("التسجيل ك",style: TextStyle(color: Colors.white,fontSize: myfonts.largfont),),
            const SizedBox(height: 30,),
            myApplication.radioButtonBuilder("سائق سيارة", RoleCubit.role, (val){
              BlocProvider.of<RoleCubit>(context).changestate(val);
            }),
            myApplication.radioButtonBuilder("صنيعي", RoleCubit.role, (val){
              BlocProvider.of<RoleCubit>(context).changestate(val);
            }),
            myApplication.radioButtonBuilder("صاحب ورشة", RoleCubit.role, (val){
              BlocProvider.of<RoleCubit>(context).changestate(val);
            }),


          ],
        ),

      );
  },
),
      btnOkOnPress: onpressed,
      btnOkText: "متابعة",
      btnOkColor: mycolors.secod_color,
      context: context,
    ).show();
  }

  static Future<bool> onWillPop(BuildContext context) {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      showTopSnackBar(Overlay.of(context),
          const MySnackBar.error(message: "اضغط مره اخرى للخروج"));
      return Future.value(false);
    }
    return Future.value(true);
  }

 static noInternet(context){
    return Center(
      child: Container(
        color: mycolors.first_color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off,size: 150,color: mycolors.secod_color,),
            Text("لا يوجد اتصال بالانترنت",style: TextStyle(fontWeight: FontWeight.bold,fontSize: myfonts.largfont),),
                SizedBox(height: 30,),
                TextButton(
                    onPressed: (){
                      BlocProvider.of<MapCubit>(context).getMyCurrentLocation();
                    },
                    child: Text("اعادة المحاولة",style: TextStyle(color: Colors.white,fontSize: myfonts.smallfont),)),
          ],
        ),
      ),
    );
  }

 static elwarshaOffline(context){
    return Center(
      child: Container(
        width: double.infinity,
        color: mycolors.first_color.withOpacity(0.7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.key_off,size: 150,color: mycolors.secod_color,),
            Text("الورشة مغلقة ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: myfonts.largfont),),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }



}
