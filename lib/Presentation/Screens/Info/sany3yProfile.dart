
// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elwarsha/Constents/colors.dart';
import 'package:elwarsha/Helper/MyApplication.dart';
import 'package:elwarsha/Presentation/Screens/profile/Elwarsha_profile.dart';
import 'package:elwarsha/business_logic/Cubits/Map/map_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/elwarsha_Info/elwarsha_info_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/sany3y/sany3y_cubit.dart';
import 'package:elwarsha/global/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Sany3yProfile extends StatefulWidget {
  const Sany3yProfile(this.Sany3yKey);

  final String Sany3yKey;

  @override
  State<Sany3yProfile> createState() => _Sany3yProfileState();
}

class _Sany3yProfileState extends State<Sany3yProfile> {


  @override
  void initState() {
    BlocProvider.of<Sany3yCubit>(context).getInfo(widget.Sany3yKey);
    super.initState();
  }

  int virtcaldivhight = 1;



  infoLoading() {
    return Container(
      width: double.infinity,
      color: mycolors.first_color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: myApplication.hightClc(170, context),
          ),

          Container(
              height: myApplication.hightClc(600, context),
              width: double.infinity,
              child: ListView.builder(
                  itemCount: 7,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Container(
                          height: myApplication.hightClc(35, context),
                          width: myApplication.widthClc(340, context),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                        SizedBox(
                          height: myApplication.hightClc(50, context),
                        ),
                      ],
                    );
                  })),
          SizedBox(
            height: myApplication.hightClc(30, context),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Sany3yCubit, Sany3yState>(
      builder: (context, state) {
        if (state is Sany3yLoading) {
          return infoLoading();
        } else {
          return Scaffold(
            backgroundColor: mycolors.first_color,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: mycolors.first_color,
              title: Text(Sany3yCubit.Info!["name"],
                  style: TextStyle(
                      fontSize: myApplication.widthClc(22, context),
                      fontWeight: FontWeight.bold)),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: mycolors.secod_color,
                ),
              ),
            ),
            body: RefreshIndicator(
              color: mycolors.secod_color,
              backgroundColor: mycolors.secod_color.withOpacity(0),
              onRefresh: () async {
                print("object");
                if (await myApplication.checkInternet() == true) {
                  BlocProvider.of<ElwarshaInfoCubit>(context)
                      .emit(ElwarshaInfoLoading());
                  await BlocProvider.of<Sany3yCubit>(context).getInfo(widget.Sany3yKey);
                }
              },
              child: Container(
                  color: mycolors.first_color,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: myApplication.widthClc(20, context)),

                  child: ListView(
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: myApplication.hightClc(50, context),
                            ),
                            RatingBar.builder(
                                allowHalfRating: true,
                                itemSize: myApplication.widthClc(40, context),
                                ignoreGestures: true,
                                itemCount: 5,
                                initialRating: Sany3yCubit.Info!["rating"]*1.0,
                                itemBuilder: (context, _) =>
                                    Icon(
                                      Icons.star,
                                      color: mycolors.secod_color,
                                    ),
                                onRatingUpdate: (_) {}),
                            SizedBox(
                              height: myApplication.hightClc(50, context),
                            ),
                            Text("تخصص : ${Sany3yCubit.Info!["Specialization"]}",
                                style:
                                TextStyle(fontSize: myApplication.widthClc(20, context), fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: myApplication.hightClc(50, context),
                            ),
                            Sany3yCubit.Info!["inWarsha"]
                                ? GestureDetector(
                                onTap: () {
                                  myApplication.navigateTo(
                                      Elwarsha_profile( warshaKey: Sany3yCubit.Info!["warshaId"], ), context);
                                },
                                child: Text(
                                  "تابع لورشة ${Sany3yCubit.Info!["warshaName"]}",
                                  style: TextStyle(
                                      fontSize: 18, color: mycolors.secod_color),
                                ),
                            )
                                : Text(
                              "غير تابع لأى ورشة",
                              style: TextStyle(
                                  fontSize: 18,),
                            ),

                            SizedBox(
                              height: myApplication.hightClc(50, context),
                            ),

                            Text("عدد التصليحات : ${Sany3yCubit.Info!["fixCount"]}",
                                style:
                                TextStyle(fontSize: myApplication.widthClc(20, context), fontWeight: FontWeight.bold)),

                            SizedBox(
                              height: myApplication.hightClc(50, context),
                            ),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            width: myApplication.widthClc(240, context),
                                            child: Divider(thickness: 5, color: Colors.black,height: 5,)),
                                        SizedBox(
                                          width: myApplication.widthClc(10, context),
                                        ),
                                        Text("التعليقات",
                                            style: TextStyle(
                                                fontSize: 18, color: Colors.black,fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: myApplication.hightClc(10, context),
                                    ),
                                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>( // inside the <> you enter the type of your stream
                                      stream: FirebaseFirestore.instance.collection("customers").doc(widget.Sany3yKey).collection("coments").snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData && snapshot.data != null) {
                                          if(snapshot.data!.docs.length == 0){
                                            virtcaldivhight = 1;
                                          }else{
                                            virtcaldivhight = snapshot.data!.docs.length;

                                          }
                                          BlocProvider.of<ElwarshaInfoCubit>(context).emit(ElwarshaInfoInitial());
                                          return Container(
                                              width: myApplication.widthClc(300, context),
                                              child: snapshot.data!.docs.length != 0
                                                  ? ListView.builder(
                                                  physics: NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: snapshot.data!.docs.length,
                                                  itemBuilder:(context,index){
                                                    return  Padding(
                                                      padding:  EdgeInsets.symmetric(vertical: 10),
                                                      child: Container(
                                                        width: myApplication.widthClc(300, context),
                                                        padding: EdgeInsetsDirectional.all(5),
                                                        decoration: BoxDecoration(
                                                          // color: Colors.black,
                                                          border: Border.all(color: Colors.black),
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              children: [
                                                                Text(snapshot.data!.docs[index].get("name"),
                                                                    style:
                                                                    TextStyle(fontSize: 16, color: mycolors.secod_color)),
                                                                Container(
                                                                  padding: EdgeInsets.only(top: 5,right: 5,left: 10),
                                                                  child: CircleAvatar(
                                                                    radius: 30,
                                                                    backgroundColor: Colors.grey,
                                                                    child: ClipOval(
                                                                      child: snapshot.data!.docs[index].get("url") != null
                                                                          ? Image.network(
                                                                        snapshot.data!.docs[index].get("url"),
                                                                        fit: BoxFit.cover,

                                                                      )
                                                                          : Icon(Icons.person,size: myApplication.widthClc(30, context),),
                                                                    ),),
                                                                )
                                                              ],
                                                            ),
                                                            Container(
                                                              padding: EdgeInsets.all(10),
                                                              child: Text(snapshot.data!.docs[index].get("comment"),
                                                                style: TextStyle(
                                                                    fontSize: 14, color: Colors.black),textAlign: TextAlign.center,),
                                                            ),

                                                          ],
                                                        ),
                                                      ),
                                                    );

                                                  }
                                              )
                                                  : Container(
                                                height: myApplication.hightClc(150, context),
                                                child: Center(
                                                  child: Text(
                                                    "لا توجد تعليقات",style: TextStyle(fontSize: myApplication.widthClc(20, context)),
                                                  ),
                                                ),
                                              )
                                          );
                                        }else if (snapshot.hasError) {
                                          return const Text('Error');
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(width: myApplication.widthClc(10, context),),
                                Container(
                                    height:virtcaldivhight * myApplication.hightClc(180, context),
                                    child: VerticalDivider(thickness: 5, color: Colors.black, width: 5,)),
                              ],
                            ),

                            SizedBox(
                              height: myApplication.hightClc(100, context),
                            ),

                          ]),
                    ],
                  )),


            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
            floatingActionButton: Role == "صاحب سيارة"
            ? FloatingActionButton.large(
              backgroundColor: mycolors.popColor,
              onPressed: (){
                myApplication.comentdialog(context, widget.Sany3yKey);
              },
              child: Text("إضافة تعليق",style: TextStyle(fontSize: myApplication.widthClc(14, context)),),
            )
                : Container(),
          );
        }
      },
    );
  }

}
