// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elwarsha/Constents/colors.dart';
import 'package:elwarsha/Helper/MyApplication.dart';
import 'package:elwarsha/Presentation/Screens/Info/sany3yProfile.dart';
import 'package:elwarsha/business_logic/Cubits/requests/requests_cubit.dart';
import 'package:elwarsha/global/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class sany3yaTeam extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mycolors.first_color,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: mycolors.first_color,
        title: Text("الطاقم",
            style: TextStyle(
                fontSize: myApplication.widthClc(22, context),
                fontWeight: FontWeight.bold)),
        leading: Container(),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: myApplication.hightClc(100, context),
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              // inside the <> you enter the type of your stream
              stream: FirebaseFirestore.instance
                  .collection("Elwrash")
                  .doc(userKey)
                  .collection("sanay3ya")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return Container(
                      width: double.infinity,
                      child: snapshot.data!.docs.length != 0
                          ? Container(
                        height: myApplication.hightClc(500, context),
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                myApplication.navigateTo(
                                    Sany3yProfile(snapshot
                                        .data!.docs[index]
                                        .get("sany3yId")),
                                    context);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: mycolors.popColor
                                            .withOpacity(0.5),
                                        borderRadius:
                                        BorderRadius.circular(20)),
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        Text(
                                          snapshot.data!.docs[index]
                                              .get("sany3yName"),
                                          style: TextStyle(
                                              fontSize: myApplication
                                                  .widthClc(20, context),
                                              fontWeight:
                                              FontWeight.bold),
                                          textAlign: TextAlign.end,
                                          textDirection:
                                          TextDirection.rtl,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: myApplication.hightClc(
                                              20, context),
                                        ),
                                        Text(
                                          snapshot.data!.docs[index]
                                              .get("Specialization"),
                                          style: TextStyle(
                                              fontSize: myApplication
                                                  .widthClc(20, context),
                                              fontWeight:
                                              FontWeight.bold),
                                          textAlign: TextAlign.end,
                                          textDirection:
                                          TextDirection.rtl,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: myApplication.hightClc(
                                              20, context),
                                        ),
                                        RatingBar.builder(
                                            allowHalfRating: true,
                                            itemSize: myApplication
                                                .widthClc(40, context),
                                            ignoreGestures: true,
                                            itemCount: 5,
                                            initialRating: snapshot
                                                .data!.docs[index]
                                                .get("rating"),
                                            itemBuilder: (context, _) =>
                                                Icon(
                                                  Icons.star,
                                                  color: mycolors
                                                      .secod_color,
                                                ),
                                            onRatingUpdate: (_) {}),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: myApplication.hightClc(
                                        30, context),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                          : Container(
                        height: myApplication.hightClc(150, context),
                        child: Center(
                          child: Text(
                            "لا يوجد اى صنايعية",
                            style: TextStyle(
                                fontSize:
                                myApplication.widthClc(20, context)),
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
    );
  }
}
