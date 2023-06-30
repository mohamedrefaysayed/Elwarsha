import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elwarsha/Constents/fontsize.dart';
import 'package:elwarsha/Helper/MY_SnackBar.dart';
import 'package:elwarsha/business_logic/Cubits/carInfo/car_info_cubit.dart';
import 'package:elwarsha/global/global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../../Constents/colors.dart';
import '../../../../Helper/MyApplication.dart';
import 'package:flutter/material.dart';

// ignore: constant_identifier_names

class requestProfile extends StatefulWidget { const requestProfile( {Key? key, required this.id, required this.problem,}) : super(key: key);

  final String id;
final String problem;



@override
State<requestProfile> createState() => _requestProfileState();
}

class _requestProfileState extends State<requestProfile> {


  @override
  void initState() {
      BlocProvider.of<CarInfoCubit>(context).getInfo(widget.id);
      BlocProvider.of<CarInfoCubit>(context).getAgencyInfo(widget.id);
    super.initState();
  }




  late String pic = "assets/images/car.png";



  infoLoading(){
    return Container(
      color: mycolors.first_color,
      margin: const EdgeInsets.only(left: 30, right: 30, top: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 190,
            width: 340,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Flexible(
              child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index){
                    return Column(
                      children: [
                        Container(
                          height: 35,
                          width: 340,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                        SizedBox(height: 35,),
                      ],
                    );
                  }
              )
          ),


        ],
      ),
    );
  }


  _rowBuilder(msg,content, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text(content, style: TextStyle(fontSize: myfonts.mediumfont)),
        Spacer(),
        Text(msg, style: TextStyle(fontSize: myfonts.mediumfont)),
      ]),
    );
  }





  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          myApplication.keyboardFocus(context);
        },
        child: Scaffold(
          backgroundColor: mycolors.first_color,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: mycolors.first_color,
            leading:  IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: mycolors.secod_color,
              ),
            ),
            title: const Text(
              'طلب تصليح',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            centerTitle: true,
          ),
          body: RefreshIndicator(
            color: mycolors.secod_color ,
            backgroundColor: mycolors.secod_color.withOpacity(0),
            onRefresh: ()async{
              if(await myApplication.checkInternet()==true) {
                await BlocProvider.of<CarInfoCubit>(context).Loading();
                await BlocProvider.of<CarInfoCubit>(context).getInfo(widget.id);
                await BlocProvider.of<CarInfoCubit>(context).getAgencyInfo(widget.id);
              }
            },
            child: BlocBuilder<CarInfoCubit, CarInfoState>(
              builder: (context, state) {
                if (state is CarInfoLoading) {
                  return infoLoading();
                } else if (state is CarInfoFailuer) {
                  return myApplication.noInternet(context);
                } else {
                  pic = CarInfoCubit.Car == "bmw"
                      ? "assets/images/bmw.png"
                      : CarInfoCubit.Car == "مرسيدس"
                      ? "assets/images/marcedec.png"
                      : "assets/images/car.png";
                  return Form(
                    child: Container(
                      color: mycolors.first_color,
                      child: ListView(
                        children: [
                          Container(
                            margin:
                            EdgeInsets.only(left: myApplication.widthClc(30, context), right: myApplication.widthClc(30, context), top: myApplication.hightClc(25, context)),
                            child: Column(
                              children: [
                                SizedBox(
                                    height: myApplication.hightClc(190, context),
                                    width: myApplication.widthClc(340, context),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Image.asset(pic),
                                    )),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(height: myApplication.hightClc(20, context),),
                                    _rowBuilder(" : المشكلة", widget.problem, context),
                                    _rowBuilder(" : نوع السيارة", CarInfoCubit.Car!, context),
                                    _rowBuilder(" : موديل السيارة", CarInfoCubit.Model!, context),
                                    _rowBuilder(" : سعة المحرك", CarInfoCubit.EnginCap!, context),
                                    _rowBuilder(" : قوة المحرك", CarInfoCubit.EnginPow!, context),
                                    _rowBuilder(" : نوع الهيكل", CarInfoCubit.StructType!, context),


                                    CarInfoCubit.agency == "n"
                                    ? Container()
                                    : Column(
                                      children: [
                                        Text( "تابعة لتوكيل : " +CarInfoCubit.agencyInfo!["agencyName"],style: TextStyle(fontSize: myApplication.widthClc(18, context)),),
                                        SizedBox(height: myApplication.hightClc(10, context),),

                                        Row(
                                          children: [
                                            Text( "رقم لتوكيل : " +CarInfoCubit.agencyInfo!["agencyPhone"],style: TextStyle(fontSize: myApplication.widthClc(14, context))),
                                            Spacer(),
                                            Text( "عنوان التوكيل : " +CarInfoCubit.agencyInfo!["agencyAddress"],style: TextStyle(fontSize: myApplication.widthClc(14, context))),

                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white),
                              onPressed: () async{
                                final QuerySnapshot<Map<String,dynamic>> sanay3ya = await ffire.collection("Elwrash").doc(userKey).collection("sanay3ya").get();
                                await ffire.collection("Requests").get().then((value) {
                                  
                                  if(sanay3ya.docs.isNotEmpty){
                                    value.docs.forEach((element) {
                                      if(element["id"]==widget.id){
                                        ffire.collection("Requests").doc(element.id).delete();
                                      }
                                    });
                                  }else{
                                    showTopSnackBar(Overlay.of(context),MySnackBar.error(message: "ليس عندك صنايعية , اضف البعض أولا"));
                                  }

                                  
                                });

                              },
                              child: const Text(
                                'قبول الطلب',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ));
  }
}
