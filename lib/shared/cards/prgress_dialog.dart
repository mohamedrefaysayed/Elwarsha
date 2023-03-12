import 'package:flutter/material.dart';

import '../../Constents/colors.dart';
import '../../Constents/fontsize.dart';

class progressdialog extends StatelessWidget {
  String? message;
  progressdialog({this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black12.withOpacity(0.0),
      child: Container(
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: mycolors.popColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              SizedBox(width: 10),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(mycolors.secod_color),
              ),
              SizedBox(width: 40),
              Text(
                message!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: myfonts.smallfont,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
