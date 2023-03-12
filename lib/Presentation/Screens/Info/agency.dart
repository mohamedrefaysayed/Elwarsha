import 'package:elwarsha/Presentation/Screens/Main_Screen/MainScreen.dart';
import 'package:flutter/material.dart';
import '../../../../../global/global.dart';
import '../../../../Constents/colors.dart';
import '../../../../Helper/MyApplication.dart';

// ignore: camel_case_types
class agency_ditails extends StatelessWidget {
  agency_ditails({Key? key, this.iscustom}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final iscustom;

  final formkey = GlobalKey<FormState>();

  // ignore: non_constant_identifier_names
  final BranchName = TextEditingController();

  // ignore: non_constant_identifier_names
  final BranchAddress = TextEditingController();

  // ignore: non_constant_identifier_names
  final BranchNumber = TextEditingController();

  saveCarInfo() {
    ffire.collection("customers").doc(userKey).collection("car").doc("agecy").set({
      "BranchName": BranchName.text.trim(),
      "BranchAddress": BranchAddress.text.trim(),
      "BranchNumber": BranchNumber.text.trim(),
    });
  }

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
          'تابعة للتوكيل',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: formkey,
        child: Container(
          color: mycolors.first_color,
          child: ListView(
            children: [
              const SizedBox(
                height: 80,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'اسم الفرع',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: BranchName,
                      textAlign: TextAlign.end,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '! أدخل اسم الفرع';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: const OutlineInputBorder(),
                        hintText: 'أدخل اسم الفرع',
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'عنوان الفرع',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: BranchAddress,
                      textAlign: TextAlign.end,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '! أدخل عنوان الفرع';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: const OutlineInputBorder(),
                        hintText: 'أدخل عنوان الفرع',
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'رقم التلفون',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: BranchNumber,
                      textAlign: TextAlign.end,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '! أدخل رقم التلفون';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: const OutlineInputBorder(),
                        hintText: 'أدخل رقم التلفون',
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      if (iscustom == true) {
                        isinrequestmode = true;
                      }
                      myApplication.keyboardFocus(context);
                      saveCarInfo();
                      myApplication.navigateToRemove(context, const MainScreen());
                    }
                  },
                  child: const Text(
                    'حفظ',
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
      ),
    );
  }
}
