import '../auth/Login_Screen.dart';

import '../../../../Constents/colors.dart';
import '../../../../Constents/fontsize.dart';
import '../../../../Helper/MyApplication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Sane3yData extends StatelessWidget {
  const Sane3yData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mycolors.first_color,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_sharp,
            color: mycolors.secod_color,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'بيانات المصلح',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        color: mycolors.first_color,
        child: ListView(
          children: [
            const SizedBox(
              height: 35,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Clipboard.setData(const ClipboardData(
                      text: " رقم الهاتف : 01090287571"
                          "الاسم : ابو حموده",
                    ));
                    myApplication.showToast(
                        text: "تم النسخ", color: Colors.white);
                  },
                  // child: QrImage(
                  //   data: "رقم الهاتف : 01090287571 \n الاسم : ابو حموده"
                  //       "",
                  //   version: QrVersions.auto,
                  //   size: 180.0,
                  //   backgroundColor: Colors.white,
                  // ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Text(
                  'اسم المصلح : أبو حميد',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: myfonts.smallfont,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'اسم الورشة : أم حميد',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: myfonts.smallfont,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '__________________________',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: myfonts.smallfont,
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Text(
                  'سعر القطعة  : 200 جنية ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: myfonts.smallfont,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'سعر التركيب  :  100 جنية',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: myfonts.smallfont,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'المبلغ الكلى   :  300 جنية',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: myfonts.smallfont,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () {
                  myApplication.push_up(context,  LoginScreen());
                },
                child: const Text(
                  'موافق',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
          ],
        ),
      ),
    );
  }
}
