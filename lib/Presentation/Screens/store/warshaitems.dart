// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elwarsha/Constents/colors.dart';
import 'package:elwarsha/Helper/MyApplication.dart';
import 'package:elwarsha/Presentation/Screens/store/addItem.dart';
import 'package:elwarsha/Presentation/Screens/store/more_details.dart';
import 'package:elwarsha/business_logic/Cubits/addItem/add_item_cubit.dart';
import 'package:elwarsha/global/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'item.dart';


class warshaItems extends StatelessWidget {
  //const Spare({Key? key}) : super(key: key);

  warshaItems({super.key});

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mycolors.first_color,
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        backgroundColor: mycolors.first_color,
        elevation:0,
        title: Text("معروضاتى", style:TextStyle(fontSize: 22 ,fontWeight:FontWeight.bold,)),
      ),
      body:  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>( // inside the <> you enter the type of your stream
        stream: FirebaseFirestore.instance.collection("Elwrash").doc(userKey).collection("spareParts").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Container(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 20,vertical: 70),
                width: double.infinity,
                child: snapshot.data!.docs.length != 0

                    ? GridView.builder(
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

                      child: GestureDetector(
                          onTap: () async{
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
                          dockey: snapshot.data!.docs[index].id,
                          doctype: 'all',
                          canreviwe: false,
                          index: index,

                        ), context);
                      },
                          child: GridTile(
                            header: Row(
                              children: [
                                Spacer(),
                                IconButton(
                                  onPressed: () async {
                                    myApplication.myConfirmationdialog(context, "هل تريد حذف هذه القطعة ", () => BlocProvider.of<AddItemCubit>(context).removeItem(
                                      snapshot.data!.docs[index].id,
                                      snapshot.data!.docs[index].get("type"),
                                      snapshot.data!.docs[index].get("discount"),),);
                                  },
                                  icon: Icon(Icons.remove_circle,size: myApplication.widthClc(30, context),),
                                  color: Colors.red.shade300,
                                ),
                              ],
                            ),
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
                      "لا توجد قطع غيار ",style: TextStyle(fontSize: myApplication.widthClc(20, context)),
                    ),
                  ),
                )
            );
          }else if (snapshot.hasError) {
            return const Text('Error');
          } else {
            return  Container(
                height: myApplication.hightClc(100, context),
                width: myApplication.widthClc(100, context),
                child: myApplication.myloading(context),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: mycolors.popColor,
        onPressed: (){
          myApplication.navigateTo(addItem(), context);
        },
        child: Text("إضافة قطعة",style: TextStyle(fontSize: myApplication.widthClc(14, context)),),
      ),    );
  }
}
