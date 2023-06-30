// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elwarsha/Presentation/Screens/Map/requestProfile.dart';
import 'package:elwarsha/business_logic/Cubits/Map/map_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/RepairRequest/repair_request_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import '../../../../Constents/colors.dart';
import '../../../../Helper/MyApplication.dart';
import 'dart:math' show asin, cos, pow, sin, sqrt;
// ignore: camel_case_types
class requests extends StatelessWidget {
  const requests({super.key});

  // ignore: non_constant_identifier_names

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mycolors.first_color,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: mycolors.first_color,
          elevation: 0,
          title: const Text("طلبات التصليح",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
          leading: Container()
        ),
        body: Container(
          width: double.infinity,
          color: mycolors.first_color,
          child: BlocBuilder<RepairRequestCubit, RepairRequestState>(
            builder: (context, state) {
              return Container(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>( // inside the <> you enter the type of your stream
                  stream: FirebaseFirestore.instance.collection("Requests").snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {

                      BlocProvider.of<RepairRequestCubit>(context).emit(RepairRequestInitial());
                      return snapshot.data!.docs.length != 0
                          ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder:(context,index){
                            GeoPoint carlocation = snapshot.data!.docs[index].get("location");

                            final distanceResult = distance(MapCubit.position!.latitude, MapCubit.position!.longitude, carlocation.latitude, carlocation.longitude);
                            final km = distanceResult.toInt().toString();
                            final m = ((distanceResult-distanceResult.toInt())*1000).toInt() .toString();
                            return  Padding(
                              padding: EdgeInsets.symmetric(horizontal: myApplication.widthClc(20, context),vertical: myApplication.widthClc(15, context)),
                              child: InkWell(
                                onTap: (){
                                  myApplication.navigateToReplace(context, requestProfile(
                                    id: snapshot.data!.docs[index].get("id"),
                                  problem: snapshot.data!.docs[index].get("broblem"),));
                                },
                                child: Container(
                                  width: myApplication.widthClc(300, context),
                                  padding: EdgeInsetsDirectional.all(5),
                                  decoration: BoxDecoration(
                                    color: mycolors.first_color,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10),
                                      boxShadow: [

                                        BoxShadow(
                                          color: mycolors.popColor,
                                          blurRadius: 10,
                                          offset: const Offset(1, 1.5),
                                          spreadRadius: 3,
                                        )

                                      ]
                                  ),
                                  child: Column(
                                    children: [
                                      Text("مشكلة : "+snapshot.data!.docs[index].get("broblem"),style: TextStyle(fontSize: myApplication.widthClc(20, context)),),
                                      SizedBox(height: myApplication.hightClc(10, context),),
                                      Text("على بعد "+km+" كم"+" و "+m+" متر",style: TextStyle(fontSize: myApplication.widthClc(22, context),fontWeight: FontWeight.bold))


                                    ],
                                  ),
                                ),
                              ),
                            );

                          }
                      )
                          : Container(
                        height: myApplication.hightClc(150, context),
                        child: Center(
                          child: Text(
                            "لا توجد طلبات",style: TextStyle(fontSize: myApplication.widthClc(20, context)),
                          ),
                        ),
                      );
                    }else if (snapshot.hasError) {
                      return const Text('Error');
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),

              );
            },
          ),
        ));
  }


  double _toRadians(double degrees) => degrees * pi / 180;

  num _haversin(double radians) => pow(sin(radians / 2), 2);


  double distance(double lat1, double lon1, double lat2, double lon2) {
    const r = 6372.8; // Earth radius in kilometers

    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);
    final lat1Radians = _toRadians(lat1);
    final lat2Radians = _toRadians(lat2);

    final a = _haversin(dLat) + cos(lat1Radians) * cos(lat2Radians) * _haversin(dLon);
    final c = 2 * asin(sqrt(a));

    return r * c;
  }

}



