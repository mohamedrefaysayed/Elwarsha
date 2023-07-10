// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elwarsha/Constents/colors.dart';
import 'package:elwarsha/Helper/MyApplication.dart';
import 'package:elwarsha/Presentation/Screens/store/cart.dart';
import 'package:elwarsha/Presentation/Screens/store/more_details.dart';
import 'package:elwarsha/business_logic/Cubits/cart/cart_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'item.dart';


class SpareMain extends StatelessWidget {
  //const Spare({Key? key}) : super(key: key);

  SpareMain({super.key});

  @override

  Widget build(BuildContext context) {
    return DefaultTabController(
        length:5,
        child: Scaffold(
          backgroundColor: mycolors.first_color,
          appBar: AppBar(
          leading: Container(),
          centerTitle: true,
          backgroundColor: mycolors.first_color,
          elevation:0,
          title: Text("قطع الغيار", style:TextStyle(fontSize: 22 ,fontWeight:FontWeight.bold,)),
          bottom:TabBar(
            isScrollable:true ,
            indicatorColor: mycolors.secod_color,
            labelColor: mycolors.secod_color,
            tabs: [
              Tab(child:Text("الكل ",style: TextStyle(fontSize: myApplication.widthClc(18, context)),)),
              Tab(child:Text("عروض",style: TextStyle(fontSize: myApplication.widthClc(18, context)))),
              Tab(child:Text("اصلي",style: TextStyle(fontSize: myApplication.widthClc(18, context)))),
              Tab(child:Text("مستعمل",style: TextStyle(fontSize: myApplication.widthClc(18, context)))),
              Tab(child:Text("صيني",style: TextStyle(fontSize: myApplication.widthClc(18, context)))),
            ],
          ),
        ),
          body:  Stack(
            children: [
              TabBarView(
                  children: [
                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>( // inside the <> you enter the type of your stream
                      stream: FirebaseFirestore.instance.collection("spareStore").doc("all").collection("data").snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {

                          return Container(
                              width: double.infinity,
                              child: snapshot.data!.docs.length != 0
                                  ? GridView.builder(
                                padding: EdgeInsetsDirectional.symmetric(horizontal: 20,vertical: 70),
                                addAutomaticKeepAlives: true,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 30,
                                    mainAxisSpacing: 30),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder:( BuildContext context ,int index){
                                  return Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [

                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          blurRadius: 20,
                                          offset: const Offset(1, 1.5),
                                          spreadRadius: 3,

                                        )
                                      ],

                                    ),
                                    child: GestureDetector(onTap: ()async{
                                      myApplication.navigateTo( more_details(
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
                                        dockey: snapshot.data!.docs[index].id,
                                        doctype: 'all',
                                        canreviwe: true,
                                        index: index,
                                      ), context);
                                    },
                                        child: GridTile(
                                          child:Hero(
                                            tag: "$index",
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(20),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.fill,
                                                imageUrl: snapshot.data!.docs[index].get("imagePath"),
                                                placeholder: (context,url) => Container(
                                                  color: mycolors.popColor,
                                                ),
                                              ),
                                            ),
                                          ),

                                          footer:
                                          ClipRRect(
                                              borderRadius: BorderRadius.circular(20),
                                              child: GridTileBar(
                                              backgroundColor:mycolors.popColor.withOpacity(0.7),
                                              title: Center(
                                                child: Text( snapshot.data!.docs[index].get("name").toString(),
                                                    style:TextStyle(fontSize:20,fontWeight: FontWeight.w400 ),
                                                    textAlign: TextAlign.center),
                                              ),
                                              subtitle: Center(
                                                child: Text( snapshot.data!.docs[index].get("price").toString() +" EGP",
                                                    style:TextStyle(fontSize:20,fontWeight: FontWeight.w400 ),
                                                    textAlign: TextAlign.center),
                                              ),
                                            ),
                                          ),
                                        )
                                    ),
                                  );


                                } ,



                              )
                                  : Container(
                                height: myApplication.hightClc(150, context),
                                child: Center(
                                  child: Text(
                                    "لا توجد قطع غيار",style: TextStyle(fontSize: myApplication.widthClc(20, context)),
                                  ),
                                ),
                              )
                          );
                        }else if (snapshot.hasError) {
                          return const Text('Error');
                        } else {
                          return  SizedBox(
                            height: myApplication.hightClc(50, context),
                              width: myApplication.widthClc(50, context),
                              child: CircularProgressIndicator(color: mycolors.secod_color,));
                        }
                      },
                    ),
                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>( // inside the <> you enter the type of your stream
                      stream: FirebaseFirestore.instance.collection("spareStore").doc("sale").collection("data").snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {

                          return Container(
                              width: double.infinity,
                              child: snapshot.data!.docs.length != 0
                                  ? GridView.builder(
                                padding: EdgeInsetsDirectional.symmetric(horizontal: 20,vertical: 70),
                                addAutomaticKeepAlives: true,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 30,
                                    mainAxisSpacing: 30),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder:( BuildContext context ,int index){
                                  return Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [

                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          blurRadius: 20,
                                          offset: const Offset(1, 1.5),
                                          spreadRadius: 3,

                                        )
                                      ],

                                    ),
                                    child: GestureDetector(onTap: ()async{
                                      myApplication.navigateTo( more_details(
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
                                        dockey: snapshot.data!.docs[index].id,
                                        doctype: 'sale',
                                        canreviwe: true,
                                        index: index,


                                      ), context);
                                    },
                                        child: GridTile(
                                          child:Hero(
                                            tag: "$index",
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(20),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.fill,
                                                imageUrl: snapshot.data!.docs[index].get("imagePath"),
                                                placeholder: (context,url) => Container(
                                                  color: mycolors.popColor,
                                                ),
                                              ),
                                            ),
                                          ),

                                          footer:
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: GridTileBar(
                                              backgroundColor:mycolors.popColor.withOpacity(0.7),
                                              title: Center(
                                                child: Text( snapshot.data!.docs[index].get("name").toString(),
                                                    style:TextStyle(fontSize:20,fontWeight: FontWeight.w400 ),
                                                    textAlign: TextAlign.center),
                                              ),
                                              subtitle: Center(
                                                child: Text( snapshot.data!.docs[index].get("price").toString() +" EGP",
                                                    style:TextStyle(fontSize:20,fontWeight: FontWeight.w400 ),
                                                    textAlign: TextAlign.center),
                                              ),
                                            ),
                                          ),
                                        )
                                    ),
                                  );


                                } ,



                              )
                                  : Container(
                                height: myApplication.hightClc(150, context),
                                child: Center(
                                  child: Text(
                                    "لا توجد قطع غيار",style: TextStyle(fontSize: myApplication.widthClc(20, context)),
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
                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>( // inside the <> you enter the type of your stream
                      stream: FirebaseFirestore.instance.collection("spareStore").doc("original").collection("data").snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {

                          return Container(

                              width: double.infinity,
                              child: snapshot.data!.docs.length != 0
                                  ? GridView.builder(
                                padding: EdgeInsetsDirectional.symmetric(horizontal: 20,vertical: 70),
                                addAutomaticKeepAlives: true,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 30,
                                    mainAxisSpacing: 30),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder:( BuildContext context ,int index){
                                  return Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [

                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          blurRadius: 20,
                                          offset: const Offset(1, 1.5),
                                          spreadRadius: 3,

                                        )
                                      ],

                                    ),
                                    child: GestureDetector(onTap: ()async{
                                      myApplication.navigateTo( more_details(
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
                                        dockey: snapshot.data!.docs[index].id,
                                        doctype: 'original',
                                        canreviwe: true,
                                        index: index,


                                      ), context);
                                    },
                                        child: GridTile(
                                          child:Hero(
                                            tag: "$index",
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(20),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.fill,
                                                imageUrl: snapshot.data!.docs[index].get("imagePath"),
                                                placeholder: (context,url) => Container(
                                                  color: mycolors.popColor,
                                                ),
                                              ),
                                            ),
                                          ),

                                          footer:
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: GridTileBar(
                                              backgroundColor:mycolors.popColor.withOpacity(0.7),
                                              title: Center(
                                                child: Text( snapshot.data!.docs[index].get("name").toString(),
                                                    style:TextStyle(fontSize:20,fontWeight: FontWeight.w400 ),
                                                    textAlign: TextAlign.center),
                                              ),
                                              subtitle: Center(
                                                child: Text( snapshot.data!.docs[index].get("price").toString() +" EGP",
                                                    style:TextStyle(fontSize:20,fontWeight: FontWeight.w400 ),
                                                    textAlign: TextAlign.center),
                                              ),
                                            ),
                                          ),
                                        )
                                    ),
                                  );


                                } ,



                              )
                                  : Container(
                                height: myApplication.hightClc(150, context),
                                child: Center(
                                  child: Text(
                                    "لا توجد قطع غيار",style: TextStyle(fontSize: myApplication.widthClc(20, context)),
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
                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>( // inside the <> you enter the type of your stream
                      stream: FirebaseFirestore.instance.collection("spareStore").doc("used").collection("data").snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {

                          return Container(

                              width: double.infinity,
                              child: snapshot.data!.docs.length != 0
                                  ? GridView.builder(
                                padding: EdgeInsetsDirectional.symmetric(horizontal: 20,vertical: 70),
                                addAutomaticKeepAlives: true,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 30,
                                    mainAxisSpacing: 30),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder:( BuildContext context ,int index){
                                  return Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [

                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          blurRadius: 20,
                                          offset: const Offset(1, 1.5),
                                          spreadRadius: 3,

                                        )
                                      ],

                                    ),
                                    child: GestureDetector(onTap: ()async{
                                      myApplication.navigateTo( more_details(
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
                                        dockey: snapshot.data!.docs[index].id,
                                        doctype: 'used',
                                        canreviwe: true,
                                        index: index,


                                      ), context);
                                    },
                                        child: GridTile(
                                          child:Hero(
                                            tag: "$index",
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(20),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.fill,
                                                imageUrl: snapshot.data!.docs[index].get("imagePath"),
                                                placeholder: (context,url) => Container(
                                                  color: mycolors.popColor,
                                                ),
                                              ),
                                            ),
                                          ),

                                          footer:
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: GridTileBar(
                                              backgroundColor:mycolors.popColor.withOpacity(0.7),
                                              title: Center(
                                                child: Text( snapshot.data!.docs[index].get("name").toString(),
                                                    style:TextStyle(fontSize:20,fontWeight: FontWeight.w400 ),
                                                    textAlign: TextAlign.center),
                                              ),
                                              subtitle: Center(
                                                child: Text( snapshot.data!.docs[index].get("price").toString() +" EGP",
                                                    style:TextStyle(fontSize:20,fontWeight: FontWeight.w400 ),
                                                    textAlign: TextAlign.center),
                                              ),
                                            ),
                                          ),
                                        )
                                    ),
                                  );


                                } ,



                              )
                                  : Container(
                                height: myApplication.hightClc(150, context),
                                child: Center(
                                  child: Text(
                                    "لا توجد قطع غيار",style: TextStyle(fontSize: myApplication.widthClc(20, context)),
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
                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>( // inside the <> you enter the type of your stream
                      stream: FirebaseFirestore.instance.collection("spareStore").doc("china").collection("data").snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {

                          return Container(

                              width: double.infinity,
                              child: snapshot.data!.docs.length != 0
                                  ? GridView.builder(
                                padding: EdgeInsetsDirectional.symmetric(horizontal: 20,vertical: 70),
                                addAutomaticKeepAlives: true,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 30,
                                    mainAxisSpacing: 30),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder:( BuildContext context ,int index){
                                  return Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [

                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          blurRadius: 20,
                                          offset: const Offset(1, 1.5),
                                          spreadRadius: 3,

                                        )
                                      ],

                                    ),

                                    child: GestureDetector(onTap: ()async{
                                      myApplication.navigateTo( more_details(
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
                                        dockey: snapshot.data!.docs[index].id,
                                        doctype: 'china',
                                        canreviwe: true,
                                        index: index,


                                      ), context);
                                    },
                                        child: GridTile(
                                          child:Hero(
                                            tag: "$index",
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(20),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.fill,
                                                imageUrl: snapshot.data!.docs[index].get("imagePath"),
                                                placeholder: (context,url) => Container(
                                                  color: mycolors.popColor,
                                                ),
                                              ),
                                            ),
                                          ),

                                          footer:
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: GridTileBar(
                                              backgroundColor:mycolors.popColor.withOpacity(0.7),
                                              title: Center(
                                                child: Text( snapshot.data!.docs[index].get("name").toString(),
                                                    style:TextStyle(fontSize:20,fontWeight: FontWeight.w400 ),
                                                    textAlign: TextAlign.center),
                                              ),
                                              subtitle: Center(
                                                child: Text( snapshot.data!.docs[index].get("price").toString() +" EGP",
                                                    style:TextStyle(fontSize:20,fontWeight: FontWeight.w400 ),
                                                    textAlign: TextAlign.center),
                                              ),
                                            ),
                                          ),
                                        )
                                    ),
                                  );


                                } ,



                              )
                                  : Container(
                                height: myApplication.hightClc(150, context),
                                child: Center(
                                  child: Text(
                                    "لا توجد قطع غيار",style: TextStyle(fontSize: myApplication.widthClc(20, context)),
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
                  ]
              ),
              BlocBuilder<CartCubit, CartState>(
  builder: (context, state) {
    return CartCubit.selectedProducts.length != 0
        ? Positioned(
      right: 20,
      child: FloatingActionButton(
          onPressed: (){
            myApplication.navigateTo(Car_Shoping(), context);
          },
          child: Icon(Icons.shopping_cart,size: myApplication.widthClc(40, context),)
      ),
    )
        : Container();
  },
),

            ],
          ),
        )
    );
  }
}
