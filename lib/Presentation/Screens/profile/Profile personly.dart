import 'dart:io';

import 'package:elwarsha/Helper/chach_helper.dart';
import 'package:elwarsha/Presentation/Screens/Info/Elwarsha_Info.dart';
import 'package:elwarsha/Presentation/Screens/Splash_Screens/splash.dart';
import 'package:elwarsha/Presentation/Screens/profile/edit_Profile.dart';
import 'package:elwarsha/business_logic/Cubits/Notification_Button/notify_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/getInfo/get_info_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../../Constents/colors.dart';
import '../../../../Constents/fontsize.dart';
import '../../../../Constents/icons.dart';
import '../../../../Helper/MyApplication.dart';
import '../../../../global/global.dart';
import '../../../Helper/MY_SnackBar.dart';
import '../../Team_Info.dart';
import '../Info/Car_Info.dart';

String? stordimagePath;

// ignore: camel_case_types
class person_file extends StatefulWidget {
  const person_file({super.key});

  @override
  State<person_file> createState() => _person_fileState();
}

class _person_fileState extends State<person_file> with AutomaticKeepAliveClientMixin<person_file>{

  Map<String, dynamic>? Info ;

  @override
  void initState(){
    super.initState();
      BlocProvider.of<GetInfoCubit>(context).getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mycolors.first_color,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: mycolors.first_color,
          title: Text("الملف الشخصي ",
              style: TextStyle(
                  fontSize: myfonts.largfont,
                  color: mycolors.titleFont,
                  fontWeight: FontWeight.bold)),
        ),
        body: RefreshIndicator(
          color: mycolors.secod_color ,
          backgroundColor: mycolors.secod_color.withOpacity(0),
          onRefresh: ()async{
            if(await myApplication.checkInternet()==true) {
              await BlocProvider.of<GetInfoCubit>(context).Loading();
              await BlocProvider.of<GetInfoCubit>(context).getInfo();
            }
          },
          child: Container(
            color: mycolors.first_color,
            child: ListView(children: [
              BlocBuilder<GetInfoCubit, GetInfoState>(
                builder: (context, state) {
                  if (state is GetInfoLoading) {
                    return Container(
                        padding: EdgeInsetsDirectional.symmetric(
                            horizontal: myApplication.widthClc(50, context),
                            vertical: myApplication.widthClc(25, context)),
                        height: myApplication.hightClc(250, context),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: myApplication.widthClc(60, context),
                                backgroundColor: Colors.grey.withOpacity(0.5),
                              ),
                              SizedBox(height: 30,),
                              Container(
                                height: myApplication.hightClc(30, context),
                                width: myApplication.widthClc(150, context),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                              ),
                            ]
                        ));
                  } else if (state is GetInfoSucsses) {
                    return Container(
                        padding: EdgeInsetsDirectional.symmetric(
                            horizontal: myApplication.widthClc(50, context),
                            vertical: myApplication.widthClc(25, context)),
                        height: myApplication.hightClc(250, context),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  myApplication.zoomoutImageialog(context);},
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: mycolors.secod_color,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: myApplication.widthClc(60, context),
                                    backgroundColor: Colors.grey.withOpacity(0.5),
                                    child: SizedBox(
                                        width: myApplication.widthClc(125, context),
                                        height: myApplication.hightClc(125, context),
                                        child: Hero(
                                          tag: "profilePic",
                                          child: ClipOval(
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
                                        )),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: myApplication.hightClc(25, context),
                              ),
                              ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return LinearGradient(
                                    colors: [mycolors.secod_color, mycolors.secod_color],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    tileMode: TileMode.clamp,
                                  ).createShader(bounds);
                                },
                                child: Text(
                                    GetInfoCubit.Info!['name'],
                                    style: TextStyle(
                                      fontSize: myfonts.largfont,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )),
                              ),


                              // Text(GetInfoCubit.Info!['email'],
                              //     style: TextStyle(
                              //         fontSize: myfonts.mediumfont,
                              //         fontWeight: FontWeight.bold,color: mycolors.fontColor,))
                            ]));
                  } else {
                    return Center(
                      child: Text("ther is a problem !"),
                    );
                  }
                },
              ),
              Container(
                padding: EdgeInsetsDirectional.symmetric(
                    horizontal: myApplication.widthClc(40, context)),
                child: Column(
                  children: [
                    InkWell(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                                Role == "سائق سيارة" ? "سيارتي" : "الورشة",
                                style: TextStyle(
                                    color: mycolors.fontColor,
                                    fontSize: myfonts.smallfont)),
                            SizedBox(
                              width: myApplication.widthClc(50, context),
                            ),
                            Icon(
                              Role == "سائق سيارة" ?  myicons.directions_car : Icons.home_work_sharp,

                              color: mycolors.secod_color,
                              size: myApplication.widthClc(25, context),
                            )
                          ]),
                      onTap: () {
                        myApplication.myConfirmationdialog(
                            context,
                            Role == "سائق سيارة" ? "هل تريد تغيير بيانات سياراتك ؟" : "هل تريد تغيير بيانات ورشتك ؟",
                            () => Role == "سائق سيارة" ? myApplication.push_up(context,CarInfo(isregerster: false,))
                                : myApplication.push_up(context, elwarshaInfo(isregerster: false,)),
                        );
                      },
                    ),
                    SizedBox(
                      height: myApplication.hightClc(25, context),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      BlocBuilder<NotifyCubit, NotifyState>(
                        builder: (context, state) {
                          return Switch(
                              value: NotifyCubit.notify,
                              activeTrackColor: mycolors.popColor,
                              activeColor: mycolors.secod_color,
                              inactiveThumbColor: mycolors.popColor,
                              inactiveTrackColor: Colors.black,
                              onChanged: (val) {
                                BlocProvider.of<NotifyCubit>(context).setnotify();
                                !val
                                    ? showTopSnackBar(
                                        Overlay.of(context),
                                        MySnackBar.success(
                                            message: "تم قفل التنبيهات"))
                                    : showTopSnackBar(
                                        Overlay.of(context),
                                        MySnackBar.success(
                                            message: "تم تشغيل التنبيهات"));
                              });
                        },
                      ),
                      SizedBox(
                        width: myApplication.widthClc(100, context),
                      ),
                      Text("التنبيهات",
                          style: TextStyle(
                              color: mycolors.fontColor, fontSize: myfonts.smallfont)),
                      SizedBox(
                        width: myApplication.widthClc(50, context),
                      ),
                      Icon(
                        Icons.notifications_active,
                        color: mycolors.secod_color,
                        size: myApplication.widthClc(25, context),
                      ),
                    ]),
                    SizedBox(
                      height: myApplication.hightClc(25, context),
                    ),
                    InkWell(
                        onTap: () {},
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("سجل الطلبات",
                                  style: TextStyle(
                                      color: mycolors.fontColor,
                                      fontSize: myfonts.smallfont)),
                              SizedBox(
                                width: myApplication.widthClc(50, context),
                              ),
                              Icon(Icons.watch_later,
                                  color: mycolors.secod_color,
                                  size: myApplication.widthClc(25, context)),
                            ])),
                    SizedBox(
                      height: myApplication.hightClc(25, context),
                    ),
                    InkWell(
                        onTap: () {
                          myApplication.myConfirmationdialog(
                              context,
                              "هل تريد تعديل الملف الشخصي ؟",
                              () => myApplication.push_up(context, Profile_edit()));
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("تعديل الملف الشخصي",
                                  style: TextStyle(
                                      color: mycolors.fontColor,
                                      fontSize: myfonts.smallfont)),
                              SizedBox(
                                width: myApplication.widthClc(50, context),
                              ),
                              Image.asset("assets/images/Registration.png")
                              // Icon(Icons.edit, color: mycolors.secod_color,size: myApplication.widthClc(25, context)),
                            ])),
                    SizedBox(
                      height: myApplication.hightClc(25, context),
                    ),
                    InkWell(
                        onTap: () {
                          myApplication.push_size(context, TeamInfo());
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("معلومات عن التطبيق",
                                  style: TextStyle(
                                      color: mycolors.fontColor,
                                      fontSize: myfonts.smallfont)),
                              SizedBox(
                                width: myApplication.widthClc(50, context),
                              ),
                              Icon(Icons.info,
                                  color: mycolors.secod_color,
                                  size: myApplication.widthClc(25, context)),
                            ])),
                    SizedBox(
                      height: myApplication.hightClc(25, context),
                    ),
                    InkWell(
                        onTap: () {

                          if(fauth.currentUser!=null){
                            fauth.signOut();
                          }
                          myApplication
                              .myConfirmationdialog(context, "هل تريد تسجيل الخروج ؟", () {
                            CahchHelper.clearData();
                            CahchHelper.saveData(key: "showHome", value: true);

                            SignedIn = false;



                            myApplication.navigateToRemove(context, SplashScreen(showHome: true, signMethod: "normal"));

                          });
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("تسجيل الخروج",
                                  style: TextStyle(
                                      color: mycolors.fontColor,
                                      fontSize: myfonts.smallfont)),
                              SizedBox(
                                width: myApplication.widthClc(50, context),
                              ),
                              Icon(Icons.logout,
                                  color: mycolors.secod_color,
                                  size: myApplication.widthClc(25, context)),
                            ])),
                    SizedBox(
                      height: myApplication.hightClc(25, context),
                    ),
                    InkWell(
                        onTap: () {
                          myApplication.myConfirmationdialog(
                              context,
                              "هل تريد حذف الحساب ؟",
                              ()async{
                                    if (fauth.currentUser != null) {
                                      await fauth.currentUser!.delete();
                                    };


                                    if(Role == "صاحب ورشة"){
                                      await ffire.collection("Elwrash").doc(userKey).delete().whenComplete(() => print("deleted")).onError((error, stackTrace) => print("error"));
                                    }

                                    CahchHelper.clearData();
                                    CahchHelper.saveData(key: "showHome", value: true);

                                    SignedIn = false;

                                    myApplication.navigateToRemove(context, SplashScreen(showHome: true, signMethod: "normal"));
                                await ffire.collection("customers").doc(userKey).delete().whenComplete(() => print("deleted")).onError((error, stackTrace) => print("error"));

                        }



                        );
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("حذف الحساب",
                                  style: TextStyle(
                                      color: mycolors.fontColor,
                                      fontSize: myfonts.smallfont)),
                              SizedBox(
                                width: myApplication.widthClc(50, context),
                              ),
                              Icon(Icons.delete_forever,
                                  color: mycolors.secod_color,
                                  size: myApplication.widthClc(25, context)),
                            ])),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }

  bool get wantKeepAlive => true;
}
