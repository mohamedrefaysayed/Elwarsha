// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:cached_network_image/cached_network_image.dart';
import 'package:elwarsha/Constents/colors.dart';
import 'package:elwarsha/Helper/MyApplication.dart';
import 'package:elwarsha/Presentation/Screens/Payment/payment%20method.dart';
import 'package:elwarsha/Presentation/Screens/store/more_details.dart';
import 'package:elwarsha/business_logic/Cubits/archive/archive_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/cart/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Car_Shoping extends StatelessWidget {
  const Car_Shoping({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mycolors.first_color,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: mycolors.first_color,
        elevation: 0,
        title: Text("عربة التسوق",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            )),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.amber,
            )),
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context,State){
          if(State is CartInitial){
            if(CartCubit.selectedProducts.isEmpty){
              BlocProvider.of<CartCubit>(context).emit(CartEmpty());
            }
          }
        },
              builder: (context, state) {

                if(state is CartInitial){
                  return Column(
                    children: [
                      SizedBox(
                        height: myApplication.hightClc(50, context),
                      ),
                      Container(
                        height: myApplication.hightClc(50, context),
                        child: Text(
                          CartCubit.price.toString() + " : المجموع",
                          style: TextStyle(
                              fontSize: myApplication.widthClc(25, context),
                              fontWeight: FontWeight.w400,
                              color: mycolors.secod_color),
                        ),
                      ),
                      SizedBox(
                        height: myApplication.hightClc(20, context),
                      ),

                      Container(
                        height: myApplication.hightClc(500, context),
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: CartCubit.selectedProducts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: (){
                                myApplication.navigateTo(
                                    more_details(
                                      product:CartCubit.selectedProducts[index],
                                      dockey: CartCubit.selectedProducts[index].warshaId,
                                      doctype: CartCubit.selectedProducts[index].type,
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
                                            child: Hero(
                                              tag: "$index",
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(20),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.fill,
                                                  imageUrl: CartCubit.selectedProducts[index].ImgPath,
                                                  height: myApplication.hightClc(100, context),
                                                  width: myApplication.widthClc(100, context),
                                                  placeholder: (context, url) => Container(
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
                                                    CartCubit.selectedProducts[index].warshaName,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: myApplication.hightClc(
                                                        50, context),
                                                  ),
                                                  IconButton(
                                                    onPressed: () async {
                                                      CartCubit.price -= CartCubit
                                                          .selectedProducts[index].price
                                                          .toInt();
                                                      CartCubit.selectedProducts
                                                          .removeAt(index);

                                                      BlocProvider.of<CartCubit>(context).emit(CartInitial());
                                                    },
                                                    icon: Icon(Icons.remove_circle),
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
                                                  CartCubit.selectedProducts[index].price.toString(),
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
                                                      CartCubit.selectedProducts[index].name,
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
                      ),

                      SizedBox(
                        height: myApplication.hightClc(50, context),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                mycolors.secod_color),
                            shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ))),
                        onPressed: () async{
                          if(CartCubit.price > 0){
                            ArchiveCubit.archived.addAll(CartCubit.selectedProducts);
                            myApplication.navigateToReplace(
                                context, Payment_method());
                          }

                        },
                        child: Container(
                          height: myApplication.hightClc(50, context),
                          width: myApplication.widthClc(200, context),
                          child: Center(
                            child: Text(
                              "إتمام عملية الشراء",
                              style: TextStyle(
                                  fontSize: myApplication.widthClc(20, context)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );

                }else{
                  return Center(
                    child: Text(
                      "لا يوجد اى قطع",
                      style: TextStyle(
                          fontSize: myApplication.widthClc(30, context)),
                    ),
                  );
                }
              },
            )
    );
  }
}
