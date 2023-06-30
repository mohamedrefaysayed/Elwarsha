import 'package:elwarsha/Constents/colors.dart';
import 'package:elwarsha/Helper/MY_SnackBar.dart';
import 'package:elwarsha/Helper/MyApplication.dart';
import 'package:elwarsha/Presentation/Screens/Main_Screen/MainScreen.dart';
import 'package:elwarsha/business_logic/Cubits/Map/map_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/elwarsha_Info/elwarsha_info_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/map_Picker/map_picker_cubit.dart';
import 'package:elwarsha/global/global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class elwarshaInfo extends StatefulWidget {
  elwarshaInfo({Key? key, this.isregerster}) : super(key: key);

  final isregerster;

  @override
  State<elwarshaInfo> createState() => _elwarshaInfoState();
}

class _elwarshaInfoState extends State<elwarshaInfo> {
  final formkey = GlobalKey<FormState>();

  infoLoading() {
    return Container(
      color: mycolors.first_color,
      margin: const EdgeInsets.only(left: 30, right: 30, top: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              height: myApplication.hightClc(400, context),
              width: myApplication.widthClc(300, context),
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
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
                        SizedBox(
                          height: 35,
                        ),
                      ],
                    );
                  })),
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
        ],
      ),
    );
  }

  @override
  void initState() {
    if (!widget.isregerster) {
      BlocProvider.of<ElwarshaInfoCubit>(context).getInfo(context,userKey);
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => myApplication.keyboardFocus(context),
      child: Scaffold(
        backgroundColor: mycolors.first_color,
        appBar: AppBar(
          leading: !widget.isregerster ? IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: mycolors.secod_color,
            ),
          ) : Container(),
          elevation: 0,
          backgroundColor: mycolors.first_color,
          title: Text(
            'بيانات الورشة',
            style: TextStyle(
              color: mycolors.titleFont,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          color: mycolors.secod_color,
          backgroundColor: mycolors.secod_color.withOpacity(0),
          onRefresh: () async {
            if(!widget.isregerster) {
              if (await myApplication.checkInternet() == true) {
                BlocProvider.of<ElwarshaInfoCubit>(context)
                    .emit(ElwarshaInfoLoading());
                await BlocProvider.of<ElwarshaInfoCubit>(context).getInfo(
                    context,userKey);
              }
            }
          },
          child: BlocBuilder<ElwarshaInfoCubit, ElwarshaInfoState>(
            builder: (context, state) {
              if (state is ElwarshaInfoLoading) {
                return infoLoading();
              } else if (state is ElwarshaInfoFailuer) {
                return myApplication.noInternet(context);
              } else {
                return Form(
                  key: formkey,
                  child: Container(
                    color: mycolors.first_color,
                    child: ListView(
                      children: [
                        SizedBox(
                          height: myApplication.hightClc(50, context),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: TextFormField(
                                      onChanged: (val) {
                                        ElwarshaInfoCubit.warshaName = val;
                                      },
                                      initialValue:
                                      ElwarshaInfoCubit.warshaName ?? "",
                                      keyboardType: TextInputType.text,
                                      textAlign: TextAlign.end,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return '! أدخل اسم الورشة';
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        contentPadding:
                                        const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        focusedBorder:
                                        const OutlineInputBorder(),
                                        hintText: 'أدخل اسم الورشة',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 35,
                                  ),
                                  Text(
                                    'اسم الورشة',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: mycolors.titleFont,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: TextFormField(
                                      onChanged: (val) {
                                        ElwarshaInfoCubit.warshlicense = val;
                                      },
                                      initialValue: ElwarshaInfoCubit.warshlicense ?? "",
                                      keyboardType:
                                      TextInputType.number,
                                      textAlign: TextAlign.end,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return '! أدخل رقم الترخيص';
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        contentPadding:
                                        const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        focusedBorder:
                                        const OutlineInputBorder(),
                                        hintText: 'أدخل رقم الترخيص',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    'رقم الترخيص',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: mycolors.titleFont,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 150,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: mycolors.popColor),
                                      onPressed: () async {
                                        BlocProvider.of<MapPickerCubit>(context)
                                            .loading();
                                        await BlocProvider.of<MapCubit>(context)
                                            .getMyCurrentLocation();
                                        BlocProvider.of<MapPickerCubit>(context)
                                            .mapPicker(context, () {});
                                      },
                                      child: BlocBuilder<MapPickerCubit, MapPickerState>(
                                        builder: (context, state) {
                                          return MapPickerCubit.isloading
                                              ? Container(
                                            height: 25,
                                            width: 25,
                                            child: myApplication
                                                .myloading(context),
                                          )
                                              : ElwarshaInfoCubit.warshaLocation != null
                                              ? Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceEvenly,
                                            children: [
                                              Icon(
                                                Icons.check,
                                                color: mycolors
                                                    .secod_color,
                                              ),
                                              Text(
                                                "تم الاختيار",
                                                style: TextStyle(
                                                    color: mycolors
                                                        .secod_color,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold),
                                              ),
                                            ],
                                          )
                                              : Text(
                                            "اختر الموقع",
                                            style: TextStyle(
                                                color: mycolors
                                                    .titleFont,
                                                fontWeight:
                                                FontWeight.bold),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 70,
                                  ),
                                  Text(
                                    'عنوان الورشة',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: mycolors.titleFont,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Text(
                                'اسم صاحب الورشة',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: mycolors.titleFont,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                onChanged: (val) {
                                  ElwarshaInfoCubit.warshOwnerName = val;
                                },
                                initialValue: ElwarshaInfoCubit.warshOwnerName ?? "",
                                keyboardType: TextInputType.name,
                                textAlign: TextAlign.end,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '! أدخل اسم صاحب الورشة';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: const OutlineInputBorder(),
                                  hintText: 'أدخل اسم صاحب الورشة',
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Text(
                                'الوصف',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: mycolors.titleFont,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              BlocBuilder<MapPickerCubit, MapPickerState>(
                                builder: (context, state) {
                                  return TextFormField(
                                    onChanged: (val) {
                                      ElwarshaInfoCubit.warshDesc = val;
                                      BlocProvider.of<MapPickerCubit>(context)
                                          .changeState();
                                    },
                                    initialValue: ElwarshaInfoCubit.warshDesc ?? "",
                                    maxLines: null,
                                    minLines: 6,
                                    keyboardType: TextInputType.name,
                                    textAlign: TextAlign.end,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return '! أدخل الوصف';
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      counterText: ElwarshaInfoCubit.warshDesc != null ?  ElwarshaInfoCubit
                                          .warshDesc!.length
                                          .toString() : "0",
                                      counterStyle:
                                      TextStyle(color: Colors.white),
                                      contentPadding:
                                      const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: const OutlineInputBorder(),
                                      hintText: '..... أدخل الوصف',
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white),
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                if (ElwarshaInfoCubit.warshaLocation != null) {
                                  BlocProvider.of<ElwarshaInfoCubit>(context)
                                      .setInfo();
                                  if (widget.isregerster) {
                                    myApplication.navigateToRemove(
                                        context, MainScreen());
                                  } else {
                                    Navigator.pop(context);
                                  }
                                  showTopSnackBar(
                                      Overlay.of(context),
                                      MySnackBar.success(
                                        message: "! تم الحفظ",
                                      ));
                                } else {
                                  showTopSnackBar(
                                      Overlay.of(context),
                                      MySnackBar.error(
                                        message: "! قم بأختيار مكان الورشة",
                                      ));
                                }
                              }
                            },
                            child: Text(
                              widget.isregerster ? 'متابعة' : "حفظ",
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
      ),
    );
  }
}