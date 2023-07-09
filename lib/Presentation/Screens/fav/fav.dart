
// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elwarsha/Constents/colors.dart';
import 'package:elwarsha/Helper/MY_SnackBar.dart';
import 'package:elwarsha/Helper/MyApplication.dart';
import 'package:elwarsha/Helper/cahch_helper.dart';
import 'package:elwarsha/Presentation/Screens/store/item.dart';
import 'package:elwarsha/Presentation/Screens/store/more_details.dart';
import 'package:elwarsha/business_logic/Cubits/fav/fav_cubit.dart';
import 'package:elwarsha/global/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Fav extends StatelessWidget {
  const Fav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mycolors.first_color,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: mycolors.first_color,
          elevation:0,
          title: Text("المفضلة", style:TextStyle(fontSize: 22 ,fontWeight:FontWeight.bold,
            color:Colors.white , )),
          leading: Container(),

        ),
        body:BlocBuilder<FavCubit, FavState>(
          builder: (context, state) {
              return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>( // inside the <> you enter the type of your stream
                stream: FirebaseFirestore.instance.collection("customers").doc(userKey).collection("fav").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {

                    return Container(
                        width: double.infinity,
                        child: snapshot.data!.docs.length != 0
                            ? Container(
                          height: myApplication.hightClc(670, context),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: (){
                                  myApplication.navigateTo(
                                      more_details(
                                        product:Item(
                                          ImgPath: snapshot.data!.docs[index].get("imagePath"),
                                          price: snapshot.data!.docs[index].get("price"),
                                          name: snapshot.data!.docs[index].get("name"),
                                          type: snapshot.data!.docs[index].get("type"),
                                          details: snapshot.data!.docs[index].get("details"),
                                          discount: snapshot.data!.docs[index].get("discount"),
                                          fixePrice: snapshot.data!.docs[index].get("fixePrice"),
                                          rating: snapshot.data!.docs[index].get("rating"),
                                          tradeMark: snapshot.data!.docs[index].get("tradeMark"),
                                          warshaName: snapshot.data!.docs[index].get("warshaName"),
                                          discountAmount: snapshot.data!.docs[index].get("discountAmount"),
                                          warshaId: snapshot.data!.docs[index].get("warshaId"),
                                        ),
                                        dockey: snapshot.data!.docs[index].get("warshaId"),
                                        doctype: snapshot.data!.docs[index].get("type"),
                                        canreviwe: true,
                                        index: index,
                                      ), context);
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      width: double.infinity,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        decoration: BoxDecoration(
                                            color: mycolors.popColor.withOpacity(0.5),
                                            borderRadius: BorderRadius.circular(20)),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(30),
                                              child:Hero(
                                                tag: "$index",
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(20),
                                                  child: CachedNetworkImage(
                                                    height: myApplication.hightClc(
                                                        100, context),
                                                    width: myApplication.widthClc(
                                                        100, context),
                                                    fit: BoxFit.fill,
                                                    imageUrl: snapshot.data!.docs[index].get("imagePath"),
                                                    placeholder: (context,url) => Container(
                                                      color: mycolors.popColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      snapshot.data!.docs[index].get("warshaName"),
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      width: myApplication.hightClc(
                                                          50, context),
                                                    ),
                                                    IconButton(
                                                      onPressed: ()  {
                                                        myApplication.myConfirmationdialog(
                                                            context,
                                                            "هل تريد حذفها من المفضلة ؟", () async{
                                                          await BlocProvider.of<FavCubit>(context).removeFavItem(snapshot.data!.docs[index].id);
                                                          BlocProvider.of<FavCubit>(context).emit(FavInitial());
                                                        }
                                                        );
                                                      },
                                                      icon: Icon(FontAwesomeIcons.solidHeart),
                                                      color: Colors.red.shade300,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: myApplication.hightClc(
                                                      50, context),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      snapshot.data!.docs[index].get("price").toString(),
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      width: myApplication.hightClc(
                                                          50, context),
                                                    ),
                                                    Container(
                                                      width: myApplication.widthClc(120, context),
                                                      child: Text(
                                                        snapshot.data!.docs[index].get("name"),
                                                        style: TextStyle(
                                                            fontSize: myApplication.widthClc(20, context),
                                                            fontWeight: FontWeight.bold),
                                                        textAlign: TextAlign.end,
                                                        textDirection: TextDirection.rtl,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
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
                              "لا يوجد اى مفضلات",style: TextStyle(fontSize: myApplication.widthClc(20, context)),
                            ),
                          ),
                        )
                    );
                  }else if (snapshot.hasError) {
                    return const Text('Error');
                  } else {
                    return  Center(
                      child: SizedBox(
                          height: myApplication.hightClc(50, context),
                          width: myApplication.widthClc(50, context),
                          child: myApplication.myloading(context),
                      ),
                    );
                  }
                },
              );

          },
        )


    );
  }
}
