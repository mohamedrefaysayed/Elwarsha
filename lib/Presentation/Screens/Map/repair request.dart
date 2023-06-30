// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elwarsha/business_logic/Cubits/Map/map_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/RepairRequest/repair_request_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Constents/colors.dart';
import '../../../../Constents/fontsize.dart';
import '../../../../Helper/MyApplication.dart';
import '../../../../global/global.dart';
import '../Info/Custom_Car_Info.dart';
import '../Main_Screen/MainScreen.dart';

// ignore: camel_case_types
class Repair_Request extends StatelessWidget {
  const Repair_Request({super.key});

  // ignore: non_constant_identifier_names
  _BroblemBuilder(msg, BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Text("$msg", style: TextStyle(fontSize: myfonts.mediumfont)),
      Radio(
          fillColor:
          MaterialStateColor.resolveWith((states) => mycolors.secod_color),
          value: "$msg",
          groupValue: RepairRequestCubit.repair,
          onChanged: (val) {



            BlocProvider.of<RepairRequestCubit>(context).set_Repair(val!);
          })
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: mycolors.first_color,
          elevation: 0,
          title: const Text("طلب التصليح",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
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
        body: Container(
          width: double.infinity,
          color: mycolors.first_color,
          child: BlocBuilder<RepairRequestCubit, RepairRequestState>(
            builder: (context, state) {
              return Column(
                children: [
                  Container(
                    height: myApplication.hightClc(420, context),
                    padding: EdgeInsetsDirectional.only(
                        top: myApplication.hightClc(30, context),
                        end: myApplication.hightClc(40, context)),
                    color: mycolors.first_color,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _BroblemBuilder("عفشة", context),
                          _BroblemBuilder("كهرباء", context),
                          _BroblemBuilder("كوتش", context),
                          _BroblemBuilder("أعطال ميكانيكية", context),
                          _BroblemBuilder("لا أدرى", context),
                          _BroblemBuilder("أخرى", context),
                        ]),
                  ),
                  SizedBox(
                    height: myApplication.hightClc(50, context),
                  ),
                  Container(
                      padding: EdgeInsetsDirectional.only(
                          end: myApplication.hightClc(30, context)),
                      alignment: Alignment.topRight,
                      child: Text(" هل هذه سيارتك؟",
                          style: TextStyle(
                              fontSize: myfonts.mediumfont,
                              fontWeight: FontWeight.bold))),
                  SizedBox(
                    height: myApplication.hightClc(20, context),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(children: [
                        Text("لا", style: TextStyle(fontSize: myfonts
                            .mediumfont)),
                        Radio(
                            fillColor: MaterialStateColor.resolveWith(
                                    (states) => mycolors.secod_color),
                            value: false,
                            groupValue: RepairRequestCubit.Car,
                            onChanged: (val) {
                              BlocProvider.of<RepairRequestCubit>(context)
                                  .set_Car(val!);
                            })
                      ]),
                      SizedBox(
                        width: myApplication.widthClc(40, context),
                      ),
                      Row(children: [
                        Text("نعم ",
                            style: TextStyle(fontSize: myfonts.mediumfont)),
                        Radio(
                            fillColor: MaterialStateColor.resolveWith(
                                    (states) => mycolors.secod_color),
                            value: true,
                            groupValue: RepairRequestCubit.Car,
                            onChanged: (val) {
                              BlocProvider.of<RepairRequestCubit>(context)
                                  .set_Car(val!);
                            })
                      ]),
                    ],
                  ),
                  SizedBox(
                    height: myApplication.hightClc(50, context),
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                      onPressed: () async{
                        if (RepairRequestCubit.repair == null) {
                          myApplication.showToast(
                              text: "اختر العطل", color: Colors.white);
                        }
                        if (RepairRequestCubit.Car == null) {
                          myApplication.showToast(
                              text: "اختر السيارة", color: Colors.white);
                        }
                        if (RepairRequestCubit.repair != null) {
                          if (!RepairRequestCubit.Car!) {
                            myApplication.navigateToReplace(
                                context, const CustomCarInfo());
                          } else {
                            isinrequestmode = false;
                            myApplication.navigateToRemove(
                                context, const MainScreen());
                            await ffire.collection("Requests").doc(DateTime.now().toString()).set({
                              "broblem" : RepairRequestCubit.repair,
                              "location" : GeoPoint(MapCubit.position!.latitude,MapCubit.position!.longitude),
                              "id" : userKey,
                            });
                          }
                        }
                      },
                      child: Text(
                        'التالى',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: myfonts.largfont,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }
}
