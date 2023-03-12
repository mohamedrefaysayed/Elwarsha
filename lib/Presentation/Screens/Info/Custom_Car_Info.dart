import 'package:elwarsha/Presentation/Screens/Main_Screen/MainScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../Constents/colors.dart';
import '../../../../Helper/MyApplication.dart';
import '../../../../global/global.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'agency.dart';

// ignore: constant_identifier_names
const List<String> Cars = <String>[" ", 'مرسيدس', 'bmw', 'هيونداى', 'هوندا'];
// ignore: constant_identifier_names
const List<String> ModelYears = <String>[" ", '2010', '2020', '2022', '2023'];
// ignore: constant_identifier_names
const List<String> EnginCapactys = <String>[
  " ",
  '1600',
  '2000',
  '2500',
  '3000',
  '1115',
  '41515',
  '15115',
  '2245'
];
// ignore: constant_identifier_names
const List<String> EnginPowers = <String>[" ", '500', '1000', '900', '300'];
// ignore: constant_identifier_names
const List<String> StructureTypes = <String>[" ", 'سيدان', 'هاتشباك'];

class CustomCarInfo extends StatefulWidget {
  const CustomCarInfo({Key? key, this.email, this.password}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final email;
  // ignore: prefer_typing_uninitialized_variables
  final password;

  @override
  State<CustomCarInfo> createState() => _CustomCarInfoState();
}

class _CustomCarInfoState extends State<CustomCarInfo> {
  final formkey = GlobalKey<FormState>();

  //show popup dialog

  // ignore: non_constant_identifier_names
  String Car = Cars.first;
  // ignore: non_constant_identifier_names
  String Model = ModelYears.first;
  // ignore: non_constant_identifier_names
  String EnginCap = EnginCapactys.first;
  // ignore: non_constant_identifier_names
  String EnginPow = EnginPowers.first;
  // ignore: non_constant_identifier_names
  String StructType = StructureTypes.first;

  String agency = 'n';

  // ignore: non_constant_identifier_names
  final BranchName = TextEditingController();
  // ignore: non_constant_identifier_names
  final BranchAddress = TextEditingController();
  // ignore: non_constant_identifier_names
  final BranchNumber = TextEditingController();

  saveCarInfo() {
    Map custcarMap = {
      "type": Car,
      "Model": Model,
      "EnginCap": EnginCap,
      "EnginPow": EnginPow,
      "StructType": StructType,
      "BranchName": BranchName.text.trim(),
      "BranchAddress": BranchAddress.text.trim(),
      "BranchNumber": BranchNumber.text.trim(),
    };

    DatabaseReference custref =
        FirebaseDatabase.instance.ref().child("customers");
    custref
        .child(FirebaseAuth.instance.currentUser != null
        ? FirebaseAuth.instance.currentUser!.uid
        : GoogleSignIn().currentUser != null
        ? GoogleSignIn().currentUser!.id
        : FacebookAuthProvider.PROVIDER_ID)
        .child("car_details")
        .set(custcarMap);
  }

  String pic = "assets/images/car.png";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          myApplication.keyboardFocus(context);
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: mycolors.first_color,
            title: const Text(
              'الورشة',
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
                  Container(
                    margin: const EdgeInsets.only(left: 30, right: 30, top: 25),
                    child: Column(
                      children: [
                        SizedBox(
                            height: 190,
                            width: 340,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.asset(pic),
                            )),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    dropdownColor: mycolors.popColor,
                                    alignment: Alignment.centerRight,
                                    menuMaxHeight: 300,
                                    value: Car,
                                    iconSize: 25,
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: mycolors.secod_color,
                                    ),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                    elevation: 16,
                                    underline: Container(
                                      height: 2,
                                      color: Colors.white,
                                    ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        Car = value!;
                                        if (Car == "bmw") {
                                          pic = "assets/images/bmw.png";
                                        } else if (Car == "مرسيدس") {
                                          pic = "assets/images/marcedec.png";
                                        } else {
                                          pic = "assets/images/car.png";
                                        }
                                      });
                                    },
                                    items: Cars.map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        alignment: Alignment.center,
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                const SizedBox(
                                  width: 35,
                                ),
                                const Text(
                                  'ماركة السيارة',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    dropdownColor: mycolors.popColor,
                                    alignment: Alignment.centerRight,
                                    menuMaxHeight: 300,
                                    value: Model,
                                    iconSize: 25,
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: mycolors.secod_color,
                                    ),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                    elevation: 16,
                                    underline: Container(
                                      height: 2,
                                      color: Colors.white,
                                    ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        Model = value!;
                                      });
                                    },
                                    items: ModelYears.map<
                                            DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        alignment: Alignment.center,
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                const SizedBox(
                                  width: 52,
                                ),
                                const Text(
                                  'موديل عام',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    dropdownColor: mycolors.popColor,
                                    alignment: Alignment.centerRight,
                                    menuMaxHeight: 300,
                                    value: EnginCap,
                                    iconSize: 25,
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: mycolors.secod_color,
                                    ),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                    elevation: 16,
                                    underline: Container(
                                      height: 2,
                                      color: Colors.white,
                                    ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        EnginCap = value!;
                                      });
                                    },
                                    items: EnginCapactys.map<
                                            DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        alignment: Alignment.center,
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                const Text(
                                  ' سعة المحرك',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    dropdownColor: mycolors.popColor,
                                    alignment: Alignment.centerRight,
                                    menuMaxHeight: 300,
                                    value: EnginPow,
                                    iconSize: 25,
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: mycolors.secod_color,
                                    ),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                    elevation: 16,
                                    underline: Container(
                                      height: 2,
                                      color: Colors.white,
                                    ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        EnginPow = value!;
                                      });
                                    },
                                    items: EnginPowers.map<
                                            DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        alignment: Alignment.center,
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                const SizedBox(
                                  width: 46,
                                ),
                                const Text(
                                  'قوة المحرك',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    dropdownColor: mycolors.popColor,
                                    alignment: Alignment.centerRight,
                                    menuMaxHeight: 300,
                                    value: StructType,
                                    iconSize: 25,
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: mycolors.secod_color,
                                    ),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                    elevation: 16,
                                    underline: Container(
                                      height: 2,
                                      color: Colors.white,
                                    ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        StructType = value!;
                                      });
                                    },
                                    items: StructureTypes.map<
                                            DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        alignment: Alignment.center,
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                const SizedBox(
                                  width: 53,
                                ),
                                const Text(
                                  'نوع الهيكل',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 28,
                            ),
                            const Text(
                              'تابعة للتوكيل ؟',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'لا',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Radio(
                                    value: "n",
                                    groupValue: agency,
                                    fillColor: MaterialStateColor.resolveWith(
                                        (states) => mycolors.secod_color),
                                    onChanged: (val) {
                                      setState(() {
                                        agency = val!;
                                      });
                                    }),
                                const SizedBox(
                                  width: 80,
                                ),
                                const Text(
                                  'نعم',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Radio(
                                    value: "y",
                                    groupValue: agency,
                                    fillColor: MaterialStateColor.resolveWith(
                                        (states) => mycolors.secod_color),
                                    onChanged: (val) {
                                      setState(() {
                                        agency = val!;
                                      });
                                    }),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      onPressed: () {
                        if (agency == "y") {
                          saveCarInfo();
                          myApplication.push_up(
                              context,
                              agency_ditails(
                                iscustom: true,
                              ));
                        } else {
                          isinrequestmode = true;
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
        ));
  }
}
