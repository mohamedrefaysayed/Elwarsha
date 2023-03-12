import 'package:elwarsha/Presentation/Screens/profile/edit_Profile.dart';
import 'package:elwarsha/business_logic/Cubits/Notification_Button/notify_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/getInfo/get_info_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../../Constents/colors.dart';
import '../../../../Constents/fontsize.dart';
import '../../../../Constents/icons.dart';
import '../../../../Helper/MyApplication.dart';
import '../../../../global/global.dart';
import '../../../Helper/MY_SnackBar.dart';
import '../../Team_Info.dart';
import '../Info/Car_Info.dart';
import '../auth/Login_Screen.dart';

// ignore: camel_case_types
class person_file extends StatefulWidget {
  const person_file({super.key});

  @override
  State<person_file> createState() => _person_fileState();
}

class _person_fileState extends State<person_file> {

  Map<String, dynamic>? Info ;


  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetInfoCubit>(context).getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: mycolors.first_color,
          title: Text("الملف الشخصي ",
              style: TextStyle(
                  fontSize: myfonts.largfont,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
        ),
        body: RefreshIndicator(
          color: mycolors.secod_color ,
          backgroundColor: mycolors.secod_color.withOpacity(0),
          onRefresh: ()async{
            await BlocProvider.of<GetInfoCubit>(context).Loading();
            await BlocProvider.of<GetInfoCubit>(context).getInfo();
          },
          child: Container(
            color: mycolors.first_color,
            child: ListView(children: [
              BlocBuilder<GetInfoCubit, GetInfoState>(
                builder: (context, state) {
                  if (state is GetInfoLoading) {
                    return Container(
                      height: myApplication.hightClc(250, context),
                      child: Center(
                        child: myApplication.myloading(context),
                      ),
                    );
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
                                child: CircleAvatar(
                                  radius: myApplication.widthClc(60, context),
                                  backgroundColor: Colors.transparent,
                                  child: SizedBox(
                                      width: myApplication.widthClc(125, context),
                                      height: myApplication.hightClc(125, context),
                                      child: ClipOval(
                                        child: Image.network(
                                            GetInfoCubit.Info!['url']),
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: myApplication.hightClc(10, context),
                              ),
                              Text(GetInfoCubit.Info!['fristname'],
                                  style: TextStyle(
                                      fontSize: myfonts.mediumfont,
                                      fontWeight: FontWeight.bold)),
                              Text(GetInfoCubit.Info!['email'],
                                  style: TextStyle(
                                      fontSize: myfonts.mediumfont,
                                      fontWeight: FontWeight.bold))
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
                            Text("سيارتي",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: myfonts.smallfont)),
                            SizedBox(
                              width: myApplication.widthClc(50, context),
                            ),
                            Icon(
                              myicons.directions_car,
                              color: mycolors.secod_color,
                              size: myApplication.widthClc(25, context),
                            )
                          ]),
                      onTap: () {
                        myApplication.mydialog(
                            context,
                            "هل تريد تغيير بيانات سياراتك ؟",
                            () => myApplication.push_up(context,CarInfo(isregerster: false,)));
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
                                val
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
                              color: Colors.black, fontSize: myfonts.smallfont)),
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
                                      color: Colors.black,
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
                          myApplication.mydialog(
                              context,
                              "هل تريد تعديل الملف الشخصي ؟",
                              () =>
                                  myApplication.push_up(context, Profile_edit()));
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("تعديل الملف الشخصي",
                                  style: TextStyle(
                                      color: Colors.black,
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
                                      color: Colors.black,
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
                          myApplication
                              .mydialog(context, "هل تريد تسجيل الخروج ؟", () {
                            FacebookAuth.instance.logOut();
                            GoogleSignIn().signOut();
                            fauth.signOut();
                            myApplication.navigateToRemove(
                                context, LoginScreen());
                          });
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("تسجيل الخروج",
                                  style: TextStyle(
                                      color: Colors.black,
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
                          myApplication.mydialog(
                              context,
                              "هل تريد حذف الحساب ؟",
                              () => {
                                    if (fauth.currentUser != null)
                                      {fauth.currentUser!.delete()},
                                    FacebookAuth.instance.logOut(),
                                    GoogleSignIn().signOut(),
                                    myApplication.navigateToRemove(context, LoginScreen()), 
                                ffire.collection("cusomers").doc(userKey).delete().whenComplete(() => print("deleted")).onError((error, stackTrace) => print("error")),

                              });
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("حذف الحساب",
                                  style: TextStyle(
                                      color: Colors.black,
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
