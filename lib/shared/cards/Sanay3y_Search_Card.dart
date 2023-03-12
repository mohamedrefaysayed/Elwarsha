import 'package:flutter/material.dart';

import '../../Constents/colors.dart';

class Sanay3ySearchCard extends StatelessWidget {
  const Sanay3ySearchCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          color: mycolors.first_color,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "الاسم",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'الوظيفة',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 55,
            ),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.transparent,
              child: SizedBox(
                  width: 65,
                  height: 65,
                  child: ClipOval(
                    child: Image.network(
                      "http://t0.gstatic.com/licensed-image?q=tbn:ANd9GcRfqbrNkFoQ9fHlVLzspRucA3IGO41dFfxBruXwy_WED3gyp_iMljq9_8bUQjb1VOTEDt1oISRM1io1Qoo5WlQ",
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
