// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elwarsha/Constents/colors.dart';
import 'package:elwarsha/Helper/MY_SnackBar.dart';
import 'package:elwarsha/Helper/MyApplication.dart';
import 'package:elwarsha/business_logic/Cubits/Map/map_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/elwarsha_Info/elwarsha_info_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/getInfo/get_info_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/requests/requests_cubit.dart';
import 'package:elwarsha/global/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Elwarsha_profile extends StatefulWidget {
  const Elwarsha_profile({required this.warshaKey});

  final String warshaKey;

  @override
  State<Elwarsha_profile> createState() => _Elwarsha_profileState();
}

class _Elwarsha_profileState extends State<Elwarsha_profile> {
  @override
  void initState() {
    widget.warshaKey != ""
        ? BlocProvider.of<ElwarshaInfoCubit>(context)
            .getInfo(context, widget.warshaKey)
        : null;
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
    return BlocBuilder<ElwarshaInfoCubit, ElwarshaInfoState>(
      builder: (context, state) {
        if (state is ElwarshaInfoLoading) {
          return infoLoading();
        } else if (state is ElwarshaInfoFailuer) {
          return myApplication.noInternet(context);
        } else {
          return Scaffold(
            backgroundColor: mycolors.first_color,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: mycolors.first_color,
              title: widget.warshaKey != ""
                  ? Text(ElwarshaInfoCubit.Info!["warshaName"],
                      style: TextStyle(
                          fontSize: myApplication.widthClc(22, context),
                          fontWeight: FontWeight.bold))
                  : Text("ورشتى",
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
            body: widget.warshaKey != ""
                ? RefreshIndicator(
                    color: mycolors.secod_color,
                    backgroundColor: mycolors.secod_color.withOpacity(0),
                    onRefresh: () async {
                      print("object");
                      if (await myApplication.checkInternet() == true) {
                        BlocProvider.of<ElwarshaInfoCubit>(context)
                            .emit(ElwarshaInfoLoading());
                        await BlocProvider.of<ElwarshaInfoCubit>(context)
                            .getInfo(context, widget.warshaKey);
                      }
                    },
                    child: Container(
                        color: mycolors.first_color,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: myApplication.widthClc(20, context)),
                        child: ListView(
                          children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: myApplication.hightClc(50, context),
                                  ),
                                  ElwarshaInfoCubit.Info!["warshaState"]
                                      ? Text(
                                      "الورشة مفتوحة",
                                      style: TextStyle(
                                          fontSize: myApplication.widthClc(
                                              20, context),
                                          fontWeight: FontWeight.bold,color: mycolors.secod_color))
                                      : Text(
                                      "الورشة مغلقة",
                                      style: TextStyle(
                                          fontSize: myApplication.widthClc(
                                              20, context),
                                          fontWeight: FontWeight.bold,color: Colors.red)),
                                  SizedBox(
                                    height: myApplication.hightClc(50, context),
                                  ),
                                  RatingBar.builder(
                                      allowHalfRating: true,
                                      itemSize:
                                          myApplication.widthClc(40, context),
                                      ignoreGestures: true,
                                      itemCount: 5,
                                      initialRating: 2.5,
                                      itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: mycolors.secod_color,
                                          ),
                                      onRatingUpdate: (_) {}),
                                  SizedBox(
                                    height: myApplication.hightClc(50, context),
                                  ),
                                  Text(
                                      "ملك : ${ElwarshaInfoCubit.Info!["warshaOwnerName"]}",
                                      style: TextStyle(
                                          fontSize: myApplication.widthClc(
                                              20, context),
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: myApplication.hightClc(50, context),
                                  ),
                                  Text(ElwarshaInfoCubit.Info!["warshaDesc"],
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center),
                                  SizedBox(
                                    height: myApplication.hightClc(50, context),
                                  ),
                                  Text(
                                      "ترخيص رقم:   ${ElwarshaInfoCubit.Info!["warshalicense"]}",
                                      style: TextStyle(
                                          fontSize: myApplication.widthClc(
                                              14, context),
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height:
                                        myApplication.hightClc(50, context),
                                  ),
                                  Role !=  "صاحب ورشة"
                                  ? Container(
                                    height: myApplication.hightClc(50, context),
                                    width: myApplication.widthClc(120, context),
                                    decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.black, width: 2),
                                    ),
                                    child: Role != "صاحب سيارة"
                                    ? ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              mycolors.first_color,
                                        ),
                                        onPressed: () {
                                          GeoPoint geo = ElwarshaInfoCubit
                                              .Info!["warshalocation"];
                                          myApplication.openMapsSheet(
                                              context,
                                              geo.latitude,
                                              geo.longitude,
                                              MapCubit.position!.latitude,
                                              MapCubit.position!.longitude);
                                        },
                                        child: Text(
                                          "بدء رحلة",
                                          style: TextStyle(
                                              fontSize: myApplication
                                                  .widthClc(16, context),
                                              color: mycolors.secod_color,
                                              fontWeight: FontWeight.w600),
                                        ))
                                    : BlocBuilder<RequestsCubit, RequestsState>(
                                        builder: (context, state) {
                                          if(state is RequestsLoading){
                                            return SizedBox(
                                              child: Center(
                                                child: myApplication.myloading(context) ,
                                              )
                                            );
                                          }else{
                                            return ElevatedButton(
                                                style:
                                                ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                  mycolors.first_color,
                                                ),
                                                onPressed: () async {
                                                  if (!GetInfoCubit.Info!["inWarsha"]) {
                                                    await BlocProvider.of<RequestsCubit>(
                                                        context)
                                                        .addRequest(
                                                        ElwarshaInfoCubit
                                                            .Info![
                                                        "warshaKey"]);
                                                    showTopSnackBar(
                                                        Overlay.of(context),
                                                        MySnackBar.success(
                                                            message:
                                                            "تم أرسال الطلب"),
                                                        displayDuration:
                                                        Duration(
                                                            milliseconds:
                                                            100));
                                                  } else {
                                                    showTopSnackBar(
                                                        Overlay.of(context),
                                                        MySnackBar.error(
                                                            message:
                                                            "أنت تابع لورشة بالفعل"),
                                                        displayDuration:
                                                        Duration(
                                                            milliseconds:
                                                            100));
                                                  }
                                                },
                                                child: Text(
                                                  "طلب انضمام",
                                                  style: TextStyle(
                                                      fontSize: myApplication
                                                          .widthClc(
                                                          16, context),
                                                      color: mycolors
                                                          .secod_color,
                                                      fontWeight:
                                                      FontWeight.w600),
                                                ));
                                          }
                                        },
                                      ),
                                  )
                                  :Container(),
                                  SizedBox(
                                    height:
                                    myApplication.hightClc(50, context),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                  width: myApplication.widthClc(
                                                      240, context),
                                                  child: Divider(
                                                    thickness: 5,
                                                    color: Colors.black,
                                                    height: 5,
                                                  )),
                                              SizedBox(
                                                width: myApplication.widthClc(
                                                    10, context),
                                              ),
                                              Text("التعليقات",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: myApplication.hightClc(
                                                10, context),
                                          ),
                                          StreamBuilder<
                                              QuerySnapshot<
                                                  Map<String, dynamic>>>(
                                            // inside the <> you enter the type of your stream
                                            stream: FirebaseFirestore.instance
                                                .collection("Elwrash")
                                                .doc(widget.warshaKey)
                                                .collection("coments")
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData &&
                                                  snapshot.data != null) {
                                                if (snapshot
                                                        .data!.docs.length ==
                                                    0) {
                                                  virtcaldivhight = 1;
                                                } else {
                                                  virtcaldivhight = snapshot
                                                      .data!.docs.length;
                                                }
                                                BlocProvider.of<
                                                            ElwarshaInfoCubit>(
                                                        context)
                                                    .emit(
                                                        ElwarshaInfoInitial());
                                                return Container(
                                                    width: myApplication
                                                        .widthClc(300, context),
                                                    child: snapshot.data!.docs
                                                                .length !=
                                                            0
                                                        ? ListView.builder(
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            shrinkWrap: true,
                                                            itemCount: snapshot
                                                                .data!
                                                                .docs
                                                                .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            10),
                                                                child:
                                                                    Container(
                                                                  width: myApplication
                                                                      .widthClc(
                                                                          300,
                                                                          context),
                                                                  padding:
                                                                      EdgeInsetsDirectional
                                                                          .all(
                                                                              5),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    // color: Colors.black,
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .black),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          Text(
                                                                              snapshot.data!.docs[index].get("name"),
                                                                              style: TextStyle(fontSize: 16, color: mycolors.secod_color)),
                                                                          Container(
                                                                            padding: EdgeInsets.only(
                                                                                top: 5,
                                                                                right: 5,
                                                                                left: 10),
                                                                            child:
                                                                                CircleAvatar(
                                                                              radius: 30,
                                                                              backgroundColor: Colors.grey,
                                                                              child: ClipOval(
                                                                                child: snapshot.data!.docs[index].get("url") != null
                                                                                    ? Image.network(
                                                                                        snapshot.data!.docs[index].get("url"),
                                                                                        fit: BoxFit.cover,
                                                                                      )
                                                                                    : Icon(
                                                                                        Icons.person,
                                                                                        size: myApplication.widthClc(30, context),
                                                                                      ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Container(
                                                                        padding:
                                                                            EdgeInsets.all(10),
                                                                        child:
                                                                            Text(
                                                                          snapshot
                                                                              .data!
                                                                              .docs[index]
                                                                              .get("comment"),
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              color: Colors.black),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            })
                                                        : Container(
                                                            height: myApplication
                                                                .hightClc(150,
                                                                    context),
                                                            child: Center(
                                                              child: Text(
                                                                "لا توجد تعليقات",
                                                                style: TextStyle(
                                                                    fontSize: myApplication
                                                                        .widthClc(
                                                                            20,
                                                                            context)),
                                                              ),
                                                            ),
                                                          ));
                                              } else if (snapshot.hasError) {
                                                return const Text('Error');
                                              } else {
                                                return const CircularProgressIndicator();
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width:
                                            myApplication.widthClc(10, context),
                                      ),
                                      Container(
                                          height: virtcaldivhight *
                                              myApplication.hightClc(
                                                  180, context),
                                          child: VerticalDivider(
                                            thickness: 5,
                                            color: Colors.black,
                                            width: 5,
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        myApplication.hightClc(100, context),
                                  ),
                                ]),
                          ],
                        )),
                  )
                : Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(
                          height: myApplication.hightClc(100, context),
                        ),
                        Text(
                          "أنت لست تابع لأى ورشة",
                          style: TextStyle(
                            fontSize: myApplication.widthClc(20, context),
                          ),
                        ),
                        SizedBox(
                          height: myApplication.hightClc(50, context),
                        ),
                        Text(
                          ": انضم لورشة",
                          style: TextStyle(
                            fontSize: myApplication.widthClc(20, context),
                          ),
                        ),
                        SizedBox(
                          height: myApplication.hightClc(50, context),
                        ),
                        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          // inside the <> you enter the type of your stream
                          stream: FirebaseFirestore.instance
                              .collection("Elwrash")
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              return Container(
                                  width: double.infinity,
                                  child: snapshot.data!.docs.length != 0
                                      ? Container(
                                          height: myApplication.hightClc(
                                              500, context),
                                          child: ListView.builder(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount:
                                                snapshot.data!.docs.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  myApplication.navigateTo(
                                                      Elwarsha_profile(
                                                        warshaKey: snapshot
                                                            .data!
                                                            .docs[index]
                                                            .id,
                                                      ),
                                                      context);
                                                },
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          color: mycolors
                                                              .popColor
                                                              .withOpacity(0.5),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            snapshot.data!
                                                                .docs[index]
                                                                .get(
                                                                    "warshaName"),
                                                            style: TextStyle(
                                                                fontSize: myApplication
                                                                    .widthClc(
                                                                        20,
                                                                        context),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            textAlign:
                                                                TextAlign.end,
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          SizedBox(
                                                            height: myApplication
                                                                .hightClc(20,
                                                                    context),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                snapshot.data!
                                                                    .docs[index]
                                                                    .get(
                                                                        "warshaOwnerName"),
                                                                style: TextStyle(
                                                                    fontSize: myApplication
                                                                        .widthClc(
                                                                            20,
                                                                            context),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                textDirection:
                                                                    TextDirection
                                                                        .rtl,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                              Text(
                                                                "ملك : ",
                                                                style: TextStyle(
                                                                    fontSize: myApplication
                                                                        .widthClc(
                                                                            20,
                                                                            context),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                textDirection:
                                                                    TextDirection
                                                                        .rtl,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: myApplication
                                                          .hightClc(
                                                              30, context),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      : Container(
                                          height: myApplication.hightClc(
                                              150, context),
                                          child: Center(
                                            child: Text(
                                              "لا يوجد اى مفضلات",
                                              style: TextStyle(
                                                  fontSize: myApplication
                                                      .widthClc(20, context)),
                                            ),
                                          ),
                                        ));
                            } else if (snapshot.hasError) {
                              return const Text('Error');
                            } else {
                              return Center(
                                child: SizedBox(
                                  height: myApplication.hightClc(50, context),
                                  width: myApplication.widthClc(50, context),
                                  child: myApplication.myloading(context),
                                ),
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
            floatingActionButton: Role != "صنيعي"
                ? FloatingActionButton.large(
                    backgroundColor: mycolors.popColor,
                    onPressed: () {
                      myApplication.comentdialog(context, widget.warshaKey);
                    },
                    child: Text(
                      "إضافة تعليق",
                      style: TextStyle(
                          fontSize: myApplication.widthClc(14, context)),
                    ),
                  )
                : Container(),
          );
        }
      },
    );
  }
}
