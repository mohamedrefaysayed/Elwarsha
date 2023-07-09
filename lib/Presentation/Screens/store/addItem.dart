// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:io';

import 'package:elwarsha/Constents/colors.dart';
import 'package:elwarsha/Helper/MY_SnackBar.dart';
import 'package:elwarsha/Helper/MyApplication.dart';
import 'package:elwarsha/business_logic/Cubits/addItem/add_item_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/elwarsha_Info/elwarsha_info_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/map_Picker/map_picker_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class addItem extends StatelessWidget {
  addItem({Key? key}) : super(key: key);

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => myApplication.keyboardFocus(context),
      child: Scaffold(
        backgroundColor: mycolors.first_color,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: mycolors.secod_color,
            ),
          ),
          elevation: 0,
          backgroundColor: mycolors.first_color,
          title: Text(
            'إضافة قطعة',
            style: TextStyle(
              color: mycolors.titleFont,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<AddItemCubit, AddItemState>(
          builder: (context, state) {
            return Form(
              key: formkey,
              child: Container(
                color: mycolors.first_color,
                child: ListView(
                  children: [
                    SizedBox(
                      height: myApplication.hightClc(50, context),
                    ),
                    GestureDetector(
                      onTap: () {
                        myApplication.imageDialog(context, "spare");
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: AddItemCubit.image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(
                                  File(AddItemCubit.image!.path),
                                  width: myApplication.widthClc(300, context),
                                  height: myApplication.hightClc(300, context),
                                  fit: BoxFit.fill,
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: mycolors.popColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: myApplication.widthClc(300, context),
                                height: myApplication.hightClc(300, context),
                                child: Center(
                                    child: Text(
                                  "اضف صوره",
                                  style: TextStyle(
                                      fontSize:
                                          myApplication.widthClc(20, context)),
                                )),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: myApplication.hightClc(50, context),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'صينى',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: mycolors.titleFont,
                              ),
                            ),
                            const SizedBox(
                              width: 65,
                            ),
                            Transform.scale(
                              scale: 2,
                              child: Checkbox(
                                  side: BorderSide(
                                    color: Colors.white,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  activeColor: mycolors.popColor,
                                  checkColor: mycolors.secod_color,
                                  value: AddItemCubit.type == "china"
                                      ? true
                                      : false,
                                  onChanged: (val) {
                                    AddItemCubit.type = "china";
                                    BlocProvider.of<AddItemCubit>(context)
                                        .emit(AddItemInitial());
                                  }),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'مستعمل',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: mycolors.titleFont,
                              ),
                            ),
                            const SizedBox(
                              width: 65,
                            ),
                            Transform.scale(
                              scale: 2,
                              child: Checkbox(
                                  side: BorderSide(
                                    color: Colors.white,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  activeColor: mycolors.popColor,
                                  checkColor: mycolors.secod_color,
                                  value: AddItemCubit.type == "used"
                                      ? true
                                      : false,
                                  onChanged: (val) {
                                    AddItemCubit.type = "used";
                                    BlocProvider.of<AddItemCubit>(context)
                                        .emit(AddItemInitial());
                                  }),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'اصلى',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: mycolors.titleFont,
                              ),
                            ),
                            const SizedBox(
                              width: 65,
                            ),
                            Transform.scale(
                              scale: 2,
                              child: Checkbox(
                                  side: BorderSide(
                                    color: Colors.white,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  activeColor: mycolors.popColor,
                                  checkColor: mycolors.secod_color,
                                  value: AddItemCubit.type == "original"
                                      ? true
                                      : false,
                                  onChanged: (val) {
                                    AddItemCubit.type = "original";
                                    BlocProvider.of<AddItemCubit>(context)
                                        .emit(AddItemInitial());
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
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
                                    AddItemCubit.name = val;
                                  },
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.end,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '! أدخل اسم القطعة';
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
                                    hintText: 'أدخل اسم القطعة',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 35,
                              ),
                              Text(
                                'اسم القطعة',
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
                                    AddItemCubit.tradeMark = val;
                                  },
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.end,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '! أدخل اسم الماركة';
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
                                    hintText: 'أدخل اسم الماركة',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 35,
                              ),
                              Text(
                                'اسم الماركة',
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
                                    AddItemCubit.price = int.parse(val);
                                  },
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.end,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '! أدخل سعر القطعة';
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
                                    hintText: 'أدخل سعر القطعة',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Text(
                                'سعر القطعة',
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
                                    AddItemCubit.fixePrice = int.parse(val);
                                  },
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.end,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '! أدخل سعر التصليح';
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
                                    hintText: 'أدخل سعر التصليح',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Text(
                                'سعر التصليح',
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
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Transform.scale(
                                scale: 2,
                                child: Checkbox(
                                    side: BorderSide(
                                      color: Colors.white,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    activeColor: mycolors.popColor,
                                    checkColor: mycolors.secod_color,
                                    value: AddItemCubit.discount,
                                    onChanged: (val) {
                                      AddItemCubit.discount = val!;
                                      BlocProvider.of<AddItemCubit>(context)
                                          .emit(AddItemInitial());
                                    }),
                              ),
                              const SizedBox(
                                width: 65,
                              ),
                              Text(
                                'عرض على القطعة ؟',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: mycolors.titleFont,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          AddItemCubit.discount
                              ? Column(
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          child: TextFormField(
                                            onChanged: (val) {
                                              AddItemCubit.discountAmount =
                                                  int.parse(val);
                                            },
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.end,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return '! أدخل سعر التخفيض';
                                              } else {
                                                return null;
                                              }
                                            },
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              focusedBorder:
                                                  const OutlineInputBorder(),
                                              hintText:
                                                  'أدخل السعر بعد التخفيض',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 25,
                                        ),
                                        Text(
                                          'سعر التخفيض',
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
                                  ],
                                )
                              : Container(),
                          Text(
                            'التفاصيل',
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
                                  AddItemCubit.details = val;
                                  BlocProvider.of<MapPickerCubit>(context)
                                      .changeState();
                                },
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
                                  counterText:
                                      ElwarshaInfoCubit.warshDesc != null
                                          ? ElwarshaInfoCubit.warshDesc!.length
                                              .toString()
                                          : "0",
                                  counterStyle: TextStyle(color: Colors.white),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: const OutlineInputBorder(),
                                  hintText: '..... أدخل الوصف',
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            if (AddItemCubit.image != null) {
                              if(!AddItemCubit.discount){
                                AddItemCubit.discountAmount = 0;
                              }
                              await BlocProvider.of<AddItemCubit>(context)
                                  .addItem();
                              Navigator.pop(context);
                            } else {
                              showTopSnackBar(
                                  Overlay.of(context),
                                  MySnackBar.error(
                                      message: "اختر صورة للقطعة"));
                            }
                          }
                        },
                        child: BlocConsumer<AddItemCubit, AddItemState>(
                          listener: (context,state){
                            if(state is AddItemSuccess){
                              showTopSnackBar(Overlay.of(context), MySnackBar.success(message: "تمت الإضافة بنجاح"));
                            }else if (state is AddItemFailuer){
                              showTopSnackBar(Overlay.of(context), MySnackBar.error(message: "حدث خطأ"));
                            }
                          },
                          builder: (context, state) {
                            if(state is AddItemloading){
                              return CircularProgressIndicator();
                            }else {
                              return Text(
                                "إضافة",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              );
                            }
                          },
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
          },
        ),
      ),
    );
  }
}
