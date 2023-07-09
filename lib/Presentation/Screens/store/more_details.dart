// ignore_for_file: must_be_immutable, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elwarsha/Constents/colors.dart';
import 'package:elwarsha/Helper/MY_SnackBar.dart';
import 'package:elwarsha/Helper/MyApplication.dart';
import 'package:elwarsha/Presentation/Screens/profile/Elwarsha_profile.dart';
import 'package:elwarsha/Presentation/Screens/store/item.dart';
import 'package:elwarsha/business_logic/Cubits/cart/cart_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/comments/comments_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/fav/fav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class more_details extends StatelessWidget {
  Item product;
  String dockey;
  String doctype;
  int virtcaldivhight = 1;
  bool canreviwe;
  int index;

  more_details(
      {required this.product,
      required this.dockey,
      required this.doctype,
      required this.canreviwe,
      required this.index});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: mycolors.first_color,
        title: Text("${product.name}",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            color: mycolors.first_color,
            width: double.infinity,
            padding: EdgeInsetsDirectional.only(top: 10, start: 10, end: 10),
            child: Column(children: [
              Container(
                height: myApplication.hightClc(300, context),
                width: myApplication.widthClc(300, context),
                padding: EdgeInsetsDirectional.all(10),
                child: Hero(
                  tag: "$index",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: product.ImgPath,
                      placeholder: (context, url) => Container(
                        color: mycolors.popColor,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  product.discount
                      ? Row(
                          children: [
                            Text(
                              " ${product.price.toString()} جنية ",
                              style: TextStyle(
                                  fontSize: 20,
                                  decoration: TextDecoration.lineThrough),
                              textDirection: TextDirection.rtl,
                            ),
                            Text(
                              product.discountAmount.toString() +
                                  " جنية  بدلا من ",
                              style: TextStyle(
                                  fontSize: 20, color: mycolors.secod_color),
                              textDirection: TextDirection.rtl,
                            )
                          ],
                        )
                      : Text(
                          " السعر : ${product.price.toString()} جنية",
                          style: TextStyle(fontSize: 20),
                        ),
                ],
              ),
              SizedBox(
                height: myApplication.hightClc(20, context),
              ),
              Text(
                " سعر التركيب : ${product.fixePrice.toString()} جنية",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: myApplication.hightClc(20, context),
              ),
              Text(
                "التوصيل ب 21  جنيه   ",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: myApplication.hightClc(20, context),
              ),
              Text(
                "متوفر الان  ",
                style: TextStyle(fontSize: 20, color: mycolors.secod_color),
              ),
              SizedBox(
                height: myApplication.hightClc(20, context),
              ),
              Text(
                "${product.tradeMark} : العلامة التجارية",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: myApplication.hightClc(30, context),
              ),
              RatingBar.builder(
                  allowHalfRating: true,
                  itemSize: myApplication.widthClc(40, context),
                  ignoreGestures: true,
                  itemCount: 5,
                  initialRating: product.rating,
                  itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: mycolors.secod_color,
                      ),
                  onRatingUpdate: (_) {}),
              SizedBox(
                height: myApplication.hightClc(30, context),
              ),
              canreviwe
                  ? Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () async {
                                await BlocProvider.of<FavCubit>(context)
                                    .setFavItem(product);

                                showTopSnackBar(
                                  Overlay.of(context),
                                  MySnackBar.success(
                                      message: "تمت الإضاقة بنجاح"),
                                  displayDuration: Duration(milliseconds: 100),
                                );
                                Navigator.pop(context);
                              },
                              child: BlocBuilder<FavCubit, FavState>(
                                builder: (context, state) {
                                  if(state is FavLoading){
                                    return myApplication.myloading(context);
                                  }else{
                                    return Text(
                                      "اضافه الى مفضلاتي",
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.black),
                                    );
                                  }
                                },
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              )),
                        ),
                        SizedBox(
                          height: myApplication.hightClc(20, context),
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                CartCubit.selectedProducts.add(product);
                                CartCubit.price += product.price.toInt();
                                BlocProvider.of<CartCubit>(context)
                                    .emit(CartInitial());

                                showTopSnackBar(
                                  Overlay.of(context),
                                  MySnackBar.success(
                                      message: "تمت الإضاقة بنجاح"),
                                  displayDuration: Duration(milliseconds: 100),
                                );
                                Navigator.pop(context);
                              },
                              child: Text(
                                "اضافه الى السلة",
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.black),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: mycolors.secod_color,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              )),
                        ),
                        SizedBox(
                          height: myApplication.hightClc(20, context),
                        ),
                      ],
                    )
                  : Container(),
              Text(
                " : التفاصيل \n ${product.details} ",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: myApplication.hightClc(20, context),
              ),
              canreviwe
                  ? GestureDetector(
                      onTap: () {
                        myApplication.navigateTo(
                            Elwarsha_profile(product.warshaId), context);
                      },
                      child: Text(
                        "تابع لورشة ${product.warshaName.toString()}",
                        style: TextStyle(
                            fontSize: 20, color: mycolors.secod_color),
                      ))
                  : Container(),
              SizedBox(
                height: myApplication.hightClc(20, context),
              ),
              BlocBuilder<CommentsCubit, CommentsState>(
                builder: (context, state) {
                  return Row(
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
                                  child: Divider(
                                    thickness: 5,
                                    color: Colors.black,
                                    height: 5,
                                  )),
                              SizedBox(
                                width: myApplication.widthClc(10, context),
                              ),
                              Text("المراجعات",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          SizedBox(
                            height: myApplication.hightClc(10, context),
                          ),
                          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                            // inside the <> you enter the type of your stream
                            stream: FirebaseFirestore.instance
                                .collection("spareStore")
                                .doc(doctype)
                                .collection("data")
                                .doc(dockey)
                                .collection("comments")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData && snapshot.data != null) {
                                if (snapshot.data!.docs.length == 0) {
                                  virtcaldivhight = 1;
                                } else {
                                  virtcaldivhight = snapshot.data!.docs.length;
                                }
                                BlocProvider.of<CommentsCubit>(context)
                                    .emit(CommentsInitial());
                                return Container(
                                    width: myApplication.widthClc(300, context),
                                    child: snapshot.data!.docs.length != 0
                                        ? ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:
                                                snapshot.data!.docs.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                child: Container(
                                                  width: myApplication.widthClc(
                                                      300, context),
                                                  padding:
                                                      EdgeInsetsDirectional.all(
                                                          5),
                                                  decoration: BoxDecoration(
                                                    // color: Colors.black,
                                                    border: Border.all(
                                                        color: Colors.black),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                              snapshot.data!
                                                                  .docs[index]
                                                                  .get("name"),
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: mycolors
                                                                      .secod_color)),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 5,
                                                                    right: 5,
                                                                    left: 10),
                                                            child: CircleAvatar(
                                                              radius: 30,
                                                              backgroundColor:
                                                                  Colors.grey,
                                                              child: ClipOval(
                                                                child: snapshot
                                                                            .data!
                                                                            .docs[
                                                                                index]
                                                                            .get(
                                                                                "url") !=
                                                                        null
                                                                    ? Image
                                                                        .network(
                                                                        snapshot
                                                                            .data!
                                                                            .docs[index]
                                                                            .get("url"),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      )
                                                                    : Icon(
                                                                        Icons
                                                                            .person,
                                                                        size: myApplication.widthClc(
                                                                            30,
                                                                            context),
                                                                      ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        child: Text(
                                                          snapshot
                                                              .data!.docs[index]
                                                              .get("comment"),
                                                          style: TextStyle(
                                                              fontSize: 14),
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
                                            height: myApplication.hightClc(
                                                150, context),
                                            child: Center(
                                              child: Text(
                                                "لا توجد مراجعات",
                                                style: TextStyle(
                                                    fontSize: myApplication
                                                        .widthClc(20, context)),
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
                        width: myApplication.widthClc(10, context),
                      ),
                      Container(
                          height: virtcaldivhight *
                              myApplication.hightClc(180, context),
                          child: VerticalDivider(
                            thickness: 5,
                            color: Colors.black,
                            width: 5,
                          )),
                    ],
                  );
                },
              ),
              SizedBox(
                height: myApplication.hightClc(80, context),
              ),
            ])),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: canreviwe
          ? FloatingActionButton.large(
              backgroundColor: mycolors.popColor,
              onPressed: () {
                myApplication.reviwedialog(context, dockey, doctype);
              },
              child: Text(
                "إضافة مراجعة",
                style: TextStyle(fontSize: myApplication.widthClc(14, context)),
              ),
            )
          : Container(),
    );
  }
}
