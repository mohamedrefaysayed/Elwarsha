// ignore_for_file: non_constant_identifier_names

import 'package:elwarsha/business_logic/Cubits/Team_Info/team_info_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Constents/colors.dart';
import '../Constents/fontsize.dart';
import '../Helper/MyApplication.dart';
import 'package:flutter/material.dart';

class TeamInfo extends StatelessWidget {
   TeamInfo({Key? key}) : super(key: key);

  String Substract =
      " الورشة تطبيق ثوري مصمم لمساعدة السائقين عندما يواجهون مشاكل في السيارة أثناء السير على الطريق .\n\nيهدف التطبيق إلى توفير حل سلس وفعال لأعطال السيارات من خلال ربط السائقين بالورش الميكانيكية القريبة أو مراكز الصيانة. \n\nتشمل الميزات الأساسية للتطبيق القدرة على طلب ميكانيكي متنقل للحضور إلى موقع السائق أو شاحنة سحب لنقل سيارته إلى ورشة الإصلاح. \n\nتعد تحديثات التطبيق في الوقت الفعلي ميزة بارزة ، حيث توفر للسائقين جميع المعلومات التي يحتاجونها لاتخاذ قرارات مستنيرة بشأن خطواتهم التالية. \n\nيمكن للمستخدمين تتبع وقت الوصول التقريبي والمسافة والمسار للمصلح ، وهو أمر مفيد بشكل خاص في حالات الطوارئ. \n\nواجهة التطبيق سهلة الاستخدام تجعله في متناول السائقين من جميع الأعمار والقدرات التقنية ، مما يجعله أداة مفيدة لأي شخص يمتلك سيارة.\n\nستحدث هذه التقنية ثورة في الطريقة التي يسعى بها الناس للحصول على المساعدة الميكانيكية أثناء السير على الطريق ، مما يجعل العملية أسرع وأكثر كفاءة وأقل إجهادًا. \n\nيوفر التطبيق حلاً مناسبًا وموثوقًا لمشاكل السيارات الشائعة ، مما يقلل من الإزعاج والاضطراب الناجم عن الأعطال غير المتوقعة. \n\nبشكل عام ، .يعد هذا التطبيق بمثابة تغيير لقواعد اللعبة بالنسبة للسائقين ، حيث يوفر طريقة بسيطة وفعالة للحصول على المساعدة التي يحتاجون إليها عندما هم في أمس الحاجة إليها.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mycolors.popColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_sharp,
            color: mycolors.secod_color,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'معلومات عن التطبيق',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: myApplication.widthClc(25, context),
            vertical: myApplication.widthClc(30, context)),
        color: mycolors.popColor,
        child: BlocBuilder<TeamInfoCubit, TeamInfoState>(
  builder: (context, state) {
    return ListView(
          children: [
            CircleAvatar(
              radius: 75,
              backgroundColor: Colors.transparent,
              child: Stack(
                children: [
                  SizedBox(
                    height: myApplication.hightClc(255, context),
                    width: myApplication.widthClc(255, context),
                    child: Image.asset(
                      "assets/images/Icon.png",
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: myApplication.hightClc(250, context),
                    width: myApplication.widthClc(250, context),
                    child: Image.asset(
                      "assets/images/Icon.png",
                      color: mycolors.popColor,
                    ),
                  ),
                  SizedBox(
                    height: myApplication.hightClc(245, context),
                    width: myApplication.widthClc(245, context),

                    child: Image.asset(
                      "assets/images/Icon.png",
                      color: mycolors.secod_color,

                    ),
                  ),
                  SizedBox(
                    height: myApplication.hightClc(245, context),
                    width: myApplication.widthClc(245, context),

                    child: Image.asset(
                      "assets/images/blackScrew.png",
                      color: mycolors.popColor,

                    ),
                  ),


                ],
              ),
            ),
            SizedBox(
              height: myApplication.hightClc(30, context),
            ),
            InkWell(
              onTap: () {
                BlocProvider.of<TeamInfoCubit>(context).reversappinfo();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "معلومات عن التطبيق",
                    style: TextStyle(
                        fontSize: myfonts.largfont,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Icon(
                    TeamInfoCubit.appinfo ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: Colors.white,
                    size: myApplication.widthClc(30, context),
                  ),
                ],
              ),
            ),
            Text(
              "__________________________________________",
              style:
                  TextStyle(color: Colors.white, fontSize: myfonts.smallfont),
            ),
            TeamInfoCubit.appinfo
                ? Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(10),
                          color: mycolors.first_color,
                          child: Text(
                            Substract,
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                            textDirection: TextDirection.rtl,
                          )),
                      Text(
                        "__________________________________________",
                        style: TextStyle(
                            color: Colors.white, fontSize: myfonts.smallfont),
                      ),
                    ],
                  )
                : const SizedBox(),
            SizedBox(
              height: myApplication.hightClc(50, context),
            ),
            Text(
              "Developers",
              style: TextStyle(
                  fontSize: myfonts.largfont,
                  fontWeight: FontWeight.bold,
                  color: mycolors.secod_color),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: myApplication.hightClc(30, context),
            ),
            InkWell(
                onTap: () {
                  BlocProvider.of<TeamInfoCubit>(context).reversuiinfo();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "UI/UX designer",
                      style: TextStyle(
                          fontSize: myfonts.largfont,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Icon(
                      TeamInfoCubit.uiinfo ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      color: Colors.white,
                      size: myApplication.widthClc(30, context),
                    ),
                  ],
                )),
            Text(
              "__________________________________________",
              style:
                  TextStyle(color: Colors.white, fontSize: myfonts.smallfont),
            ),
            TeamInfoCubit.uiinfo
                ? Column(
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        color: mycolors.first_color,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.transparent,
                              child: SizedBox(
                                  width: 90,
                                  height: 90,
                                  child: ClipOval(
                                    child: Image.asset(
                                      "assets/images/dev/bayan.png",
                                    ),
                                  )),
                            ),
                            Text(
                              "بيان آدم باشا",
                              style: TextStyle(
                                  fontSize: myfonts.largfont,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "__________________________________________",
                        style: TextStyle(
                            color: Colors.white, fontSize: myfonts.smallfont),
                      ),
                    ],
                  )
                : const SizedBox(),
            SizedBox(
              height: myApplication.hightClc(30, context),
            ),
            InkWell(
                onTap: () {
                  BlocProvider.of<TeamInfoCubit>(context).reversflutterinfo();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Flutter developers",
                      style: TextStyle(
                          fontSize: myfonts.largfont,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Icon(
                      TeamInfoCubit.flutterinfo ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      color: Colors.white,
                      size: myApplication.widthClc(30, context),
                    ),
                  ],
                )),
            Text(
              "__________________________________________",
              style:
                  TextStyle(color: Colors.white, fontSize: myfonts.smallfont),
            ),
            TeamInfoCubit.flutterinfo
                ? Column(
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        color: mycolors.first_color,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.transparent,
                              child: SizedBox(
                                  width: 90,
                                  height: 90,
                                  child: ClipOval(
                                    child: Image.asset(
                                      "assets/images/dev/mohamed.png",
                                    ),
                                  )),
                            ),
                            Text(
                              "محمد رفاعى سيد",
                              style: TextStyle(
                                  fontSize: myfonts.largfont,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: myApplication.hightClc(5, context),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        color: mycolors.first_color,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.transparent,
                              child: SizedBox(
                                  width: 90,
                                  height: 90,
                                  child: ClipOval(
                                    child: Image.asset(
                                      "assets/images/dev/aya.png",
                                    ),
                                  )),
                            ),
                            Text(
                              "آية جمعة جبريل",
                              style: TextStyle(
                                  fontSize: myfonts.largfont,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: myApplication.hightClc(5, context),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        color: mycolors.first_color,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.transparent,
                              child: SizedBox(
                                  width: 90,
                                  height: 90,
                                  child: ClipOval(
                                    child: Image.asset(
                                      "assets/images/dev/eman.png",
                                    ),
                                  )),
                            ),
                            Text(
                              "إيمان مالك",
                              style: TextStyle(
                                  fontSize: myfonts.largfont,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "__________________________________________",
                        style: TextStyle(
                            color: Colors.white, fontSize: myfonts.smallfont),
                      ),
                    ],
                  )
                : const SizedBox(),
            SizedBox(
              height: myApplication.hightClc(30, context),
            ),
            InkWell(
                onTap: () {
                  BlocProvider.of<TeamInfoCubit>(context).reversfrontinfo();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Front-end developers",
                      style: TextStyle(
                          fontSize: myfonts.largfont,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Icon(
                      TeamInfoCubit.frontinfo ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      color: Colors.white,
                      size: myApplication.widthClc(30, context),
                    ),
                  ],
                )),
            Text(
              "__________________________________________",
              style:
                  TextStyle(color: Colors.white, fontSize: myfonts.smallfont),
            ),
            TeamInfoCubit.frontinfo
                ? Column(
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        color: mycolors.first_color,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.transparent,
                              child: SizedBox(
                                  width: 90,
                                  height: 90,
                                  child: ClipOval(
                                    child: Image.asset(
                                      "assets/images/dev/heba.png",
                                    ),
                                  )),
                            ),
                            Text(
                              "هبة محمد",
                              style: TextStyle(
                                  fontSize: myfonts.largfont,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: myApplication.hightClc(5, context),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        color: mycolors.first_color,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.transparent,
                              child: SizedBox(
                                  width: 90,
                                  height: 90,
                                  child: ClipOval(
                                    child: Image.asset(
                                      "assets/images/dev/elwahsh.png",
                                    ),
                                  )),
                            ),
                            Text(
                              "آية أحمد عبدالنبى",
                              style: TextStyle(
                                  fontSize: myfonts.largfont,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "__________________________________________",
                        style: TextStyle(
                            color: Colors.white, fontSize: myfonts.smallfont),
                      ),
                    ],
                  )
                : const SizedBox(),
            SizedBox(
              height: myApplication.hightClc(30, context),
            ),
            InkWell(
                onTap: () {
                  BlocProvider.of<TeamInfoCubit>(context).reversbackinfo();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Back-end developers",
                      style: TextStyle(
                          fontSize: myfonts.largfont,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Icon(
                      TeamInfoCubit.backinfo ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      color: Colors.white,
                      size: myApplication.widthClc(30, context),
                    ),
                  ],
                )),
            Text(
              "__________________________________________",
              style:
                  TextStyle(color: Colors.white, fontSize: myfonts.smallfont),
            ),
            TeamInfoCubit.backinfo
                ? Column(
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        color: mycolors.first_color,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.transparent,
                              child: SizedBox(
                                  width: 90,
                                  height: 90,
                                  child: ClipOval(
                                    child: Image.asset(
                                      "assets/images/dev/sara.png",
                                    ),
                                  )),
                            ),
                            Text(
                              "سارة محمد سرور",
                              style: TextStyle(
                                  fontSize: myfonts.largfont,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: myApplication.hightClc(5, context),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        color: mycolors.first_color,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.transparent,
                              child: SizedBox(
                                  width: 90,
                                  height: 90,
                                  child: ClipOval(
                                    child: Image.asset(
                                      "assets/images/dev/yasmin.png",
                                    ),
                                  )),
                            ),
                            Text(
                              "ياسمين محمد أحمد",
                              style: TextStyle(
                                  fontSize: myfonts.largfont,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "__________________________________________",
                        style: TextStyle(
                            color: Colors.white, fontSize: myfonts.smallfont),
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        );
  },
),
      ),
    );
  }
}
