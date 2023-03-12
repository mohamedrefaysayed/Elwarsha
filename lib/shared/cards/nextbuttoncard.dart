import 'package:flutter/material.dart';

class nextcard extends StatelessWidget {
  const nextcard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary : Colors.white ),
        onPressed: (){},
        child: Text('التالى',style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),),
      ),
    )
    ;
  }
}
