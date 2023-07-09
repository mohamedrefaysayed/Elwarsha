import 'dart:io';
import 'package:elwarsha/Constents/colors.dart';
import 'package:elwarsha/Constents/fontsize.dart';
import 'package:elwarsha/Helper/MyApplication.dart';
import 'package:elwarsha/business_logic/Cubits/imageLabeling/image_labling_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class imagelabeling extends StatefulWidget {
  imagelabeling({Key? key}) : super(key: key);

  @override
  State<imagelabeling> createState() => _imagelabelingState();
}

class _imagelabelingState extends State<imagelabeling> {
  @override


  void initState() {
    BlocProvider.of<ImageLablingCubit>(context).loadmodel();
    super.initState();
  }


  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        if(ImageLablingCubit.isprocess){
          BlocProvider.of<ImageLablingCubit>(context).reset();
        return false;
        }
             return true;
      },
      child: Scaffold(
        backgroundColor: mycolors.first_color,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: mycolors.first_color,
          title: Text("التحقق من القطعة",
              style: TextStyle(
                  fontSize: myfonts.largfont,
                  color: mycolors.titleFont,
                  fontWeight: FontWeight.bold)),
          leading: IconButton(
            onPressed: () {
              ImageLablingCubit.isprocess
              ? BlocProvider.of<ImageLablingCubit>(context).reset()
              : Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: mycolors.secod_color,
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(myApplication.widthClc(20, context)),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              BlocBuilder<ImageLablingCubit, ImageLablingState>(
                builder: (context, state) {
                  return ImageLablingCubit.image != null
                      ? Container(
                          height: myApplication.hightClc(350, context),
                          width: myApplication.widthClc(350, context),
                          child: Image.file(File(ImageLablingCubit.image!.path)),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: myApplication.hightClc(350, context),
                          width: myApplication.widthClc(350, context),
                        );
                },
              ),
              SizedBox(
                height: myApplication.hightClc(50, context),
              ),
              BlocBuilder<ImageLablingCubit, ImageLablingState>(
                builder: (context, state) {
                  if(state is ImageLablingInitial){
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white),
                              //if user click this button, user can upload image from gallery
                              onPressed: () =>
                                  BlocProvider.of<ImageLablingCubit>(context)
                                      .getImage(ImageSource.gallery, context),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.image,
                                    color: mycolors.secod_color,
                                    size: 35,
                                  ),
                                  Text(
                                    'المعرض',
                                    style: TextStyle(
                                        color: mycolors.first_color,
                                        fontSize: myfonts.smallfont),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white),
                              //if user click this button. user can upload image from camera
                              onPressed: () =>
                                  BlocProvider.of<ImageLablingCubit>(context)
                                      .getImage(ImageSource.camera, context),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.camera,
                                    color: mycolors.secod_color,
                                    size: 35,
                                  ),
                                  Text(
                                    'الكاميرا',
                                    style: TextStyle(
                                        color: mycolors.first_color,
                                        fontSize: myfonts.smallfont),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: myApplication.hightClc(80, context),
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: ()  =>  BlocProvider.of<ImageLablingCubit>(context).ProcessImage(context),
                            child: Text(
                              "معالجة",
                              style: TextStyle(
                                  color: Colors.black, fontSize: myfonts.largfont),
                            ),
                          ),
                        ),
                      ],
                    );
                  }else{
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(ImageLablingCubit.confidenc,style: TextStyle(color: mycolors.secod_color,fontSize: myApplication.widthClc(25, context)),),
                        Text(ImageLablingCubit.output,style: TextStyle(color: Colors.white,fontSize: myApplication.widthClc(30, context)),),
                      ],
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
